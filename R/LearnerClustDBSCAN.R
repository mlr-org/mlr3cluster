#' @title Density-Based Clustering Learner
#'
#' @name mlr_learners_clust.dbscan
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for density-based clustering implemented in [dbscan::dbscan()].
#'
#' @templateVar id clust.dbscan
#' @template section_dictionary_learner
#'
#' @export
LearnerClustDBSCAN = R6Class("LearnerClustDBSCAN", inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamDbl$new(id = "eps", lower = 0L, tags = c("required", "train")),
          ParamInt$new(id = "minPts", lower = 0L, default = 5L, tags = "train"),
          ParamLgl$new(id = "borderPoints", default = TRUE),
          ParamUty$new(id = "weights", custom_check = function(x) {
            if (test_numeric(x)) {
              return(TRUE)
            } else {
              stop("`weights` need to be a numeric vector!")
            }
          }),
          ParamFct$new(id = "search", levels = c("kdtree", "linear", "dist"),
                       default = "kdtree")
        )
      )

      super$initialize(
        id = "clust.dbscan",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("partitional", "exclusive", "complete"),
        packages = "dbscan"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      invoke(dbscan::dbscan, x = task$data(), .args = pv)
    },

    .predict = function(task) {
      partition = self$model$cluster
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
