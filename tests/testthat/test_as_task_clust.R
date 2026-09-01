test_that("as_task_clust.matrix works", {
  x = matrix(c(1, 2, 10, 11, 1, 2, 10, 11), nrow = 4L, dimnames = list(NULL, c("a", "b")))
  task = as_task_clust(x)
  expect_task_clust(task)
  expect_identical(task$id, "x")
  expect_identical(task$nrow, 4L)
  expect_set_equal(task$feature_names, c("a", "b"))
})

test_that("as_task_clust.matrix requires column names", {
  expect_error(as_task_clust(matrix(1:4, ncol = 2L)), "colnames")
})
