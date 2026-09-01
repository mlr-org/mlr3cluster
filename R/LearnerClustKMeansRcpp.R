#' @title K-Means Clustering Learner from ClusterR
#'
#' @name mlr_learners_clust.kmeans_rcpp
#'
#' @description
#' K-means clustering.
#' Calls [ClusterR::KMeans_rcpp()] from package \CRANpkg{ClusterR}.
#'
#' The `clusters` parameter is set to 2 by default since [ClusterR::KMeans_rcpp()] doesn't have a default value for
#' the number of clusters. The predict method computes the cluster memberships for new data via the fitted centroids.
#'
#' @templateVar id clust.kmeans_rcpp
#' @template learner
#'
#' @references
#' `r format_bib("hartigan1979algorithm", "lloyd1982least", "arthur2007kmeans")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustKMeansRcpp = R6Class(
  "LearnerClustKMeansRcpp",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        clusters = p_int(1L, tags = c("train", "required")),
        num_init = p_int(1L, default = 1L, tags = "train"),
        max_iters = p_int(1L, default = 100L, tags = "train"),
        initializer = p_fct(
          c("optimal_init", "quantile_init", "kmeans++", "random"),
          default = "kmeans++",
          tags = "train"
        ),
        verbose = p_lgl(default = FALSE, tags = "train"),
        CENTROIDS = p_uty(default = NULL, tags = "train"),
        tol = p_dbl(0, default = 1e-04, tags = "train"),
        tol_optimal_init = p_dbl(0, default = 0.3, tags = "train"),
        seed = p_int(default = 1L, tags = "train"),
        threads = p_int(1L, default = 1L, tags = c("predict", "threads"))
      )

      param_set$set_values(clusters = 2L)

      super$initialize(
        id = "clust.kmeans_rcpp",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "ClusterR",
        man = "mlr3cluster::mlr_learners_clust.kmeans_rcpp",
        label = "K-Means (ClusterR)"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      assert_centers_param(pv$CENTROIDS, task, "CENTROIDS")
      if (test_matrix(pv$CENTROIDS) && nrow(pv$CENTROIDS) != pv$clusters) {
        error_config("`CENTROIDS` must have same number of rows as `clusters`.")
      }

      m = invoke(ClusterR::KMeans_rcpp, data = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m$clusters)
      }
      m
    },

    .predict = function(task) {
      pv = self$param_set$get_values(tags = "predict")
      data = ordered_features(task, self)
      partition = as.integer(invoke(predict, self$model, newdata = data, .args = pv))
      prob = NULL
      if (self$predict_type == "prob") {
        prob = invoke(predict, self$model, newdata = data, fuzzy = TRUE, .args = pv)
        colnames(prob) = seq_col(prob)
      }
      list(partition = partition, prob = prob)
    }
  )
)

#' @include zzz.R
register_learner("clust.kmeans_rcpp", LearnerClustKMeansRcpp)
