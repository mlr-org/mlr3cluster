#' @title Density-Based Clustering Learner
#'
#' @name mlr_learners_clust.dbscan
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for density-based clustering implemented in [dbscan::dbscan()].
#' The predict method uses [dbscan::predict.dbscan_fast()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.dbscan
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustDBSCAN = R6Class("LearnerClustDBSCAN",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamDbl$new(id = "eps", lower = 0L, tags = c("required", "train")),
          ParamInt$new(id = "minPts", lower = 0L, default = 5L, tags = "train"),
          ParamLgl$new(id = "borderPoints", default = TRUE, tags = "train"),
          ParamUty$new(id = "weights", custom_check = function(x) {
            if (test_numeric(x)) {
              return(TRUE)
            } else {
              stop("`weights` need to be a numeric vector")
            }
          }, tags = "train"),
          ParamFct$new(
            id = "search", levels = c("kdtree", "linear", "dist"),
            default = "kdtree", tags = "train"),
          ParamInt$new(id = "bucketSize", lower = 1L, default = 10L, tags = "train"),
          ParamFct$new(
            id = "splitRule",
            levels = c("STD", "MIDPT", "FAIR", "SL_MIDPT", "SL_FAIR", "SUGGEST"),
            default = "SUGGEST", tags = "train"),
          ParamDbl$new(id = "approx", default = 0L, tags = "train")
        )
      )
      # add deps
      ps$add_dep("bucketSize", "search", CondEqual$new("kdtree"))
      ps$add_dep("splitRule", "search", CondEqual$new("kdtree"))

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
      m = invoke(dbscan::dbscan, x = task$data(), .args = pv)
      m = set_class(
        list(cluster = m$cluster, eps = m$eps, minPts = m$minPts, data = task$data()),
        c("dbscan_fast", "dbscan")
      )
      if (self$save_assignments) {
        self$assignments = m$cluster
      }

      return(m)
    },

    .predict = function(task) {
      partition = predict(self$model, newdata = task$data(), self$model$data)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
