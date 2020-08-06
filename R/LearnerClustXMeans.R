#' @title X-means Cluster Learner
#'
#' @name mlr_learners_clust.xmeans
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for X-means clustering implemented in [RWeka::XMeans()].
#'
#' @templateVar id clust.xmeans
#' @template section_dictionary_learner
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
          ParamDbl$new(id = "B", default = 1, lower = 0),
          ParamDbl$new(id = "C", default = 0, lower = 0),
          ParamUty$new(id = "D", default = "weka.core.EuclideanDistance"),
          ParamInt$new(id = "H", default = 4L, lower = 1L),
          ParamInt$new(id = "I", default = 1L, lower = 1L),
          ParamInt$new(id = "J", default = 1000L, lower = 1L),
          ParamUty$new(id = "K", default = ""),
          ParamInt$new(id = "L", default = 2L, lower = 1L),
          ParamInt$new(id = "M", default = 1000L, lower = 1L),
          ParamInt$new(id = "S", default = 10L, lower = 1L),
          ParamInt$new(id = "U", default = 0L, lower = 0L),
          ParamLgl$new(id = "use.kdtree", default = FALSE),
          ParamUty$new(id = "N"),
          ParamUty$new(id = "O"),
          ParamUty$new(id = "Y"),
          ParamLgl$new(id = "output.debug.info", default = FALSE)
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
      invoke(RWeka::XMeans, x = task$data(), .args = pv)
    },

    .predict = function(task) {
      partition = predict(self$model, newdata = task$data(), type = "class") + 1L
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
