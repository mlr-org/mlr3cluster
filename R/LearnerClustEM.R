#' @title Expectation-Maximization Clustering Learner
#'
#' @name mlr_learners_clust.em
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for Expectation-Maximization clustering implemented in
#' [RWeka::list_Weka_interfaces()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.em
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustEM = R6Class("LearnerClustEM",
  inherit = LearnerClust,
  public = list(
   #' @description
   #' Creates a new instance of this [R6][R6::R6Class] class.
   initialize = function() {
     ps = ParamSet$new(
       params = list(
         ParamInt$new(id = "I", default = 100L, lower = 1L, tags = "train"),
         ParamDbl$new(id = "ll_cv", default = 1e-6, lower = 1e-6, tags = "train"),
         ParamDbl$new(id = "ll_iter", default = 1e-6, lower = 1e-6, tags = "train"),
         ParamDbl$new(id = "M", default = 1e-6, lower = 1e-6, tags = "train"),
         ParamInt$new(id = "max", default = -1L, lower = -1L, tags = "train"),
         ParamInt$new(id = "N", default = -1L, lower = -1L, tags = "train"),
         ParamInt$new(id = "num_slots", default = 1L, lower = 1L, tags = "train"),
         ParamInt$new(id = "S", default = 100L, lower = 0L, tags = "train"),
         ParamInt$new(id = "X", default = 10L, lower = 1L, tags = "train"),
         ParamInt$new(id = "K", default = 10L, lower = 1L, tags = "train"),
         ParamLgl$new(id = "V", default = FALSE, tags = "train"),
         ParamLgl$new(id = "output_debug_info", default = FALSE, tags = "train")
       )
     )

     super$initialize(
       id = "clust.em",
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
     invoke(RWeka::make_Weka_clusterer("weka/clusterers/EM"), x = task$data(), control = ctrl)
   },

   .predict = function(task) {
     partition = predict(self$model, newdata = task$data(), type = "class") + 1L
     PredictionClust$new(task = task, partition = partition)
   }
  )
)
