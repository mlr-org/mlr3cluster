#' @title Agglomerative Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.agnes
#' @include LearnerClust.R
#' @include aaa.R
#'
#' @description
#' A [LearnerClust] for agglomerative hierarchical clustering implemented in [cluster::agnes()].
#' The predict method uses [stats::cutree()] which cuts the tree resulting from
#' hierarchical clustering into specified number of groups (see parameter `k`).
#' The default number for `k` is 2.
#'
#' @templateVar id clust.agnes
#' @template learner
#' @template example
#'
#' @export
LearnerClustAgnes = R6Class("LearnerClustAgnes",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ps(
        metric = p_fct(default = "euclidean", levels = c("euclidean", "manhattan"), tags = "train"),
        stand = p_lgl(default = FALSE, tags = "train"),
        method = p_fct(default = "average", levels = c("average", "single", "complete", "ward", "weighted", "flexible", "gaverage"), tags = "train"),
        trace.lev = p_int(lower = 0L, default = 0L, tags = "train"),
        k = p_int(lower = 1L, default = 2L, tags = "predict"),
        par.method = p_uty(tags = "train", custom_check = crate(function(x) {
          if (!(test_numeric(x) || test_list(x))) {
            return("`par.method` needs to be a numeric vector")
          }
          if (length(x) %in% c(1L, 3L, 4L)) {
            TRUE
          } else {
            "`par.method` needs be of length 1, 3, or 4"
          }
        }))
      )

      # param deps
      ps$add_dep("par.method", "method", CondAnyOf$new(c("flexible", "gaverage")))

      ps$set_values(k = 2L)

      super$initialize(
        id = "clust.agnes",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "cluster",
        man = "mlr3cluster::mlr_learners_clust.agnes",
        label = "Agglomerative Hierarchical Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(cluster::agnes, x = task$data(), diss = FALSE, .args = pv)
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

learners[["clust.agnes"]] = LearnerClustAgnes
