#' @export
as_prediction.PredictionDataClust = function(x, check = TRUE, ...) {
  invoke(PredictionClust$new, check = check, .args = x)
}

#' @export
check_prediction_data.PredictionDataClust = function(pdata, ...) {
  pdata$row_ids = assert_row_ids(pdata$row_ids)
  n = length(pdata$row_ids)
  assert_integer(pdata$partition, len = n, any.missing = FALSE, null.ok = TRUE)

  if (!is.null(pdata$weights)) {
    # weights may never be NA, even if no prediction was made
    pdata$weights = assert_numeric(unname(pdata$weights), len = n, any.missing = FALSE)
  }

  prob = pdata$prob
  if (!is.null(prob)) {
    # need to check number of columns for matrix
    assert_matrix(prob, nrows = n)
    assert_numeric(prob, lower = 0, upper = 1)
    if (!is.null(rownames(prob))) {
      rownames(prob) = NULL
      pdata$prob = prob
    }

    labels = suppressWarnings(as.integer(colnames(prob)))
    if (!length(labels) || anyNA(labels)) {
      labels = seq_col(prob)
    }

    if (is.null(pdata$partition)) {
      pdata$partition = labels[max.col(prob, ties.method = "first")]
    } else if (ncol(prob) > 0L) {
      assert_subset(pdata$partition, labels, .var.name = "partition")
    }
  }

  pdata
}

#' @export
is_missing_prediction_data.PredictionDataClust = function(pdata, ...) {
  miss = logical(length(pdata$row_ids))

  if (!is.null(pdata$partition)) {
    miss = is.na(pdata$partition)
  }

  if (!is.null(pdata$prob)) {
    miss = miss | row_any_na(pdata$prob)
  }

  pdata$row_ids[miss]
}

#' @export
c.PredictionDataClust = function(..., keep_duplicates = TRUE) {
  dots = list(...)
  assert_list(dots, "PredictionDataClust")
  assert_flag(keep_duplicates)
  if (length(dots) == 1L) {
    return(dots[[1L]])
  }

  predict_types = names(mlr_reflections$learner_predict_types$clust)
  predict_types = map(dots, function(x) intersect(names(x), predict_types))
  if (!every(predict_types[-1L], setequal, y = predict_types[[1L]])) {
    error_input("Cannot combine predictions: Different predict types.")
  }

  if (length(unique(map_lgl(dots, function(x) is.null(x$weights)))) > 1L) {
    error_input("Cannot combine predictions: Some predictions have weights, others do not.")
  }

  nn = names(dots[[1L]])
  elems = c("row_ids", "partition", if ("weights" %chin% nn) "weights")
  tab = map_dtr(dots, function(x) x[elems], .fill = FALSE)
  probs = map(dots, "prob")
  # empty predictions carry a 0-column prob placeholder (k is unknown), so drop 0-row matrices before rbind
  non_empty = compact(probs)
  prob = if (length(non_empty)) {
    do.call(rbind, non_empty)
  } else {
    # only the 0-column placeholder means unknown k, real 0-row matrices must still agree on their columns
    known = discard(probs, function(p) is.null(p) || ncol(p) == 0L)
    if (length(known)) do.call(rbind, known) else probs[[1L]]
  }

  if (!keep_duplicates) {
    keep = !duplicated(tab, by = "row_ids", fromLast = TRUE)
    tab = tab[keep]
    prob = prob[keep, , drop = FALSE]
  }

  result = as.list(tab)
  result$prob = prob

  set_class(result, c("PredictionDataClust", "PredictionData"))
}

#' @export
filter_prediction_data.PredictionDataClust = function(pdata, row_ids, ...) {
  keep = pdata$row_ids %in% row_ids
  pdata$row_ids = pdata$row_ids[keep]

  if (!is.null(pdata$partition)) {
    pdata$partition = pdata$partition[keep]
  }

  if (!is.null(pdata$prob)) {
    pdata$prob = pdata$prob[keep, , drop = FALSE]
  }

  if (!is.null(pdata$weights)) {
    pdata$weights = pdata$weights[keep]
  }

  pdata
}

#' @export
create_empty_prediction_data.TaskClust = function(task, learner) {
  predict_types = mlr_reflections$learner_predict_types[["clust"]][[learner$predict_type]]

  pdata = list(
    row_ids = integer(),
    partition = integer()
  )

  if ("prob" %chin% predict_types) {
    # the number of clusters is unknown here, so use a prob matrix without columns
    pdata$prob = matrix(numeric(), nrow = 0L, ncol = 0L)
  }

  if ("weights_measure" %chin% task$properties) {
    pdata$weights = numeric()
  }

  set_class(pdata, c("PredictionDataClust", "PredictionData"))
}
