#' @title Cluster Learner
#'
#' @description
#' This Learner specializes [mlr3::Learner] for cluster problems:
#' * `task_type` is set to `"clust"`.
#' * Creates [Prediction]s of class [PredictionClust].
#' * Possible values for `predict_types` are:
#'   - `"partition"`: Integer indicating the cluster membership.
#'   - `"prob"`: Probability for belonging to each cluster.
#'
#' Predefined learners can be found in the [mlr3misc::Dictionary] [mlr3::mlr_learners].
#'
#' @template param_id
#' @template param_param_set
#' @template param_predict_types
#' @template param_feature_types
#' @template param_learner_properties
#' @template param_data_formats
#' @template param_packages
#' @template param_man
#'
#' @export
#' @examples
#' library(mlr3)
#' ids = mlr_learners$keys("^clust")
#' ids
#'
#' # get a specific learner from mlr_learners:
#' lrn = mlr_learners$get("clust.kmeans")
#' print(lrn)
LearnerClust = R6Class("LearnerClust", inherit = Learner,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function(id, param_set = ParamSet$new(), predict_types = "partition", feature_types = character(), properties = character(), packages = character()) {
      super$initialize(id = id, task_type = "clust", param_set = param_set, predict_types = predict_types,
        feature_types = feature_types, properties = properties, packages = packages)
    }
  )
)
