#' @title Mini Batch K-Means Clustering Learner
#'
#' @name mlr_learners_clust.MBatchKMeans
#' @include LearnerClust.R
#' @include aaa.R
#'
#' @description
#' A [LearnerClust] for mini batch k-means clustering implemented in [ClusterR::MiniBatchKmeans()].
#' [ClusterR::MiniBatchKmeans()] doesn't have a default value for the number of clusters.
#' Therefore, the `clusters` parameter here is set to 2 by default.
#' The predict method uses [ClusterR::predict_MBatchKMeans()] to compute the
#' cluster memberships for new data.
#' The learner supports both partitional and fuzzy clustering.
#'
#' @templateVar id clust.MBatchKMeans
#' @template learner
#' @template example
#'
#' @export
LearnerClustMiniBatchKMeans = R6Class("LearnerClustMiniBatchKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ps(
        clusters = p_int(default = 2L, lower = 1L, tags = "train"),
        batch_size = p_int(lower = 1L, default = 10L, tags = "train"),
        num_init = p_int(lower = 1L, default = 1L, tags = "train"),
        max_iters = p_int(lower = 1L, default = 100L, tags = "train"),
        init_fraction = p_dbl(lower = 0L, upper = 1L, default = 1L, tags = "train"),
        initializer = p_fct(levels = c("optimal_init", "quantile_init", "kmeans++", "random"), default = "kmeans++", tags = "train"),
        early_stop_iter = p_int(lower = 1L, default = 10L, tags = "train"),
        verbose = p_lgl(default = FALSE, tags = "train"),
        CENTROIDS = p_uty(default = NULL, tags = "train"),
        tol = p_dbl(default = 1e-04, lower = 0, tags = "train"),
        tol_optimal_init = p_dbl(default = 0.3, lower = 0, tags = "train"),
        seed = p_int(default = 1L, tags = "train")
      )
      ps$values = list(clusters = 2L)

      # add deps
      ps$add_dep("init_fraction", "initializer", CondAnyOf$new(c("kmeans++", "optimal_init")))

      super$initialize(
        id = "clust.MBatchKMeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = ps,
        properties = c("partitional", "fuzzy", "exclusive", "complete"),
        packages = "ClusterR",
        label = "Mini Batch K-Means"
      )
    }
  ),
  private = list(
    .train = function(task) {
      check_centers_param(self$param_set$values$CENTROIDS, task, test_matrix, "CENTROIDS")
      if (test_matrix(self$param_set$values$CENTROIDS)) {
        if (nrow(self$param_set$values$CENTROIDS) != self$param_set$values$clusters) {
          stop("`CENTROIDS` must have same number of rows as `clusters`")
        }
      }

      pv = self$param_set$get_values(tags = "train")
      m = invoke(ClusterR::MiniBatchKmeans, data = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = unclass(ClusterR::predict_MBatchKMeans(
          data = task$data(),
          CENTROIDS = m$centroids,
          fuzzy = FALSE))
        self$assignments = as.integer(self$assignments)
      }

      return(m)
    },
    .predict = function(task) {
      if (self$predict_type == "partition") {
        partition = unclass(ClusterR::predict_MBatchKMeans(
          data = task$data(),
          CENTROIDS = self$model$centroids,
          fuzzy = FALSE))
        partition = as.integer(partition)
        pred = PredictionClust$new(task = task, partition = partition)
      } else if (self$predict_type == "prob") {
        partition = unclass(ClusterR::predict_MBatchKMeans(
          data = task$data(),
          CENTROIDS = self$model$centroids,
          fuzzy = TRUE))
        colnames(partition$fuzzy_clusters) = seq_len(ncol(partition$fuzzy_clusters))
        pred = PredictionClust$new(
          task = task,
          partition = as.integer(partition$clusters),
          prob = partition$fuzzy_clusters)
      }

      return(pred)
    }
  )
)

learners[["clust.MBatchKMeans"]] = LearnerClustMiniBatchKMeans
