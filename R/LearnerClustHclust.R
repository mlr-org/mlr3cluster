#' @title Agglomerative Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.hclust
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for agglomerative hierarchical clustering implemented in [stats::hclust()].
#' Difference Calculation is done by [stats::dist()]
#'
#'
#' @templateVar id clust.hclust
#' @template learner
#' @template example
#'
#' @export
LearnerClustHclust = R6Class("LearnerClustHclust",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ps(
        method = p_fct(default = "complete", levels = c("ward.D", "ward.D2", "single", "complete", "average", "mcquitty" , "median", "centroid"), tags = c("train", "hclust")),
        members = p_uty(default = NULL, tags = c("train", "hclust")),
        distmethod = p_fct(default = "euclidean", levels = c("euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski"), tags = "train"),
        diag = p_lgl(default = FALSE, tags = c("train", "dist")),
        upper = p_lgl(default = FALSE, tags = c("train", "dist")),
        p = p_dbl(default = 2L, tags = c("train", "dist")),
        k = p_int(lower = 1L, default = 2L, tags = "predict")
      )

      # param deps
      ps$add_dep("p", "distmethod", CondAnyOf$new("minkowski"))
      ps$values = list(k = 2L, distmethod = "euclidean")

      super$initialize(
        id = "clust.hclust",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "stats",
        label = "Agglomerative Hierarchical Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      d = self$param_set$values$distmethod
      dist_arg = self$param_set$get_values(tags = c("train", "dist"))
      dist = invoke(stats::dist, x = task$data(),
        method = ifelse(is.null(d), "euclidean", d), .args = dist_arg)
      pv = self$param_set$get_values(tags = c("train", "hclust"))
      m = invoke(stats::hclust, d = dist, .args = pv)
      if (self$save_assignments) {
        self$assignments = stats::cutree(m, self$param_set$values$k)
      }

      return(m)
    },

    .predict = function(task) {
      if (self$param_set$values$k > task$nrow) {
        stopf("`k` needs to be between 1 and %i", task$nrow)
      }

      warn_prediction_useless(self$id)

      PredictionClust$new(task = task, partition = self$assignments)
    }
  )
)
