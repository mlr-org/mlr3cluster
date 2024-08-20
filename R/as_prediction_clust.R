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
#' if (requireNamespace("e1071")) {
#'   # create a prediction object
#'   task = tsk("usarrests")
#'   learner = lrn("clust.kmeans")
#'   learner = lrn("clust.cmeans", predict_type = "prob")
#'   learner$train(task)
#'   p = learner$predict(task)
#'
#'   # convert to a data.table
#'   tab = as.data.table(p)
#'
#'   # convert back to a Prediction
#'   as_prediction_clust(tab)
#'
#'   # split data.table into a 3 data.tables based on UrbanPop
#'   f = cut(task$data(rows = tab$row_ids)$UrbanPop, 3)
#'   tabs = split(tab, f)
#'
#'   # convert back to list of predictions
#'   preds = lapply(tabs, as_prediction_clust)
#'
#'   # calculate performance in each group
#'   sapply(preds, function(p) p$score(task = task))
#' }
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
      stopf("Table may only contain columns 'row_ids', 'partition' as well as columns prefixed with 'prob.' for class probabilities") # nolint
    }
    prob = as.matrix(x[, prob_cols, with = FALSE])
    colnames(prob) = substr(colnames(prob), 6L, nchar(colnames(prob)))
  } else {
    prob = NULL
  }

  invoke(PredictionClust$new, prob = prob, .args = x[, -prob_cols, with = FALSE])
}
