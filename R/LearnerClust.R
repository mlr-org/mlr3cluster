#' @title Cluster Learner
#'
#' @description
#' This Learner specializes [mlr3::Learner] for cluster problems:
#'
#' * `task_type` is set to `"clust"`.
#' * Creates [mlr3::Prediction]s of class [PredictionClust].
#' * Possible values for `predict_types` are:
#'   - `"partition"`: Integer indicating the cluster membership.
#'   - `"prob"`: Probability for belonging to each cluster.
#' * Additional learner properties classify the learner along the clustering taxonomy of Tan, Steinbach, and Kumar
#'   (2005), with exactly one membership, one coverage, and one algorithm family property:
#'   - `"exclusive"`: The method natively assigns each observation to exactly one cluster.
#'   - `"overlapping"`: The method natively assigns observations to multiple clusters.
#'   - `"fuzzy"`: The method natively produces soft cluster memberships, e.g. fuzzy or probabilistic model-based
#'     methods. The hard partition is derived from the memberships.
#'   - `"complete"`: Every observation is assigned to a cluster.
#'   - `"partial"`: Observations may be left unassigned, e.g. as noise points.
#'   - `"partitional"`: The method divides the data into non-nested clusters.
#'   - `"hierarchical"`: The method produces a nested hierarchy of clusters.
#'   - `"density"`: The method finds clusters as dense regions in the feature space.
#'
#'   These properties describe the nature of the underlying method, not its interface capabilities: whether a learner
#'   can return soft memberships is encoded by the `"prob"` predict type, which `"exclusive"` learners may also
#'   support via derived scores.
#'
#' Predefined learners can be found in the [mlr3misc::Dictionary] [mlr3::mlr_learners].
#'
#' @template param_id
#' @template param_param_set
#' @template param_predict_types
#' @template param_feature_types
#' @template param_learner_properties
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

    #' @field save_assignments (`logical(1)`)\cr
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
