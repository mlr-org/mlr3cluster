#' @title Divisive Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.diana
#'
#' @description
#' Divisive hierarchical clustering.
#' Calls [cluster::diana()] from package \CRANpkg{cluster}.
#'
#' The predict method uses [stats::cutree()] which cuts the tree resulting from
#' hierarchical clustering into specified number of groups (see parameter `k`).
#' The default value for `k` is 2.
#'
#' @templateVar id clust.diana
#' @template learner
#'
#' @references
#' `r format_bib("kaufman2009finding")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustDiana = R6Class("LearnerClustDiana",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        metric = p_fct(c("euclidean", "manhattan"), default = "euclidean", tags = "train"),
        stand = p_lgl(default = FALSE, tags = "train"),
        trace.lev = p_int(0L, default = 0L, tags = "train"),
        k = p_int(1L, default = 2L, tags = c("train", "predict"))
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.diana",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "cluster",
        man = "mlr3cluster::mlr_learners_clust.diana",
        label = "Divisive Analysis"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(
        cluster::diana,
        x = task$data(),
        diss = FALSE,
        .args = remove_named(pv, "k")
      )
      if (self$save_assignments) {
        self$assignments = stats::cutree(m, pv$k)
      }
      m
    },

    .predict = function(task) {
      pv = self$param_set$get_values(tags = "predict")
      if (pv$k > task$nrow) {
        error_input("`k` needs to be between 1 and %i.", task$nrow)
      }

      warn_prediction_useless(self$id)

      PredictionClust$new(task = task, partition = self$assignments)
    }
  )
)

#' @include zzz.R
register_learner("clust.diana", LearnerClustDiana)
