test_that("as_task_clust.TaskClust clones on request", {
  task = tsk("usarrests")
  expect_identical(as_task_clust(task), task)
  expect_false(identical(as_task_clust(task, clone = TRUE), task))
})

test_that("as_task_clust.data.frame works and warns on Inf", {
  task = as_task_clust(data.frame(x = c(1, 2), y = c(3, 4)))
  expect_task_clust(task)
  expect_set_equal(task$feature_names, c("x", "y"))
  expect_warning(as_task_clust(data.frame(x = c(1, Inf))), "Inf")
})

test_that("as_task_clust.DataBackend works", {
  task = as_task_clust(as_data_backend(data.frame(x = c(1, 2))))
  expect_task_clust(task)
})

test_that("as_task_clust.formula selects features and rejects a response", {
  data = data.frame(x = c(1, 2), y = c(3, 4), z = c(5, 6))
  task = as_task_clust(~ x + y, data = data)
  expect_task_clust(task)
  expect_set_equal(task$feature_names, c("x", "y"))
  expect_error(as_task_clust(z ~ x, data = data), "has a response")
})

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
