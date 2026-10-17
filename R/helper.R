allow_partial_matching = list(
  warnPartialMatchArgs = FALSE,
  warnPartialMatchAttr = FALSE,
  warnPartialMatchDollar = FALSE
)

check_centers = function(x) {
  if (test_data_frame(x) || test_matrix(x) || test_int(x, lower = 1L)) {
    TRUE
  } else {
    "`centers` must be integer, matrix, or data.frame with initial cluster centers"
  }
}

assert_centers_param = function(centers, task, name) {
  if (!test_data_frame(centers) && !test_matrix(centers)) {
    return(centers)
  }
  if (ncol(centers) != task$n_features) {
    error_input("`%s` must have one column per task feature.", name)
  }
  if (is.null(colnames(centers))) {
    return(centers)
  }
  features = task$feature_names
  if (!test_names(colnames(centers), permutation.of = features)) {
    error_input("`%s` column names must match the task features.", name)
  }
  if (test_matrix(centers)) {
    return(centers[, features, drop = FALSE])
  }
  as.data.frame(centers)[features]
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

logical_to_factor = function(data) {
  map_if(data, is.logical, function(x) factor(x, levels = c(FALSE, TRUE)))
}

warn_prediction_useless = function(id) {
  warning_input("Learner '%s' doesn't predict on new data and predictions may not make sense on new data.", id)
}

assert_prediction_count = function(actual, expected, type) {
  if (actual != expected) {
    if (actual < expected) {
      error_learner_predict(
        "Predicted %s not complete, %s for %i observations is missing",
        type,
        type,
        expected - actual
      )
    } else {
      error_learner_predict(
        "Predicted %s contains %i additional predictions without matching rows",
        type,
        actual - expected
      )
    }
  }
}

row_any_na = function(x) {
  if (!anyNA(x)) {
    logical(nrow(x))
  } else {
    rowSums(is.na(x)) > 0L
  }
}

task_dist = function(task, rows) {
  data = task$data(rows = rows)
  if (any(task$feature_types$type %chin% c("character", "factor", "ordered"))) {
    # daisy() rejects bare character columns
    cluster::daisy(map_if(data, is.character, factor), metric = "gower")
  } else {
    stats::dist(data)
  }
}
