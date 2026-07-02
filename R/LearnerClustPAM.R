#' @title Partitioning Around Medoids Clustering Learner
#'
#' @name mlr_learners_clust.pam
#'
#' @description
#' Partitioning Around Medoids (PAM) clustering.
#' Calls [cluster::pam()] from package \CRANpkg{cluster}.
#'
#' The `k` parameter is set to 2 by default since [cluster::pam()] doesn't have a default value for the number of
#' clusters. The predict method uses [clue::cl_predict()] to compute the cluster memberships for new data.
#' Since [clue::cl_predict()] does not support standardization, `stand = TRUE` is handled by the learner itself: the
#' data is standardized before training (as [cluster::pam()] would do internally) and the same scaling is applied to
#' new data at predict time. The fitted medoids are reported in the original data units, like [cluster::pam()] does.
#'
#' @section Initial parameter values:
#' - `keep.diss`:
#'   - Actual default: `n < 100`, where `n` is the number of observations.
#'   - Adjusted default: `FALSE`.
#'   - Reason for change: Avoid storing the dissimilarity matrix in the model to save memory.
#' - `keep.data`:
#'   - Actual default: `TRUE`.
#'   - Adjusted default: `FALSE`.
#'   - Reason for change: Avoid storing the training data in the model to save memory.
#'
#' @templateVar id clust.pam
#' @template learner
#'
#' @references
#' `r format_bib("reynolds2006clustering", "schubert2019faster")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustPAM = R6Class(
  "LearnerClustPAM",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("train", "required")),
        metric = p_fct(c("euclidean", "manhattan"), default = "euclidean", tags = "train"),
        medoids = p_uty(
          default = NULL,
          tags = "train",
          custom_check = crate(function(x) check_integerish(x, null.ok = TRUE))
        ),
        nstart = p_int(1L, default = 1L, tags = "train"),
        stand = p_lgl(default = FALSE, tags = "train"),
        do.swap = p_lgl(default = TRUE, tags = "train"),
        keep.diss = p_lgl(tags = "train"),
        keep.data = p_lgl(default = TRUE, tags = "train"),
        pamonce = p_uty(
          default = FALSE,
          tags = "train",
          custom_check = crate(function(x) check_flag(x) %check||% check_int(x, lower = 0L, upper = 6L))
        ),
        variant = p_fct(
          c("original", "o_1", "o_2", "f_3", "f_4", "f_5", "faster"),
          default = "original",
          tags = "train"
        ),
        trace.lev = p_int(0L, default = 0L, tags = "train")
      )

      param_set$set_values(k = 2L, keep.diss = FALSE, keep.data = FALSE)

      super$initialize(
        id = "clust.pam",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = c("cluster", "clue"),
        man = "mlr3cluster::mlr_learners_clust.pam",
        label = "Partitioning Around Medoids"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      if (!is.null(pv$medoids)) {
        if (length(pv$medoids) != pv$k) {
          error_config("number of `medoids` needs to match `k`!")
        }
        if (sum(pv$medoids <= task$nrow & pv$medoids >= 1L) != pv$k) {
          error_input("`medoids` need to contain valid indices from 1 to %i (number of observations)!", task$nrow)
        }
      }

      data = task$data()
      x = data
      scaling = NULL
      if (isTRUE(pv$stand)) {
        # clue::cl_predict() ignores pam's internal standardization, so standardize the data upfront
        # like cluster::pam() does and reuse the scaling at predict time
        center = map_dbl(data, mean)
        scale = map_dbl(data, function(col) mean(abs(col - mean(col))))
        # a constant feature has zero mean absolute deviation, so leave it centered instead of dividing by zero
        scale[scale == 0] = 1
        x = as.data.table(scale(data.matrix(data), center = center, scale = scale))
        scaling = list(center = center, scale = scale)
        pv$stand = NULL
      }

      m = invoke(cluster::pam, x = x, diss = FALSE, .args = pv)
      if (!is.null(scaling)) {
        # report medoids in the original data units like cluster::pam(stand = TRUE) does
        m$medoids = data.matrix(data)[m$id.med, , drop = FALSE]
        m$scaling = scaling
      }
      if (self$save_assignments) {
        self$assignments = m$clustering
      }
      m
    },

    .predict = function(task) {
      model = self$model
      newdata = task$data()
      scaling = model$scaling
      if (!is.null(scaling)) {
        cols = colnames(newdata)
        newdata = as.data.table(
          scale(data.matrix(newdata), center = scaling$center[cols], scale = scaling$scale[cols])
        )
        # medoids are stored in the original units, so standardize them for the distance computation
        cols = colnames(model$medoids)
        model$medoids = scale(model$medoids, center = scaling$center[cols], scale = scaling$scale[cols])
      }
      partition = unclass(invoke(clue::cl_predict, model, newdata = newdata, type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.pam", LearnerClustPAM)
