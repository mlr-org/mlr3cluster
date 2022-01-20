if (requireNamespace("testthat", quietly = TRUE)) {
  library("checkmate")
  library("testthat")
  library("mlr3")
  library("mlr3cluster")
  test_check("mlr3cluster")
}
