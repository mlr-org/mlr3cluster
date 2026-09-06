#' @export
as_prediction.PredictionDataClust = function(x, check = TRUE, ...) {
  invoke(PredictionClust$new, check = check, .args = x)
}

#' @export
check_prediction_data.PredictionDataClust = function(pdata, ...) {
  pdata$row_ids = assert_row_ids(pdata$row_ids)
  n = length(pdata$row_ids)
  if (!is.null(pdata$partition)) {
    pdata$partition = assert_integerish(pdata$partition, any.missing = FALSE, coerce = TRUE)
    assert_prediction_count(length(pdata$partition), n, "partition")
  }

  if (!is.null(pdata$weights)) {
    # weights may never be NA, even if no prediction was made
    pdata$weights = assert_numeric(unname(pdata$weights), any.missing = FALSE)
    assert_prediction_count(length(pdata$weights), n, "weights")
  }

  prob = pdata$prob
  if (!is.null(prob)) {
    assert_matrix(prob)
    assert_prediction_count(nrow(prob), n, "prob")
    assert_numeric(prob, lower = 0, upper = 1)
    if (!is.null(rownames(prob))) {
      rownames(prob) = NULL
      pdata$prob = prob
    }

    labels = suppressWarnings(as.integer(colnames(prob)))
    if (length(labels) == 0L || anyNA(labels)) {
      labels = seq_col(prob)
    }

    if (is.null(pdata$partition)) {
      pdata$partition = labels[max.col(prob, ties.method = "first")]
    } else if (ncol(prob) > 0L) {
      assert_subset(pdata$partition, labels, .var.name = "partition")
    }
  }

  if (!is.null(pdata$extra)) {
    assert_list(pdata$extra, names = "unique")
    if (any(lengths(pdata$extra) != n)) {
      error_learner_predict("Extra data must have the same length as the number of predictions")
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

  if (length(unique(map_lgl(dots, function(x) is.null(x$extra)))) > 1L) {
    error_input("Cannot combine predictions: Some predictions have extra data, others do not.")
  }

  nn = names(dots[[1L]])
  elems = c("row_ids", "partition", if ("weights" %chin% nn) "weights")
  tab = map_dtr(dots, function(x) x[elems], .fill = FALSE)
  probs = map(dots, "prob")
  # empty predictions carry a 0-column prob placeholder (k is unknown), so only matrices with columns constrain k
  known = discard(probs, function(p) is.null(p) || ncol(p) == 0L)
  if (length(unique(map_int(known, ncol))) > 1L) {
    error_input("Cannot combine predictions: Different number of clusters.")
  }
  prob = if (length(known) > 0L) do.call(rbind, known) else probs[[1L]]

  extra = NULL
  if ("extra" %chin% nn) {
    extra = rbindlist(map(dots, "extra"), fill = TRUE, use.names = TRUE)
  }

  if (!keep_duplicates) {
    keep = !duplicated(tab, by = "row_ids", fromLast = TRUE)
    tab = tab[keep]
    prob = prob[keep, , drop = FALSE]
    extra = extra[keep]
  }

  result = as.list(tab)
  result$prob = prob
  if (!is.null(extra)) {
    result$extra = as.list(extra)
  }

  raw = discard(map(dots, "raw"), is.null)
  if (length(raw) > 0L) {
    result$raw = raw
  }

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

  if (!is.null(pdata$extra)) {
    pdata$extra = map(pdata$extra, function(x) x[keep])
  }

  pdata
}

#' @export
create_empty_prediction_data.TaskClust = function(task, learner) {
  predict_types = mlr_reflections$learner_predict_types[["clust"]][[learner$predict_type]]

  pdata = list(row_ids = integer(), partition = integer())

  if ("prob" %chin% predict_types) {
    # the number of clusters is unknown here, so use a prob matrix without columns
    pdata$prob = matrix(numeric(), nrow = 0L, ncol = 0L)
  }

  if ("weights_measure" %chin% task$properties) {
    pdata$weights = numeric()
  }

  set_class(pdata, c("PredictionDataClust", "PredictionData"))
}
