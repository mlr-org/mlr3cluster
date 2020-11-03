#' @title Fuzzy Analysis Cluster Learner
#'
#' @name mlr_learners_clust.fanny
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for fuzzy clustering implemented in [cluster::fanny()].
#' [cluster::fanny()] doesn't have a deafult value for the number of clusters.
#' Therefore, the `k` parameter which correponds to the number
#' of clusters here is set to 2 by default.
#' The predict method copies cluster assignments and memberships
#' generated for train data. The predict does not work for
#' new data.
#'
#' @templateVar id clust.fanny
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustFanny = R6Class("LearnerClustFanny",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamInt$new(id = "k", lower = 1L, default = 2L, tags = c("required", "train")),
          ParamDbl$new(id = "memb.exp", lower = 1L, default = 2L, tags = "train"),
          ParamFct$new(
            id = "metric", default = "euclidean",
            levels = c("euclidean", "manhattan", "SqEuclidean"), tags = "train"),
          ParamLgl$new(id = "stand", default = FALSE, tags = "train"),
          ParamInt$new(id = "maxit", lower = 0L, default = 500L, tags = "train"),
          ParamDbl$new(id = "tol", lower = 0L, default = 1e-15, tags = "train"),
          ParamInt$new(id = "trace.lev", lower = 0L, default = 0L, tags = "train")
        )
      )
      ps$values = list(k = 2L)

      super$initialize(
        id = "clust.fanny",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = ps,
        properties = c("partitional", "fuzzy", "complete"),
        packages = "cluster"
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

      return(m)
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
