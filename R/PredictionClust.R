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
PredictionClust = R6Class("PredictionClust",
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
as.data.table.PredictionClust = function(x, ...) { # nolint
  tab = as.data.table(x$data[c("row_ids", "partition")])
  if ("prob" %in% x$predict_types) {
    prob = as.data.table(x$data$prob)
    setnames(prob, new = paste0("prob.", names(prob)))
    tab = rcbind(tab, prob)
  }

  tab[]
}

#' @title Convert to a Cluster Prediction
#'
#' @description
#' Convert object to a [PredictionClust].
#'
#' @inheritParams mlr3::as_prediction
#'
#' @return [PredictionClust].
#' @export
#' @examples
#' # create a prediction object
#' task = tsk("usarrests")
#' learner = lrn("clust.kmeans")
#' learner = lrn("clust.cmeans", predict_type = "prob")
#' learner$train(task)
#' p = learner$predict(task)
#'
#' # convert to a data.table
#' tab = as.data.table(p)
#'
#' # convert back to a Prediction
#' as_prediction_clust(tab)
#'
#' # split data.table into a 3 data.tables based on UrbanPop
#' f = cut(task$data(rows = tab$row_ids)$UrbanPop, 3)
#' tabs = split(tab, f)
#'
#' # convert back to list of predictions
#' preds = lapply(tabs, as_prediction_clust)
#'
#' # calculate performance in each group
#' sapply(preds, function(p) p$score(task = task))
as_prediction_clust = function(x, ...) {
  UseMethod("as_prediction_clust")
}


#' @rdname as_prediction_clust
#' @export
as_prediction_clust.PredictionClust = function(x, ...) { # nolint
  x
}


#' @rdname as_prediction_clust
#' @export
as_prediction_clust.data.frame = function(x, ...) { # nolint
  assert_names(names(x), must.include = c("row_ids", "partition"))
  prob_cols = setdiff(names(x), c("row_ids", "partition"))

  if (length(prob_cols)) {
    if (!all(startsWith(prob_cols, "prob."))) {
      stopf("Table may only contain columns 'row_ids', 'partition' as well as columns prefixed with 'prob.' for class probabilities")
    }
    prob = as.matrix(x[, prob_cols, with = FALSE])
    colnames(prob) = substr(colnames(prob), 6L, nchar(colnames(prob)))
  } else {
    prob = NULL
  }

  invoke(PredictionClust$new, prob = prob, .args = x[, -prob_cols, with = FALSE])
}
