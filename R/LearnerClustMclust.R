#' @title Gaussian Mixture Models-Based Clustering Learner
#'
#' @name mlr_learners_clust.mclust
#' @include LearnerClust.R
#' @include aaa.R
#'
#' @description
#' A [LearnerClust] for model-based clustering implemented in [mclust::Mclust()].
#' The predict method uses [mclust::predict.Mclust()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.mclust
#' @template learner
#' @template example
#'
#' @export
LearnerClustMclust = R6Class("LearnerClustMclust",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ps(
        G = p_uty(default = c(1:9), custom_check = function(x) {
          if (test_numeric(x)) {
            return(TRUE)
          } else {
            stop("`G` need to be a numeric vector")
          }
        }, tags = "train"),
        modelNames = p_uty(custom_check = function(x) {
          if (test_character(x)) {
            return(TRUE)
          } else {
            stop("`modelNames` need to be a character vector")
          }
        }, tags = "train"),
        prior = p_uty(custom_check = function(x) {
          if (test_list(x)) {
            return(TRUE)
          } else {
            stop("`prior` need to be a list")
          }
        }, tags = "train"),
        control = p_uty(default = mclust::emControl(), custom_check = function(x) {
          if (test_list(x)) {
            return(TRUE)
          } else {
            stop("`control` need to be a list of control parameters for EM")
          }
        }, tags = "train"),
        initialization = p_uty(custom_check = function(x) {
          if (test_list(x)) {
            return(TRUE)
          } else {
            stop("`initialization` need to be a list of initialization components")
          }
        }, tags = "train"),
        x = p_uty(custom_check = function(x) {
          if (test_class(x, "mclustBIC")) {
            return(TRUE)
          } else {
            stop("`x` need to be an object of class 'mclustBIC'")
          }
        }, tags = "train")
      )

      super$initialize(
        id = "clust.mclust",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = ps,
        properties = c("partitional", "fuzzy", "complete"),
        packages = "mclust",
        man = "mlr3cluster::mlr_learners_clust.mclust",
        label = "Gaussian Mixture Models Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      with_package("mclust", {
        m = invoke(mclust::Mclust, data = task$data(), .args = pv)
      })
      if (self$save_assignments) {
        self$assignments = m$classification
      }

      return(m)
    },

    .predict = function(task) {
      predictions = predict(self$model, newdata = task$data())
      partition = as.integer(predictions$classification)
      prob = predictions$z
      PredictionClust$new(task = task, partition = partition, prob = prob)
    }
  )
)

learners[["clust.mclust"]] = LearnerClustMclust
