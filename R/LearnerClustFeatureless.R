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
     ps = ParamSet$new(
       params = list(
         ParamInt$new(id = "num.clusters", lower = 1L, default = 1L, tags = c("required", "train"))
     ))
     ps$values = list(num.clusters = 1L)

     super$initialize(
       id = "clust.featureless",
       param_set = ps,
       predict_types = "partition",
       feature_types = c("logical", "integer", "numeric")
     )
   }
  ),

  private = list(
   .train = function(task) {
     pv = self$param_set$get_values(tags = "train")
     n = task$nrow
     if (pv$num.clusters > n) {
        stop("number of clusters must lie between 1 and nrow(data)",
             call. = FALSE)
     } else if (pv$num.clusters == n) {
       clustering = seq_along(1:n)
     } else {
       times = c(rep.int(n / pv$num.clusters, pv$num.clusters - 1),
                 n - (pv$num.clusters - 1) * floor(n / pv$num.clusters))

       clustering = rep.int(seq_along(1:pv$num.clusters),
                            times = times)
     }

     list(clustering = clustering)
   },

   .predict = function(task) {
     n = task$nrow
     pv = self$param_set$get_values(tags = "train")
     if (n <= pv$num.clusters) {
        partition = seq_along(1:n)
     } else {
        times = c(rep.int(n / pv$num.clusters, pv$num.clusters - 1),
                  n - (pv$num.clusters - 1) * floor(n / pv$num.clusters))

        partition = rep.int(seq_along(1:pv$num.clusters),
                             times = times)
     }
     PredictionClust$new(task = task, partition = partition)
   }
  )
)
