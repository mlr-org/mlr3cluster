#' @include LearnerClust.R
LearnerClustKMeans = R6Class("LearnerClustKMeans", inherit = LearnerClust,
  public = list(
    initialize = function() {
      super$initialize(
        id = "clust.kmeans",
        param_set = ParamSet$new(
          params = list(
            ParamInt$new(id = "centers", lower = 1L, tags = c("required", "train"))
          )
        ),
        predict_types = "partition",
        feature_types = c("logical", "integer", "numeric"),
        packages = c("stats", "clue")
      )
    },

    train_internal = function(task) {
      pv = self$param_set$get_values(tags = "train")
      invoke(stats::kmeans, x = task$data(), .args = pv)
    },

    predict_internal = function(task) {
      partition = unclass(clue::cl_predict(self$model, newdata = task$data(), type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
