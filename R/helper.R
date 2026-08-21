warn_prediction_useless = function(id) {
  warning_input("Learner '%s' doesn't predict on new data and predictions may not make sense on new data.", id)
}

ordered_features = function(task, learner) {
  cols = names(learner$state$data_prototype) %??% learner$state$feature_names
  task$data(cols = intersect(cols, task$feature_names))
}

as_numeric_matrix = function(x) {
  x = as.matrix(x)
  if (is.logical(x)) {
    storage.mode(x) = "double"
  }
  x
}

allow_partial_matching = list(
  warnPartialMatchArgs = FALSE,
  warnPartialMatchAttr = FALSE,
  warnPartialMatchDollar = FALSE
)

assert_centers_param = function(centers, task, name) {
  if ((test_data_frame(centers) || test_matrix(centers)) && ncol(centers) != task$ncol) {
    error_input("`%s` must have same number of columns as data.", name)
  }
}

check_centers = function(x) {
  if (test_data_frame(x) || test_matrix(x) || test_int(x, lower = 1L)) {
    TRUE
  } else {
    "`centers` must be integer, matrix, or data.frame with initial cluster centers"
  }
}

row_any_na = function(x) {
  if (!anyNA(x)) {
    return(logical(nrow(x)))
  }
  rowSums(is.na(x)) > 0L
}

task_dist = function(task, rows) {
  data = task$data(rows = rows)
  if (any(task$feature_types$type %in% c("character", "factor", "ordered"))) {
    chr_cols = task$feature_types[get("type") == "character", "id", with = FALSE][[1L]]
    if (length(chr_cols) > 0L) {
      # daisy() rejects bare character columns
      data[, (chr_cols) := map(.SD, factor), .SDcols = chr_cols]
    }
    cluster::daisy(data, metric = "gower")
  } else {
    stats::dist(data)
  }
}
