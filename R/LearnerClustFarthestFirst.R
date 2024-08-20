#' @title Farthest First Clustering Learner
#'
#' @name mlr_learners_clust.ff
#'
#' @description
#' A [LearnerClust] for Farthest First clustering implemented in [RWeka::FarthestFirst()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
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
LearnerClustFarthestFirst = R6Class("LearnerClustFF",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        N = p_int(1L, default = 2L, tags = "train"),
        S = p_int(1L, default = 1L, tags = "train"),
        output_debug_info = p_lgl(default = FALSE, tags = "train")
      )

      super$initialize(
        id = "clust.ff",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "RWeka",
        man = "mlr3cluster::mlr_learners_clust.ff",
        label = "Farthest First Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      names(pv) = chartr("_", "-", names(pv))
      ctrl = invoke(RWeka::Weka_control, .args = pv)
      m = invoke(RWeka::FarthestFirst, x = task$data(), control = ctrl)
      if (self$save_assignments) {
        self$assignments = unname(m$class_ids + 1L)
      }
      m
    },

    .predict = function(task) {
      partition = invoke(predict, self$model, newdata = task$data(), type = "class") + 1L
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.ff", LearnerClustFarthestFirst)
