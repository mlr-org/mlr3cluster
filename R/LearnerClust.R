#' @title Cluster Learner
#'
#' @usage NULL
#' @format [R6::R6Class] object inheriting from [mlr3::Learner].
#'
#' @description
#' This Learner specializes [mlr3::Learner] for cluster problems.
#' Predefined learners can be found in the [mlr3misc::Dictionary] [mlr3::mlr_learners].
#'
#' @section Construction:
#' ```
#' LearnerClust$new(id, param_set = ParamSet$new(),
#'      predict_types = character(),
#'      feature_types = character(), properties = character(),
#'      packages = character())
#' ```
#' For a description of the arguments, see [mlr3::Learner].
#' `task_type` is set to `"clust"`.
#' Possible values for `predict_type` are `"partition"` and `"prob"`.
#'
#' @section Fields:
#' See [mlr3::Learner].
#'
#' @section Methods:
#' See [mlr3::Learner].
#'
#' @family Learner
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
    initialize = function(id, param_set = ParamSet$new(), predict_types = "partition", feature_types = character(), properties = character(), packages = character()) {
      super$initialize(id = id, task_type = "clust", param_set = param_set, predict_types = predict_types,
        feature_types = feature_types, properties = properties, packages = packages)
    }
  )
)
