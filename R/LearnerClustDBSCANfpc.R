#' @title Density-based Spatial Clustering of Applications with Noise (DBSCAN) Clustering Learner
#'
#' @name mlr_learners_clust.dbscan_fpc
#'
#' @description
#' DBSCAN (Density-based spatial clustering of applications with noise) clustering.
#' Calls [fpc::dbscan()] from \CRANpkg{fpc}.
#'
#' @templateVar id clust.dbscan_fpc
#' @template learner
#'
#' @references
#' `r format_bib("ester1996density")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustDBSCANfpc = R6Class("LearnerClustDBSCANfpc",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        eps = p_dbl(0, tags = c("required", "train")),
        MinPts = p_int(0L, default = 5L, tags = "train"),
        scale = p_lgl(default = FALSE, tags = "train"),
        method = p_fct(levels = c("hybrid", "raw", "dist"), tags = "train"),
        seeds = p_lgl(default = TRUE, tags = "train"),
        showplot = p_uty(default = FALSE, tags = "train", custom_check = crate(function(x) {
          if (test_flag(x) || test_int(x, lower = 0L, upper = 2L)) {
            TRUE
          } else {
            "`showplot` need to be either logical or integer between 0 and 2"
          }
        })),
        countmode = p_uty(default = NULL, tags = "train", custom_check = crate(function(x) {
          if (test_integer(x, null.ok = TRUE)) {
            TRUE
          } else {
            "`countmode` need to be NULL or vector of integers"
          }
        }))
      )

      param_set$set_values(
        MinPts = 5L, scale = FALSE, seeds = TRUE, showplot = FALSE, countmode = NULL
      )

      super$initialize(
        id = "clust.dbscan_fpc",
        packages = "fpc",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("density", "exclusive", "complete"),
        man = "mlr3cluster::mlr_learners_clust.dbscan_fpc",
        label = "Density-Based Clustering with fpc"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(fpc::dbscan, data = task$data(), .args = pv)
      m = insert_named(m, list(data = task$data()))
      if (self$save_assignments) {
        self$assignments = m$cluster
      }
      m
    },

    .predict = function(task) {
      partition = as.integer(invoke(predict, self$model, data = self$model$data), newdata = task$data())
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.dbscan_fpc", LearnerClustDBSCANfpc)
