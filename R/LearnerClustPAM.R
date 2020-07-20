#' @title Partitioning Around Medoids Cluster Learner
#'
#' @name mlr_learners_clust.pam
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for PAM clustering implemented in [cluster::pam()].
#'
#' @templateVar id clust.pam
#' @template section_dictionary_learner
#'
#' @export
LearnerClustPAM = R6Class("LearnerClustPAM", inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      super$initialize(
        id = "clust.pam",
        param_set = ParamSet$new(
          params = list(
            ParamInt$new("k", lower = 1L, tags = c("required", "train")),
            ParamFct$new("metric", levels = c("euclidian", "manhattan"), tags = "train")
          )
        ),
        predict_types = "partition",
        feature_types = c("logical", "integer", "numeric"),
        packages = "cluster"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      invoke(cluster::pam, x = task$data(), diss = FALSE, .args = pv)
    },

    .predict = function(task) {
      partition = unclass(clue::cl_predict(self$model, newdata = task$data(), type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
