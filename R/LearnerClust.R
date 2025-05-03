#' @title Cluster Learner
#'
#' @description
#' This Learner specializes [mlr3::Learner] for cluster problems:
#' * `task_type` is set to `"clust"`.
#' * Creates [mlr3::Prediction]s of class [PredictionClust].
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
#' @template param_label
#' @template param_man
#'
#' @export
#' @examples
#' library(mlr3)
#' library(mlr3cluster)
#' ids = mlr_learners$keys("^clust")
#' ids
#'
#' # get a specific learner from mlr_learners:
#' learner = lrn("clust.kmeans")
#' print(learner)
LearnerClust = R6Class(
  "LearnerClust",
  inherit = Learner,
  public = list(
    #' @field assignments (`NULL` | `vector()`)\cr
    #' Cluster assignments from learned model.
    assignments = NULL,

    #' @field save_assignments (`logical()`)\cr
    #' Should assignments for 'train' data be saved in the learner?
    #' Default is `TRUE`.
    save_assignments = TRUE,

    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function(
      id,
      param_set = ps(),
      predict_types = "partition",
      feature_types = character(),
      properties = character(),
      packages = character(),
      label = NA_character_,
      man = NA_character_
    ) {
      super$initialize(
        id = id,
        task_type = "clust",
        param_set = param_set,
        predict_types = predict_types,
        feature_types = feature_types,
        properties = properties,
        packages = c("mlr3cluster", packages),
        label = label,
        man = man
      )
    },

    #' @description
    #' Reset `assignments` field before calling parent's `reset()`.
    reset = function() {
      self$assignments = NULL
      super$reset()
    }
  )
)
