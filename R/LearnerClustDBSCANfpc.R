#' @title Density-Based Clustering Learner with fpc
#'
#' @name mlr_learners_clust.dbscan_fpc
#'
#' @description
#' A [LearnerClust] for density-based clustering implemented in [fpc::dbscan()].
#' The predict method uses [fpc::predict.dbscan()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.dbscan_fpc
#' @template learner
#' @template example
#'
#' @export
LearnerClustDBSCANfpc = R6Class("LearnerClustDBSCANfpc",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        eps = p_dbl(lower = 0L, tags = c("required", "train")),
        MinPts = p_int(lower = 0L, default = 5L, tags = "train"),
        scale = p_lgl(default = FALSE, tags = "train"),
        method = p_fct(levels = c("hybrid", "raw", "dist"), tags = "train"),
        seeds = p_lgl(default = TRUE, tags = "train"),
        showplot = p_uty(custom_check = crate(function(x) {
          if (test_flag(x)) {
            return(TRUE)
          } else if (test_int(x, lower = 0, upper = 2)) {
            return(TRUE)
          } else {
            stop("`showplot` need to be either logical or integer between 0 and 2")
          }
        }), default = FALSE, tags = "train"),
        countmode = p_uty(custom_check = crate(function(x) {
          if (test_integer(x)) {
            return(TRUE)
          } else if (test_null(x)) {
            return(TRUE)
          } else {
            stop("`countmode` need to be NULL or vector of integers")
          }
        }), default = NULL, tags = "train")
      )

      param_set$values = list(MinPts = 5L, scale = FALSE, seeds = TRUE,
        showplot = FALSE, countmode = NULL)

      super$initialize(
        id = "clust.dbscan_fpc",
        packages = "fpc",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition"),
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        man = "mlr3cluster::mlr_learners_clust.dbscan_fpc",
        label = "Density-Based Clustering with fpc"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pars = self$param_set$get_values(tags = "train")
      m = invoke(fpc::dbscan, data = task$data(), .args = pars)
      m = set_class(
        list(cluster = m$cluster, eps = m$eps, MinPts = m$MinPts, isseed = m$isseed, data = task$data()),
        c("dbscan")
      )
      if (self$save_assignments) {
        self$assignments = m$cluster
      }

      return(m)
    },
    .predict = function(task) {
      partition = as.integer(predict(self$model, data = self$model$data, newdata = task$data()))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

learners[["clust.dbscan_fpc"]] = LearnerClustDBSCANfpc
