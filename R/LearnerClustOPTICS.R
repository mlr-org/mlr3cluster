#' @title Ordering Points to Identify the Clustering Structure (OPTICS) Clustering Learner
#'
#' @name mlr_learners_clust.optics
#'
#' @description
#' OPTICS (Ordering points to identify the clustering structure) point ordering clustering.
#' Calls [dbscan::optics()] from \CRANpkg{dbscan}.
#'
#' @templateVar id clust.optics
#' @template learner
#'
#' @references
#' `r format_bib("hahsler2019dbscan", "ankerst1999optics")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustOPTICS = R6Class("LearnerClustOPTICS",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        eps = p_dbl(0, special_vals = list(NULL), default = NULL, tags = "train"),
        minPts = p_int(0L, default = 5L, tags = "train"),
        search = p_fct(levels = c("kdtree", "linear", "dist"), default = "kdtree", tags = "train"),
        bucketSize = p_int(1L, default = 10L, tags = "train", depends = quote(search == "kdtree")),
        splitRule = p_fct(
          levels = c("STD", "MIDPT", "FAIR", "SL_MIDPT", "SL_FAIR", "SUGGEST"),
          default = "SUGGEST",
          tags = "train",
          depends = quote(search == "kdtree")
        ),
        approx = p_dbl(default = 0, tags = "train"),
        eps_cl = p_dbl(0, tags = c("required", "train"))
      )

      super$initialize(
        id = "clust.optics",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("density", "exclusive", "complete"),
        packages = "dbscan",
        man = "mlr3cluster::mlr_learners_clust.optics",
        label = "OPTICS Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(dbscan::optics, x = task$data(), .args = remove_named(pv, "eps_cl"))
      m = insert_named(m, list(data = task$data()))
      m = invoke(dbscan::extractDBSCAN, object = m, eps_cl = pv$eps_cl)

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
register_learner("clust.optics", LearnerClustOPTICS)
