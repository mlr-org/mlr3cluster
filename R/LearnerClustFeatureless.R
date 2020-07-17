#' @title Featureless Clustering Learner
#'
#' @name mlr_learners_clust.featureless
#' @include LearnerClust.R
#'
#' @description
#' A simple [LearnerClust] which assigns first n observations to cluster 1,
#' second n observations to cluster 2, and so on.
#' Hyperparameter `num.clusters` controls the number of clusters.
#'
#' @templateVar id clust.featureless
#' @template section_dictionary_learner
#'
#' @export
LearnerClustFeatureless = R6Class("LearnerClustFeatureless", inherit = LearnerClust,
  public = list(
   #' @description
   #' Creates a new instance of this [R6][R6::R6Class] class.
   initialize = function() {
     super$initialize(
       id = "clust.featureless",
       param_set = ParamSet$new(
         params = list(
           ParamInt$new(id = "num.clusters", lower = 1L, tags = c("required", "train"))
         )
       ),
       predict_types = "partition",
       feature_types = c("logical", "integer", "numeric")
     )
   }
  ),

  private = list(
   .train = function(task) {
     pv = self$param_set$get_values(tags = "train")
     x = task$data()
     if(pv$num.clusters >= nrow(x)) {
        stop("number of cluster centres must lie between 1 and nrow(data)",
             call.=FALSE)
     }

     times = c(rep.int(nrow(x) / pv$num.clusters, pv$num.clusters- 1),
               nrow(x) - (pv$num.clusters - 1) * floor(nrow(x) / pv$num.clusters))

     clustering = rep.int(seq_along(1:pv$num.clusters),
        times = times)
     list(clustering = clustering)
   },

   .predict = function(task) {
     partition = self$model$clustering
     PredictionClust$new(task = task, partition = partition)
   }
  )
)

