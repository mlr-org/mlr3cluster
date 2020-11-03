#' @title X-means Cluster Learner
#'
#' @name mlr_learners_clust.xmeans
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for X-means clustering implemented in [RWeka::XMeans()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.xmeans
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustXMeans = R6Class("LearnerClustXMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamDbl$new(id = "B", default = 1, lower = 0, tags = "train"),
          ParamDbl$new(id = "C", default = 0, lower = 0, tags = "train"),
          ParamUty$new(id = "D", default = "weka.core.EuclideanDistance", tags = "train"),
          ParamInt$new(id = "H", default = 4L, lower = 1L, tags = "train"),
          ParamInt$new(id = "I", default = 1L, lower = 1L, tags = "train"),
          ParamInt$new(id = "J", default = 1000L, lower = 1L, tags = "train"),
          ParamUty$new(id = "K", default = "", tags = "train"),
          ParamInt$new(id = "L", default = 2L, lower = 1L, tags = "train"),
          ParamInt$new(id = "M", default = 1000L, lower = 1L, tags = "train"),
          ParamInt$new(id = "S", default = 10L, lower = 1L, tags = "train"),
          ParamInt$new(id = "U", default = 0L, lower = 0L, tags = "train"),
          ParamLgl$new(id = "use_kdtree", default = FALSE, tags = "train"),
          ParamUty$new(id = "N", tags = "train"),
          ParamUty$new(id = "O", tags = "train"),
          ParamUty$new(id = "Y", tags = "train"),
          ParamLgl$new(id = "output_debug_info", default = FALSE, tags = "train")
        )
      )

      super$initialize(
        id = "clust.xmeans",
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
      m = invoke(RWeka::XMeans, x = task$data(), control = ctrl)
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
