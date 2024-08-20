#' @title Gaussian Mixture Models-Based Clustering Learner
#'
#' @name mlr_learners_clust.mclust
#'
#' @description
#' A [LearnerClust] for model-based clustering implemented in [mclust::Mclust()].
#' The predict method uses [mclust::predict.Mclust()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.mclust
#' @template learner
#'
#' @references
#' `r format_bib("scrucca2016mclust", "fraley2002model")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustMclust = R6Class("LearnerClustMclust",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      parma_set = ps(
        G = p_uty(default = 1:9, tags = "train", custom_check = check_numeric),
        modelNames = p_uty(tags = "train", custom_check = check_character),
        prior = p_uty(tags = "train", custom_check = check_list),
        control = p_uty(default = mclust::emControl(), tags = "train", custom_check = check_list),
        initialization = p_uty(tags = "train", custom_check = check_list),
        x = p_uty(tags = "train", custom_check = crate(function(x) check_class(x, "mclustBIC")))
      )

      super$initialize(
        id = "clust.mclust",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = parma_set,
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
      m
    },

    .predict = function(task) {
      predictions = invoke(predict, self$model, newdata = task$data())
      partition = as.integer(predictions$classification)
      prob = predictions$z
      PredictionClust$new(task = task, partition = partition, prob = prob)
    }
  )
)

#' @include zzz.R
register_learner("clust.mclust", LearnerClustMclust)
