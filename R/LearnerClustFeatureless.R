#' @title Featureless Clustering Learner
#'
#' @name mlr_learners_clust.featureless
#' @include LearnerClust.R
#'
#' @description
#' A simple [LearnerClust] which assigns first n observations to cluster 1,
#' second n observations to cluster 2, and so on.
#' Hyperparameter `num.clusters` controls the number of clusters.
#' The train method tries to assign cluster memberships to each
#' observation such that each cluster has an equal amount of observations.
#' The predict method uses does the same thing as the train but for new data.
#'
#' @templateVar id clust.featureless
#' @template section_dictionary_learner
#'
#' @export
LearnerClustFeatureless = R6Class("LearnerClustFeatureless",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamInt$new(id = "num.clusters", lower = 1L,
                       default = 1L, tags = c("required", "train"))
        )
      )
      ps$values = list(num.clusters = 1L)

      super$initialize(
        id = "clust.featureless",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("partitional", "exclusive", "complete", "missings")
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      n = task$nrow
      if (pv$num.clusters > n) {
        stopf("number of clusters must lie between 1 and nrow(data)")
      } else if (pv$num.clusters == n) {
        clustering = seq_len(n)
      } else {
        times = c(
          rep.int(n / pv$num.clusters, pv$num.clusters - 1),
          n - (pv$num.clusters - 1) * floor(n / pv$num.clusters)
        )

        clustering = rep.int(seq_along(1:pv$num.clusters),
          times = times
        )
      }
      set_class(
        list(clustering = clustering, features = task$feature_names),
        "clust.featureless_model"
      )
    },
    .predict = function(task) {
      n = task$nrow
      pv = self$param_set$get_values(tags = "train")
      if (n <= pv$num.clusters) {
        partition = seq_len(n)
      } else {
        times = c(
          rep.int(n / pv$num.clusters, pv$num.clusters - 1),
          n - (pv$num.clusters - 1) * floor(n / pv$num.clusters)
        )

        partition = rep.int(seq_len(pv$num.clusters),
          times = times
        )
      }
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
