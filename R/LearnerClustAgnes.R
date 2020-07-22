#' @title Agglomerative Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.agnes
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for agnes clustering implemented in [cluster::agnes()].
#' Predictions are generated using [clue::cl_predict()].
#'
#' @templateVar id clust.agnes
#' @template section_dictionary_learner
#'
#' @export
LearnerClustAgnes = R6Class("LearnerClustAgnes", inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamFct$new("metric", default = "euclidian",
                       levels = c("euclidian", "manhattan"), tags = "train"),
          ParamLgl$new("stand", default = FALSE, tags = "train"),
          ParamFct$new("method", default = "average",
            levels = c("average", "single", "complete", "ward",
                       "weighted", "flexible", "gaverage"), tags = "train"),
          ParamInt$new("trace.lev", lower = 0L, default = 0L, tags = "train"),
          ParamInt$new("k", lower = 1L, default = 1L, tags = "predict")
        )
      )
      ps$values = list(metric = "euclidian", stand = FALSE, trace.lev = 0L, k = 1L)

      super$initialize(
        id = "clust.agnes",
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
      invoke(cluster::agnes, x = task$data(), diss = FALSE, .args = pv)
    },

    .predict = function(task) {
      partition = stats::cutree(self$model, self$param_set$values$k)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
