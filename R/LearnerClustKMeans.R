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
      ps = ParamSet$new(
        params = list(
          ParamUty$new(id = "centers", tags = c("required", "train"), default = 2L,
            custom_check = function(x) {
            if (test_data_frame(x) || test_int(x)) {
              return(TRUE)
            } else {
              return("centers must be either integer or data.frame!")
            }
          }),
          ParamInt$new(id = "iter.max", lower = 1L, default = 10L, tags = c("train")),
          ParamFct$new(id = "algorithm",
                       levels = c("Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"),
                       default = "Hartigan-Wong", tags = c("train"))
        )
      )
      ps$values = list(centers = 2L)

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
      pv = self$param_set$get_values(tags = "train")
      invoke(stats::kmeans, x = task$data(), .args = pv)
    },

    .predict = function(task) {
      partition = unclass(clue::cl_predict(self$model, newdata = task$data(), type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
