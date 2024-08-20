#' @title Featureless Clustering Learner
#'
#' @name mlr_learners_clust.featureless
#'
#' @description
#' A simple [LearnerClust] which randomly (but evenly) assigns observations to
#' `num_clusters` partitions (default: 1 partition).
#'
#' @templateVar id clust.featureless
#' @template learner
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustFeatureless = R6Class("LearnerClustFeatureless",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(num_clusters = p_int(1L, tags = c("required", "train", "predict")))
      param_set$set_values(num_clusters = 1L)

      super$initialize(
        id = "clust.featureless",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete", "missings"),
        man = "mlr3cluster::mlr_learners_clust.featureless",
        label = "Featureless Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      k = pv$num_clusters
      n = task$nrow

      if (k > n) {
        stopf("number of clusters must lie between 1 and nrow(data)")
      }

      partition = chunk(n, n_chunks = k)

      if (self$save_assignments) {
        self$assignments = partition
      }

      set_class(
        list(clustering = partition, features = task$feature_names),
        "clust.featureless_model"
      )
    },

    .predict = function(task) {
      pv = self$param_set$get_values(tags = "predict")
      n = task$nrow
      k = pv$num_clusters

      partition = chunk(n, n_chunks = k)
      prob = NULL

      if (self$predict_type == "prob") {
        prob = matrix(runif(n * k), nrow = n, ncol = k)
        prob = prob / rowSums(prob)

        # reorder rows so that the max probability corresponds to
        # the selected partition in `partition`
        prob = do.call(rbind, map(seq_along(partition), function(i) {
          x = prob[i, , drop = TRUE]
          pos = which_max(x)
          if (pos == i) x else append(x[-pos], x[pos], after = partition[i] - 1L)
        }))
      }

      PredictionClust$new(task = task, partition = partition, prob = prob)
    }
  )
)

#' @include zzz.R
register_learner("clust.featureless", LearnerClustFeatureless)
