#' @title Featureless Clustering Learner
#'
#' @name mlr_learners_clust.featureless
#' @include LearnerClust.R
#'
#' @description
#' A simple [LearnerClust] which assigns first n observations to cluster 1,
#' second n observations to cluster 2, and so on.
#' Hyperparameter `num_clusters` controls the number of clusters and is
#' set to 1 by default.
#' The train method tries to assign cluster memberships to each
#' observation such that each cluster has an equal amount of observations.
#' The predict method uses does the same thing as the train but for new data.
#'
#' @templateVar id clust.featureless
#' @template section_dictionary_learner
#' @examples
#' learner = mlr3::lrn("clust.kmeans")
#' print(learner)
#'
#' # available parameters:
#' learner$param_set$ids()
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
          ParamInt$new(id = "num_clusters", lower = 1L,
                       default = 1L, tags = c("required", "train"))
        )
      )
      ps$values = list(num_clusters = 1L)

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
      if (pv$num_clusters > n) {
        stopf("number of clusters must lie between 1 and nrow(data)")
      } else if (pv$num_clusters == n) {
        clustering = seq_len(n)
      } else {
        times = c(
          rep.int(n / pv$num_clusters, pv$num_clusters - 1),
          n - (pv$num_clusters - 1) * floor(n / pv$num_clusters)
        )

        clustering = rep.int(seq_along(1:pv$num_clusters),
          times = times
        )
      }
      m = set_class(
        list(clustering = clustering, features = task$feature_names),
        "clust.featureless_model"
      )
      if (self$save_assignments) {
        self$assignments = m$clustering
      }

      return(m)
    },
    .predict = function(task) {
      n = task$nrow
      pv = self$param_set$get_values(tags = "train")
      if (n <= pv$num_clusters) {
        partition = seq_len(n)
      } else {
        times = c(
          rep.int(n / pv$num_clusters, pv$num_clusters - 1),
          n - (pv$num_clusters - 1) * floor(n / pv$num_clusters)
        )

        partition = rep.int(seq_len(pv$num_clusters),
          times = times
        )
      }
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
