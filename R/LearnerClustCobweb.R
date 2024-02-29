#' @title Cobweb Clustering Learner
#'
#' @name mlr_learners_clust.cobweb
#'
#' @description
#' A [LearnerClust] for Cobweb clustering implemented in [RWeka::Cobweb()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.cobweb
#' @template learner
#' @template example
#'
#' @export
LearnerClustCobweb = R6Class("LearnerClustCobweb",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        A = p_dbl(0, default = 1, tags = "train"),
        C = p_dbl(0, default = 0.002, tags = "train"),
        S = p_int(1L, default = 42L, tags = "train")
      )

      super$initialize(
        id = "clust.cobweb",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "RWeka",
        man = "mlr3cluster::mlr_learners_clust.cobweb",
        label = "Cobweb Clustering"
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

#' @include aaa.R
learners[["clust.cobweb"]] = LearnerClustCobweb
