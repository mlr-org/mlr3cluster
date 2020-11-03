#' @title Farthest First Clustering Algorithm Learner
#'
#' @name mlr_learners_clust.FF
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for Farthest First clustering implemented in [RWeka::FarthestFirst()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.ff
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustFarthestFirst = R6Class("LearnerClustFF",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamInt$new(id = "N", default = 2L, lower = 1L, tags = "train"),
          ParamInt$new(id = "S", default = 1L, lower = 1L, tags = "train"),
          ParamLgl$new(id = "output_debug_info", default = FALSE, tags = "train")
        )
      )

      super$initialize(
        id = "clust.ff",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("partitional", "exclusive", "complete"),
        packages = "RWeka"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      names(pv) = chartr("_", "-", names(pv))
      ctrl = do.call(RWeka::Weka_control, pv)
      m = invoke(RWeka::FarthestFirst, x = task$data(), control = ctrl)
      if (self$save_assignments) {
        self$assignments = unname(m$class_ids + 1L)
      }

      return(m)
    },

    .predict = function(task) {
      partition = predict(self$model, newdata = task$data(), type = "class") + 1L
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
