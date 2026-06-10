#' @title Fuzzy Analysis Clustering Learner
#'
#' @name mlr_learners_clust.fanny
#'
#' @description
#' Fuzzy Analysis (FANNY) clustering.
#' Calls [cluster::fanny()] from package \CRANpkg{cluster}.
#'
#' The `k` parameter is set to 2 by default since [cluster::fanny()] doesn't have a default value for the number of
#' clusters. The predict method copies cluster assignments and memberships generated for train data. The predict does
#' not work for new data.
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
#' @templateVar id clust.fanny
#' @template learner
#'
#' @references
#' `r format_bib("kaufman2009finding")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustFanny = R6Class(
  "LearnerClustFanny",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("train", "required")),
        memb.exp = p_dbl(1, default = 2, tags = "train"),
        metric = p_fct(c("euclidean", "manhattan", "SqEuclidean"), default = "euclidean", tags = "train"),
        stand = p_lgl(default = FALSE, tags = "train"),
        iniMem.p = p_uty(
          default = NULL,
          tags = "train",
          custom_check = crate(function(x) check_matrix(x, mode = "numeric", null.ok = TRUE))
        ),
        keep.diss = p_lgl(tags = "train"),
        keep.data = p_lgl(default = TRUE, tags = "train"),
        maxit = p_int(0L, default = 500L, tags = "train"),
        tol = p_dbl(0, default = 1e-15, tags = "train"),
        trace.lev = p_int(0L, default = 0L, tags = "train")
      )

      param_set$set_values(k = 2L, keep.diss = FALSE, keep.data = FALSE)

      super$initialize(
        id = "clust.fanny",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = param_set,
        properties = c("partitional", "fuzzy", "complete"),
        packages = "cluster",
        man = "mlr3cluster::mlr_learners_clust.fanny",
        label = "Fuzzy Analysis"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(cluster::fanny, x = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = m$clustering
      }
      m
    },

    .predict = function(task) {
      warn_prediction_useless(self$id)
      partition = self$assignments %??% self$model$clustering
      prob = NULL
      if (self$predict_type == "prob") {
        prob = self$model$membership
        colnames(prob) = seq_col(prob)
      }
      PredictionClust$new(task = task, partition = partition, prob = prob)
    }
  )
)

#' @include zzz.R
register_learner("clust.fanny", LearnerClustFanny)
