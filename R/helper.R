warn_prediction_useless = function(id) {
  warning_input("Learner '%s' doesn't predict on new data and predictions may not make sense on new data.", id)
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

weka_control = function(pv) {
  names(pv) = chartr("_", "-", names(pv))
  invoke(RWeka::Weka_control, .args = pv)
}
