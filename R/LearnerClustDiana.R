#' @title Divisive Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.diana
#' @include LearnerClust.R
#' @include aaa.R
#'
#' @description
#' A [LearnerClust] for divisive hierarchical clustering implemented in [cluster::diana()].
#' The predict method uses [stats::cutree()] which cuts the tree resulting from
#' hierarchical clustering into specified number of groups (see parameter `k`).
#' The default value for `k` is 2.
#'
#' @templateVar id clust.diana
#' @template learner
#' @template example
#'
#' @export
LearnerClustDiana = R6Class("LearnerClustDiana",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ps(
        metric = p_fct(default = "euclidean", levels = c("euclidean", "manhattan"), tags = "train"),
        stand = p_lgl(default = FALSE, tags = "train"),
        trace.lev = p_int(lower = 0L, default = 0L, tags = "train"),
        k = p_int(lower = 1L, default = 2L, tags = "predict")
      )
      ps$values = list(k = 2L)

      super$initialize(
        id = "clust.diana",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "cluster",
        man = "mlr3cluster::mlr_learners_clust.diana",
        label = "Divisive Hierarchical Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(cluster::diana, x = task$data(), diss = FALSE, .args = pv)
      if (self$save_assignments) {
        self$assignments = stats::cutree(m, self$param_set$values$k)
      }

      return(m)
    },

    .predict = function(task) {
      if (test_true(self$param_set$values$k > task$nrow)) {
        stop(sprintf("`k` needs to be between 1 and %s", task$nrow))
      }

      warn_prediction_useless(self$id)

      PredictionClust$new(task = task, partition = self$assignments)
    }
  )
)

learners[["clust.diana"]] = LearnerClustDiana
