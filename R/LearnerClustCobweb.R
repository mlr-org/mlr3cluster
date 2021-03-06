#' @title Cobweb Clustering Learner
#'
#' @name mlr_learners_clust.cobweb
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for Cobweb clustering implemented in [RWeka::Cobweb()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.cobweb
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustCobweb = R6Class("LearnerClustCobweb",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamDbl$new(id = "A", default = 1, lower = 0, tags = "train"),
          ParamDbl$new(id = "C", default = 0.002, lower = 0, tags = "train"),
          ParamInt$new(id = "S", default = 42L, lower = 1L, tags = "train")
        )
      )

      super$initialize(
        id = "clust.cobweb",
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
      ctrl = do.call(RWeka::Weka_control, pv)
      m = invoke(RWeka::Cobweb, x = task$data(), control = ctrl)
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
