#' @title Density-based Spatial Clustering of Applications with Noise (DBSCAN) Clustering Learner
#'
#' @name mlr_learners_clust.dbscan
#'
#' @description
#' DBSCAN (Density-based spatial clustering of applications with noise) clustering.
#' Calls [dbscan::dbscan()] from \CRANpkg{dbscan}.
#'
#' @templateVar id clust.dbscan
#' @template learner
#'
#' @references
#' `r format_bib("hahsler2019dbscan", "ester1996density")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustDBSCAN = R6Class("LearnerClustDBSCAN",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        eps = p_dbl(0, tags = c("required", "train")),
        minPts = p_int(0L, default = 5L, tags = "train"),
        borderPoints = p_lgl(default = TRUE, tags = "train"),
        weights = p_uty(tags = "train", custom_check = check_numeric),
        search = p_fct(levels = c("kdtree", "linear", "dist"), default = "kdtree", tags = "train"),
        bucketSize = p_int(1L, default = 10L, tags = "train", depends = quote(search == "kdtree")),
        splitRule = p_fct(
          levels = c("STD", "MIDPT", "FAIR", "SL_MIDPT", "SL_FAIR", "SUGGEST"),
          default = "SUGGEST",
          tags = "train",
          depends = quote(search == "kdtree")
        ),
        approx = p_dbl(default = 0, tags = "train")
      )

      super$initialize(
        id = "clust.dbscan",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("density", "exclusive", "complete"),
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
      m = insert_named(m, list(data = task$data()))
      if (self$save_assignments) {
        self$assignments = m$cluster
      }
      m
    },

    .predict = function(task) {
      partition = invoke(predict, self$model, newdata = task$data(), data = self$model$data)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.dbscan", LearnerClustDBSCAN)
