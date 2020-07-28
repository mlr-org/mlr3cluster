#' @title Agglomerative Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.agnes
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for agglomerative hierarchical clustering implemented in [cluster::agnes()].
#' Predictions are generated using [stats::cutree()].
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
          ParamFct$new(id = "metric", default = "euclidean",
                       levels = c("euclidean", "manhattan"), tags = "train"),
          ParamLgl$new(id = "stand", default = FALSE, tags = "train"),
          ParamFct$new(id = "method", default = "average",
            levels = c("average", "single", "complete", "ward",
                       "weighted", "flexible", "gaverage"), tags = "train"),
          ParamInt$new(id = "trace.lev", lower = 0L, default = 0L, tags = "train"),
          ParamInt$new(id = "k", lower = 1L, default = 1L, tags = "predict"),
          ParamUty$new(id = "par.method", tags = "train",
            custom_check = function(x) {
              if (test_numeric(x) || test_list(x)) {
                if (length(x) == 1L || length(x) == 3L || length(x) == 4L) {
                  return(TRUE)
                } else {
                  stop("`par.method` needs be of length 1, 3, or 4")
                }
              } else {
                stop("`par.method` needs to be a numeric vector")
              }
            })
        )
      )
      # param deps
      ps$add_dep("par.method", "method", CondAnyOf$new(c("flexible", "gaverage")))

      # set defaults
      ps$values = list(metric = "euclidean", stand = FALSE, trace.lev = 0L, k = 1L)

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
      if (test_true(self$param_set$values$k > task$nrow)) {
        stop(sprintf("`k` needs to be between 1 and %s", task$nrow))
      }

      partition = stats::cutree(self$model, self$param_set$values$k)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
