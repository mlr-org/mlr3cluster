#' @title Convert to a Cluster Prediction
#'
#' @description
#' Convert object to a [PredictionClust].
#' For a `data.frame`, the columns `row_ids` and `partition` are required.
#' Columns prefixed with `prob.` are collected into the probability matrix, `weights` are stored as measure weights,
#' and all remaining columns are stored as extra data in the `extra` field of the prediction.
#'
#' @inheritParams mlr3::as_prediction
#'
#' @return [PredictionClust].
#' @export
#' @examplesIf mlr3misc::require_namespaces(c("e1071", "clue"), quietly = TRUE)
#' # create a prediction object
#' task = tsk("usarrests")
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
as_prediction_clust.PredictionClust = function(x, ...) {
  x
}

#' @rdname as_prediction_clust
#' @export
as_prediction_clust.data.frame = function(x, ...) {
  assert_names(names(x), must.include = c("row_ids", "partition"))
  x = as.data.table(x)
  prob_cols = names(x)[startsWith(names(x), "prob.")]
  extra_cols = setdiff(names(x), c("row_ids", "partition", "weights", prob_cols))

  prob = if (length(prob_cols) > 0L) {
    prob = as.matrix(x[, prob_cols, with = FALSE])
    cn = colnames(prob)
    colnames(prob) = substr(cn, 6L, nchar(cn))
    prob
  }
  extra = if (length(extra_cols) > 0L) as.list(x[, extra_cols, with = FALSE])

  args = x[, setdiff(names(x), c(prob_cols, extra_cols)), with = FALSE]
  invoke(PredictionClust$new, prob = prob, extra = extra, .args = args)
}
