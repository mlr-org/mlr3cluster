#' @export
as_prediction.PredictionDataClust = function(x, check = TRUE, ...) { # nolint
  invoke(PredictionClust$new, check = check, .args = x)
}

#' @export
check_prediction_data.PredictionDataClust = function(pdata, ...) { # nolint
  pdata$row_ids = assert_row_ids(pdata$row_ids)
  n = length(pdata$row_ids)
  assert_integer(pdata$partition, len = n, any.missing = FALSE, null.ok = TRUE)

  prob = pdata$prob
  if (!is.null(prob)) {
    # need to check number of columns for matrix
    assert_matrix(prob, nrows = n)
    assert_numeric(prob, lower = 0, upper = 1)
    if (!is.null(rownames(prob))) {
      rownames(prob) = NULL
      pdata$prob = prob
    }

    if (is.null(pdata$partition)) {
      # calculate partition from prob
      pdata$partition = max.col(prob, ties.method = "first")
    }
  }

  pdata
}

#' @export
is_missing_prediction_data.PredictionDataClust = function(pdata, ...) { # nolint
  miss = logical(length(pdata$row_ids))

  if (!is.null(pdata$partition)) {
    miss = is.na(pdata$partition)
  }

  if (!is.null(pdata$prob)) {
    miss = miss | apply(pdata$prob, 1L, anyMissing)
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
    stopf("Cannot combine predictions: Different predict types")
  }

  elems = c("row_ids", "partition")
  tab = map_dtr(dots, function(x) x[elems], .fill = FALSE)
  prob = do.call(rbind, map(dots, "prob"))

  if (!keep_duplicates) {
    keep = !duplicated(tab, by = "row_ids", fromLast = TRUE)
    tab = tab[keep]
    prob = prob[keep, , drop = FALSE]
  }

  result = as.list(tab)
  result$prob = prob

  set_class(result, "PredictionDataClust")
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

  pdata
}

#' @export
create_empty_prediction_data.TaskClust = function(task, learner) {
  predict_types = mlr_reflections$learner_predict_types[["clust"]][[learner$predict_type]]

  pdata = list(
    row_ids = integer(),
    partition = integer()
  )

  if ("prob" %in% predict_types) {
    pdata$prob = matrix(integer())
  }

  set_class(pdata, "PredictionDataClust")
}
