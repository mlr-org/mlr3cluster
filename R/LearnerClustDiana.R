#' @title Divisive Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.diana
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for divisive hierarchical clustering implemented in [cluster::diana()].
#' The predict method uses [stats::cutree()] which cuts the tree resulting from
#' hierarchical clustering into specified number of groups (see parameter `k`).
#'
#' @templateVar id clust.diana
#' @template section_dictionary_learner
#'
#' @export
LearnerClustDiana = R6Class("LearnerClustDiana",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamFct$new(
            id = "metric", default = "euclidean",
            levels = c("euclidean", "manhattan"), tags = "train"),
          ParamLgl$new(id = "stand", default = FALSE, tags = "train"),
          ParamInt$new(id = "trace.lev", lower = 0L, default = 0L, tags = "train"),
          ParamInt$new(id = "k", lower = 1L, default = 1L, tags = "predict")
        )
      )

      # set defaults
      ps$values = list(metric = "euclidean", stand = FALSE, trace.lev = 0L, k = 1L)

      super$initialize(
        id = "clust.diana",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "cluster"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      invoke(cluster::diana, x = task$data(), diss = FALSE, .args = pv)
    },

    .predict = function(task) {
      if (test_true(self$param_set$values$k > task$nrow)) {
        stop(sprintf("`k` needs to be between 1 and %s", task$nrow))
      }

      msg = "clust.diana doesn't predict on new data"
      msg = paste(msg, "and prediction results may not make sense", sep = " ")
      msg = paste(msg, "if you use it on new data", sep = " ")
      warning(msg)

      partition = stats::cutree(self$model, self$param_set$values$k)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
