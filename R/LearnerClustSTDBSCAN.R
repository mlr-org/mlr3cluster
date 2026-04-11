#' @title ST-DBSCAN Clustering Learner
#'
#' @name mlr_learners_clust.stdbscan
#'
#' @description
#' ST-DBSCAN (spatio-temporal density-based spatial clustering of applications with noise) clustering.
#' Calls [stdbscan::st_dbscan()] from package \CRANpkg{stdbscan}.
#'
#' @templateVar id clust.stdbscan
#' @template learner
#'
#' @references
#' `r format_bib("birant2007stdbscan")`
#'
#' @export
#' @template seealso_learner
#' @template simple_example
LearnerClustSTDBSCAN = R6Class(
  "LearnerClustSTDBSCAN",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        eps_spatial = p_dbl(0, tags = c("train", "required")),
        eps_temporal = p_dbl(0, tags = c("train", "required")),
        min_pts = p_int(1L, tags = c("train", "required")),
        borderPoints = p_lgl(default = TRUE, tags = "train"),
        search = p_fct(c("kdtree", "linear", "dist"), default = "kdtree", tags = "train"),
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
        id = "clust.stdbscan",
        feature_types = c("integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("density", "exclusive", "complete"),
        packages = "stdbscan",
        man = "mlr3cluster::mlr_learners_clust.stdbscan",
        label = "ST-DBSCAN"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      data = task$data()
      m = invoke(stdbscan::st_dbscan, data = as.matrix(data), .args = pv)
      m = insert_named(m, list(data = data))
      if (self$save_assignments) {
        self$assignments = m$cluster
      }
      m
    },

    .predict = function(task) {
      partition = invoke(predict, self$model, data = as.matrix(self$model$data), newdata = as.matrix(task$data()))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.stdbscan", LearnerClustSTDBSCAN)
