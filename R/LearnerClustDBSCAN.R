#' @title Density-Based Clustering Learner
#'
#' @name mlr_learners_clust.dbscan
#' @include LearnerClust.R
#' @include aaa.R
#'
#' @description
#' A [LearnerClust] for density-based clustering implemented in [dbscan::dbscan()].
#' The predict method uses [dbscan::predict.dbscan_fast()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.dbscan
#' @template learner
#' @template example
#'
#' @export
LearnerClustDBSCAN = R6Class("LearnerClustDBSCAN",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ps(
        eps = p_dbl(lower = 0L, tags = c("required", "train")),
        minPts = p_int(lower = 0L, default = 5L, tags = "train"),
        borderPoints = p_lgl(default = TRUE, tags = "train"),
        weights = p_uty(tags = "train"), custom_check = crate(check_numeric),
        search = p_fct(levels = c("kdtree", "linear", "dist"), default = "kdtree", tags = "train"),
        bucketSize = p_int(lower = 1L, default = 10L, tags = "train"),
        splitRule = p_fct(levels = c("STD", "MIDPT", "FAIR", "SL_MIDPT", "SL_FAIR", "SUGGEST"), default = "SUGGEST", tags = "train"),
        approx = p_dbl(default = 0L, tags = "train")
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
        packages = "dbscan",
        man = "mlr3cluster::mlr_learners_clust.dbscan",
        label = "Density-Based Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(dbscan::dbscan, x = task$data(), .args = pv)
      m = set_class(
        list(cluster = m$cluster, eps = m$eps, minPts = m$minPts, data = task$data(), dist = m$dist),
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

learners[["clust.dbscan"]] = LearnerClustDBSCAN
