warn_prediction_useless = function(id) {
  warning_input("Learner '%s' doesn't predict on new data and predictions may not make sense on new data.", id)
}

allow_partial_matching = list(
  warnPartialMatchArgs = FALSE,
  warnPartialMatchAttr = FALSE,
  warnPartialMatchDollar = FALSE
)

assert_centers_param = function(centers, task, test_class, name) {
  if (test_class(centers) && ncol(centers) != task$ncol) {
    error_input("`%s` must have same number of columns as data.", name)
  }
}

check_centers = function(x) {
  if (test_data_frame(x) || test_int(x, lower = 1L)) {
    TRUE
  } else {
    "`centers` must be integer or data.frame with initial cluster centers"
  }
}
