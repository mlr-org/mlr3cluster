#' @title Prediction Object for Cluster Analysis
#'
#' @description
#' This object wraps the predictions returned by a learner of class [LearnerClust], i.e.
#' the predicted partition and cluster probability.
#'
#' @family Prediction
#' @export
#' @examples
#' library(mlr3)
#' library(mlr3cluster)
#' task = tsk("usarrests")
#' learner = lrn("clust.kmeans")
#' p = learner$train(task)$predict(task)
#' p$predict_types
#' head(as.data.table(p))
PredictionClust = R6Class(
  "PredictionClust",
  inherit = Prediction,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    #'
    #' @param task ([TaskClust])\cr
    #'   Task, used to extract defaults for `row_ids`.
    #'
    #' @param row_ids (`integer()`)\cr
    #'   Row ids of the predicted observations, i.e. the row ids of the test set.
    #'
    #' @param partition (`integer()`)\cr
    #'   Vector of cluster partitions.
    #'
    #' @param prob (`matrix()`)\cr
    #'   Numeric matrix of cluster membership probabilities with one column for each cluster
    #'   and one row for each observation.
    #'   Columns must be named with cluster numbers, row names are automatically removed.
    #'   If `prob` is provided, but `partition` is not, the cluster memberships are calculated from
    #'   the probabilities using [max.col()] with `ties.method` set to `"first"`.
    #'
    #' @param check (`logical(1)`)\cr
    #'   If `TRUE`, performs some argument checks and predict type conversions.
    initialize = function(task = NULL, row_ids = task$row_ids, partition = NULL, prob = NULL, check = TRUE) {
      pdata = list(row_ids = row_ids, partition = partition, prob = prob)
      pdata = discard(pdata, is.null)
      class(pdata) = c("PredictionDataClust", "PredictionData")

      if (check) {
        pdata = check_prediction_data(pdata)
      }
      self$task_type = "clust"
      self$man = "mlr3cluster::PredictionClust"
      self$data = pdata
      self$predict_types = intersect(c("partition", "prob"), names(pdata))
    }
  ),

  active = list(
    #' @field partition (`integer()`)\cr
    #' Access the stored partition.
    partition = function() {
      self$data$partition %??% rep(NA_real_, length(self$data$row_ids))
    },

    #' @field prob (`matrix()`)\cr
    #' Access to the stored probabilities.
    prob = function() {
      self$data$prob
    }
  )
)

#' @export
as.data.table.PredictionClust = function(x, ...) {
  tab = as.data.table(x$data[c("row_ids", "partition")])
  if ("prob" %chin% x$predict_types) {
    prob = as.data.table(x$data$prob)
    setnames(prob, new = paste0("prob.", names(prob)))
    tab = rcbind(tab, prob)
  }

  tab[]
}
