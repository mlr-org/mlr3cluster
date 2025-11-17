#' @title Hierarchical DBSCAN (HDBSCAN) Clustering Learner
#'
#' @name mlr_learners_clust.hdbscan
#'
#' @description
#' HDBSCAN (Hierarchical DBSCAN) clustering.
#' Calls [dbscan::hdbscan()] from \CRANpkg{dbscan}.
#'
#' @templateVar id clust.hdbscan
#' @template learner
#'
#' @references
#' `r format_bib("hahsler2019dbscan", "campello2013density")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustHDBSCAN = R6Class("LearnerClustHDBSCAN",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        minPts = p_int(0L, tags = c("train", "required")),
        cluster_selection_epsilon = p_dbl(default = 0, tags = "train"),
        gen_hdbscan_tree = p_lgl(default = FALSE, tags = "train"),
        gen_simplified_tree = p_lgl(default = FALSE, tags = "train"),
        verbose = p_lgl(default = FALSE, tags = "train")
      )

      param_set$set_values(minPts = 5L)

      super$initialize(
        id = "clust.hdbscan",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("density", "exclusive", "complete"),
        packages = "dbscan",
        man = "mlr3cluster::mlr_learners_clust.hdbscan",
        label = "HDBSCAN Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      data = task$data()
      m = invoke(dbscan::hdbscan, x = data, .args = pv)
      m = insert_named(m, list(data = data))

      if (self$save_assignments) {
        self$assignments = m$cluster
      }
      m
    },

    .predict = function(task) {
      partition = as.integer(invoke(predict, self$model, newdata = task$data(), data = self$model$data))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.hdbscan", LearnerClustHDBSCAN)
