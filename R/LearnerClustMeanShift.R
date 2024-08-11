#' @title Mean Shift Clustering Learner
#'
#' @name mlr_learners_clust.meanshift
#'
#' @description
#' A [LearnerClust] for Mean Shift clustering implemented in [LPCM::ms()].
#' There is no predict method for [`LPCM::ms()`], so the method
#' returns cluster labels for the 'training' data.
#'
#' @templateVar id clust.meanshift
#' @template learner
#'
#' @references
#' `r format_bib("cheng1995mean")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustMeanShift = R6Class("LearnerClustMeanShift",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        h = p_uty(tags = "train", custom_check = crate(function(x) {
          if (test_numeric(x) || test_int(x)) {
            TRUE
          } else {
            "`h` must be either integer or numeric vector"
          }
        })),
        subset = p_uty(tags = "train", custom_check = check_numeric),
        scaled = p_int(0L, default = 1, tags = "train"),
        iter = p_int(1L, default = 200L, tags = "train"),
        thr = p_dbl(default = 0.01, tags = "train")
      )

      super$initialize(
        id = "clust.meanshift",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "LPCM",
        man = "mlr3cluster::mlr_learners_clust.meanshift",
        label = "Mean Shift Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      if (!is.null(pv$subset) && length(pv$subset) > task$nrow) {
        stopf("`subset` length must be less than or equal to number of observations in task")
      }

      m = invoke(LPCM::ms, X = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = m$cluster.label
      }
      m
    },

    .predict = function(task) {
      warn_prediction_useless(self$id)
      partition = as.integer(self$model$cluster.label)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.meanshift", LearnerClustMeanShift)
