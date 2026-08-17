#' @title Prediction Strength
#'
#' @include MeasureClust.R
#'
#' @description
#' The prediction strength assesses how well a clustering generalizes to new data. The learner is refit on the
#' evaluation data to obtain a reference partition, and each reference cluster is checked against the prediction of
#' the model trained on the original training data: for each reference cluster \eqn{A_j}, the score is the proportion
#' of observation pairs in \eqn{A_j} that the trained model also assigns to a common cluster, and the measure returns
#' the minimum over all reference clusters. Values range from 0 to 1, with higher values indicating that the
#' clustering is stable under resampling. Tibshirani and Walther (2005) suggest choosing the largest number of
#' clusters with a prediction strength above 0.8 to 0.9.
#'
#' @details
#' The measure requires the [mlr3::Learner] to refit on the evaluation data, so scoring is as expensive as training
#' and is stochastic for learners with random initialization. Reference clusters with fewer than 2 observations score
#' a perfect 1. The measure is intended for predictions on data disjoint from the training data, e.g. via holdout or
#' cross-validation resampling; scored on the training data itself, the reference partition coincides with the
#' trained model and the score is trivially high.
#'
#' @templateVar id pred_strength
#' @template measure_clust
#'
#' @references
#' `r format_bib("tibshirani2005cluster")`
#'
#' @export
MeasureClustPredStrength = R6Class(
  "MeasureClustPredStrength",
  inherit = MeasureClust,
  cloneable = FALSE,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      super$initialize(
        id = "clust.pred_strength",
        range = c(0, 1),
        minimize = FALSE,
        predict_type = "partition",
        properties = c("requires_task", "requires_learner"),
        label = "Prediction Strength",
        man = "mlr3cluster::mlr_measures_clust.pred_strength"
      )
    }
  ),
  private = list(
    .score = function(prediction, task, learner, ...) {
      if (length(prediction$row_ids) == 0L) {
        return(NaN)
      }

      # refit the learner on the evaluation data to obtain the reference partition
      refit = learner$clone(deep = TRUE)
      test_task = task$clone()$filter(prediction$row_ids)
      refit$train(test_task)
      reference = refit$predict(test_task)
      reference = reference$partition[match(prediction$row_ids, reference$row_ids)]

      # for each reference cluster, the proportion of its observation pairs that the
      # trained model also assigns to a common cluster; the worst cluster governs
      min(map_dbl(split(prediction$partition, reference), function(cl) {
        n = length(cl)
        if (n < 2L) {
          return(1)
        }
        sizes = as.integer(table(cl))
        sum(sizes * (sizes - 1L)) / (n * (n - 1L))
      }))
    }
  )
)
