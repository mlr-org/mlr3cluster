#' @title K Means Clustering Algorithm Learner from Weka
#'
#' @name mlr_learners_clust.SimpleKMeans
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for Simple K Means clustering implemented in [RWeka::SimpleKMeans()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.SimpleKMeans
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustSimpleKMeans = R6Class("LearnerClustSimpleKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamUty$new(id = "A", default = "weka.core.EuclideanDistance", tags = "train"),
          ParamLgl$new(id = "C", default = FALSE, tags = "train"),
          ParamLgl$new(id = "fast", default = FALSE, tags = "train"),
          ParamInt$new(id = "I", default = 100L, lower = 1L, tags = "train"),
          ParamInt$new(id = "init", default = 0L, lower = 0L, upper = 3L, tags = "train"),
          ParamLgl$new(id = "M", default = FALSE, tags = "train"),
          ParamInt$new(id = "max_candidates", default = 100L, lower = 1L, tags = "train"),
          ParamInt$new(id = "min_density", default = 2L, lower = 1L, tags = "train"),
          ParamInt$new(id = "N", default = 2L, lower = 1L, tags = "train"),
          ParamInt$new(id = "num_slots", default = 1L, lower = 1L, tags = "train"),
          ParamLgl$new(id = "O", default = FALSE, tags = "train"),
          ParamInt$new(id = "periodic_pruning", default = 10000L, lower = 1L, tags = "train"),
          ParamInt$new(id = "S", default = 10L, lower = 0L, tags = "train"),
          ParamDbl$new(id = "t2", default = -1, tags = "train"),
          ParamDbl$new(id = "t1", default = -1.5, tags = "train"),
          ParamLgl$new(id = "V", default = FALSE, tags = "train"),
          ParamLgl$new(id = "output_debug_info", default = FALSE, tags = "train")
        )
      )

      super$initialize(
        id = "clust.SimpleKMeans",
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
      m = invoke(RWeka::SimpleKMeans, x = task$data(), control = ctrl)

      self$assignments = unname(m$class_ids + 1L)

      return(m)
    },

    .predict = function(task) {
      partition = predict(self$model, newdata = task$data(), type = "class") + 1L
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
