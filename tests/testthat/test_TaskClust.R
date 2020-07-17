context("TaskClust")

test_that("Basic ops on usarrests task", {
  task = tsk("usarrests")
  expect_task(task)
  expect_task_clust(task)
  expect_identical(task$target_names, character(0))
})

test_that("0 feature task", {
  b = as_data_backend(iris[, 5L, drop = FALSE])
  task = TaskClassif$new(id = "zero_feat_task", b, target = "Species")
  expect_output(print(task))
  b = task$backend
  expect_backend(b)
  expect_task(task)
  expect_task_supervised(task)
  expect_task_classif(task)
  expect_data_table(task$data(), ncols = 1L)

  lrn = lrn("classif.featureless")
  p = lrn$train(task)$predict(task)
  expect_prediction(p)
})
