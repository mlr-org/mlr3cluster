#' @title Farthest First Clustering Learner
#'
#' @name mlr_learners_clust.ff
#'
#' @description
#' Farthest First clustering.
#' Calls [RWeka::FarthestFirst()] from package \CRANpkg{RWeka}.
#'
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the cluster memberships for new data.
#'
#' @templateVar id clust.ff
#' @template learner
#'
#' @references
#' `r format_bib("witten2002data", "hochbaum1985best")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustFarthestFirst = R6Class(
  "LearnerClustFarthestFirst",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        N = p_int(1L, default = 2L, tags = "train"),
        S = p_int(0L, default = 1L, tags = "train"),
        output_debug_info = p_lgl(default = FALSE, tags = "train")
      )

      super$initialize(
        id = "clust.ff",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete", "missings", "marshal"),
        packages = "RWeka",
        man = "mlr3cluster::mlr_learners_clust.ff",
        label = "Farthest First"
      )
    },

    #' @description
    #' Marshal the learner's model.
    #' @param ... (any)\cr
    #'   Additional arguments passed to [mlr3::marshal_model()].
    marshal = function(...) {
      learner_marshal(.learner = self, ...)
    },

    #' @description
    #' Unmarshal the learner's model.
    #' @param ... (any)\cr
    #'   Additional arguments passed to [mlr3::unmarshal_model()].
    unmarshal = function(...) {
      learner_unmarshal(.learner = self, ...)
    }
  ),

  active = list(
    #' @field marshaled (`logical(1)`)\cr
    #' Whether the learner's model is marshaled.
    marshaled = function() {
      learner_marshaled(self)
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      ctrl = weka_control(pv)
      m = invoke(RWeka::FarthestFirst, x = task$data(), control = ctrl)
      if (self$save_assignments) {
        self$assignments = unname(m$class_ids + 1L)
      }
      m
    },

    .predict = function(task) {
      partition = invoke(predict, self$model, newdata = ordered_features(task, self), type = "class_ids") + 1L
      list(partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.ff", LearnerClustFarthestFirst)
