#' @title Agglomerative Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.agnes
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for agglomerative hierarchical clustering implemented in [cluster::agnes()].
#' The predict method uses [stats::cutree()] which cuts the tree resulting from
#' hierarchical clustering into specified number of groups (see parameter `k`).
#' The default number for `k` is 2.
#'
#' @templateVar id clust.agnes
#' @template section_dictionary_learner
#'
#' @export
LearnerClustAgnes = R6Class("LearnerClustAgnes",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamFct$new("metric",
            default = "euclidean",
            levels = c("euclidean", "manhattan"), tags = "train"
          ),
          ParamLgl$new("stand", default = FALSE, tags = "train"),
          ParamFct$new("method",
            default = "average",
            levels = c(
              "average", "single", "complete", "ward",
              "weighted", "flexible", "gaverage"
            ), tags = "train"
          ),
          ParamInt$new("trace.lev", lower = 0L, default = 0L, tags = "train"),
          ParamInt$new("k", lower = 1L, default = 2L, tags = "predict"),
          ParamUty$new(
            id = "par.method", tags = "train",
            custom_check = function(x) {
              if (test_numeric(x) || test_list(x)) {
                if (length(x) %in% c(1L, 3L, 4L)) {
                  return(TRUE)
                }
                stop("`par.method` needs be of length 1, 3, or 4")
              } else {
                stop("`par.method` needs to be a numeric vector")
              }
            })
        )
      )
      # param deps
      ps$add_dep("par.method", "method", CondAnyOf$new(c("flexible", "gaverage")))

      # set defaults
      ps$values = list(metric = "euclidean", stand = FALSE, trace.lev = 0L, k = 2L)

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
      if (self$param_set$values$k > task$nrow) {
        stopf("`k` needs to be between 1 and %i", task$nrow)
      }

      warn_prediction_useless(self$id)

      partition = stats::cutree(self$model, self$param_set$values$k)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
