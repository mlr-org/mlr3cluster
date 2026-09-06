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
#' learner = lrn("clust.featureless", num_clusters = 2L)
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
    #' @param task ([TaskClust] | `NULL`)\cr
    #'   Task, used to extract defaults for `row_ids`.
    #'
    #' @param row_ids (`integer()`)\cr
    #'   Row ids of the predicted observations, i.e. the row ids of the test set.
    #'
    #' @param partition (`integer()` | `NULL`)\cr
    #'   Vector of cluster partitions.
    #'
    #' @param prob (`matrix()` | `NULL`)\cr
    #'   Numeric matrix of cluster membership probabilities with one column for each cluster
    #'   and one row for each observation.
    #'   Columns must be named with cluster numbers, row names are automatically removed.
    #'   If `prob` is provided, but `partition` is not, the cluster memberships are calculated from
    #'   the probabilities: each observation is assigned the cluster label (column name) of its most
    #'   probable cluster, with ties broken by the first maximum.
    #'
    #' @param weights (`numeric()`)\cr
    #'   Vector of measure weights for each observation. Should be constructed from the [TaskClust]'s
    #'   `weights_measure` column.
    #'
    #' @param check (`logical(1)`)\cr
    #'   If `TRUE`, performs some argument checks and predict type conversions.
    #'
    #' @param extra (`list()`)\cr
    #'   List of extra data to be stored in the prediction object.
    #'
    #' @param raw (any)\cr
    #'   Raw prediction object from the upstream model. Stored as-is without validation.
    initialize = function(
      task = NULL,
      row_ids = task$row_ids,
      partition = NULL,
      prob = NULL,
      weights = NULL,
      check = TRUE,
      extra = NULL,
      raw = NULL
    ) {
      pdata = list(
        row_ids = row_ids,
        partition = partition,
        prob = prob,
        weights = weights,
        extra = extra,
        raw = raw
      )
      pdata = set_class(discard(pdata, is.null), c("PredictionDataClust", "PredictionData"))

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
    partition = function(rhs) {
      assert_ro_binding(rhs)
      self$data$partition %??% rep(NA_integer_, length(self$data$row_ids))
    },

    #' @field prob (`matrix()` | `NULL`)\cr
    #' Access to the stored probabilities.
    prob = function(rhs) {
      assert_ro_binding(rhs)
      self$data$prob
    }
  )
)

#' @export
as.data.table.PredictionClust = function(x, ...) {
  tab = data.table(row_ids = x$data$row_ids, partition = x$partition)
  if ("prob" %chin% x$predict_types && ncol(x$data$prob) > 0L) {
    prob = as.data.table(x$data$prob)
    setnames(prob, new = paste0("prob.", names(prob)))
    tab = rcbind(tab, prob)
  }

  if (!is.null(x$data$weights)) {
    tab$weights = x$data$weights
  }

  if (!is.null(x$data$extra)) {
    tab = rcbind(tab, as.data.table(x$data$extra))
  }

  tab[]
}
