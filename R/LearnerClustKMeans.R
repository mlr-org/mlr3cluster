#' @title KMeans Cluster Learner
#'
#' @name mlr_learners_clust.kmeans
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for k-means clustering implemented in [stats::kmeans()].
#'
#' @templateVar id clust.kmeans
#' @template section_dictionary_learner
#'
#' @export
LearnerClustKMeans = R6Class("LearnerClustKMeans", inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
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
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      invoke(stats::kmeans, x = task$data(), .args = pv)
    },

    .predict = function(task) {
      partition = unclass(clue::cl_predict(self$model, newdata = task$data(), type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
