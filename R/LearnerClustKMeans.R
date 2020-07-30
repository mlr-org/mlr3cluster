#' @title KMeans Cluster Learner
#'
#' @name mlr_learners_clust.kmeans
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for k-means clustering implemented in [stats::kmeans()].
#' The default number of clusters has been initialized to 2.
#' Predictions are generated using [clue::cl_predict()].
#'
#' @templateVar id clust.kmeans
#' @template section_dictionary_learner
#'
#' @export
LearnerClustKMeans = R6Class("LearnerClustKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamUty$new(
            id = "centers", tags = c("required", "train"), default = 2L,
            custom_check = function(x) {
              if (test_data_frame(x)) {
                return(TRUE)
              } else if (test_int(x)) {
                assert_true(x >= 1L)
              } else {
                return("centers must be either integer or data.frame with initial cluster centers!")
              }
            }
          ),
          ParamInt$new(id = "iter.max", lower = 1L, default = 10L, tags = c("train")),
          ParamFct$new(
            id = "algorithm",
            levels = c("Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"),
            default = "Hartigan-Wong", tags = c("train")
          ),
          ParamInt$new(id = "nstart", lower = 1L, default = 1L, tags = c("train")),
          ParamInt$new(id = "trace", lower = 0L, default = 0L, tags = c("train"))
        )
      )
      ps$values = list(centers = 2L, algorithm = "Hartigan-Wong", iter.max = 10L, trace = 0L)

      super$initialize(
        id = "clust.kmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("partitional", "exclusive", "complete"),
        packages = c("stats", "clue")
      )
    }
  ),
  private = list(
    .train = function(task) {
      if ("nstart" %in% names(self$param_set$values)) {
        if (!test_int(self$param_set$values$centers)) {
          warning("warning: `nstart` parameter is only relevant when `centers` is integer")
        }
      }

      if (test_data_frame(self$param_set$values$centers)) {
        if (length(self$param_set$values$centers) != task$ncol) {
          stop("`centers` must have same number of columns as data!")
        }
      }

      pv = self$param_set$get_values(tags = "train")
      invoke(stats::kmeans, x = task$data(), .args = pv)
    },
    .predict = function(task) {
      partition = unclass(cl_predict(self$model, newdata = task$data(), type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
