#' @title Fuzzy Analysis Clustering Learner
#'
#' @name mlr_learners_clust.fanny
#'
#' @description
#' A [LearnerClust] for fuzzy clustering implemented in [cluster::fanny()].
#' [cluster::fanny()] doesn't have a default value for the number of clusters.
#' Therefore, the `k` parameter which corresponds to the number
#' of clusters here is set to 2 by default.
#' The predict method copies cluster assignments and memberships
#' generated for train data. The predict does not work for
#' new data.
#'
#' @templateVar id clust.fanny
#' @template learner
#'
#' @references
#' `r format_bib("kaufman2009finding")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustFanny = R6Class("LearnerClustFanny",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("required", "train")),
        memb.exp = p_dbl(1, default = 2, tags = "train"),
        metric = p_fct(default = "euclidean", levels = c("euclidean", "manhattan", "SqEuclidean"), tags = "train"),
        stand = p_lgl(default = FALSE, tags = "train"),
        maxit = p_int(0L, default = 500L, tags = "train"),
        tol = p_dbl(0, default = 1e-15, tags = "train"),
        trace.lev = p_int(0L, default = 0L, tags = "train")
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.fanny",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = param_set,
        properties = c("partitional", "fuzzy", "complete"),
        packages = "cluster",
        man = "mlr3cluster::mlr_learners_clust.fanny",
        label = "Fuzzy Analysis Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(cluster::fanny, x = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = m$clustering
      }
      m
    },

    .predict = function(task) {
      warn_prediction_useless(self$id)

      partition = self$model$clustering

      prob = self$model$membership
      colnames(prob) = seq_len(ncol(prob))

      PredictionClust$new(task = task, partition = partition, prob = prob)
    }
  )
)

#' @include zzz.R
register_learner("clust.fanny", LearnerClustFanny)
