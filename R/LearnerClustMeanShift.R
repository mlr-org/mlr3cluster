#' @title Mean Shift Clustering Learner
#'
#' @name mlr_learners_clust.meanshift
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for Mean Shift clustering implemented in [LPCM::ms()].
#' There is no predict method for [`LPCM::ms()`], so the method
#' returns cluster labels for the 'training' data.
#'
#' @templateVar id clust.meanshift
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustMeanShift = R6Class("LearnerClustMeanShift",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamUty$new(
            id = "h",
            custom_check = function(x) {
              if (test_numeric(x) || test_int(x)) {
                return(TRUE)
              } else {
                return("`h` must be either integer or numeric vector")
              }
            }, tags = "train"),
          ParamUty$new(id = "subset", custom_check = function(x) {
            if (test_numeric(x)) {
              return(TRUE)
            } else {
              return("`subset` must be a numeric vector")
            }
          }, tags = "train"),
          ParamInt$new(id = "scaled", lower = 0L, default = 1, tags = "train"),
          ParamInt$new(id = "iter", lower = 1L, default = 200L, tags = "train"),
          ParamDbl$new(id = "thr", default = 0.01, tags = "train")
        )
      )

      super$initialize(
        id = "clust.meanshift",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("partitional", "exclusive", "complete"),
        packages = "LPCM"
      )
    }
  ),
  private = list(
    .train = function(task) {
      if (!is.null(self$param_set$values$subset)) {
        if (length(self$param_set$values$subset) > task$nrow) {
          stop("`subset` length must be less than or equal to number of observations in task")
        }
      }

      pv = self$param_set$get_values(tags = "train")
      invoke(LPCM::ms, X = task$data(), .args = pv)
    },
    .predict = function(task) {
      warn_prediction_useless(self$id)
      partition = as.integer(self$model$cluster.label)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
