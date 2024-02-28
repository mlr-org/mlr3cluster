test_that("Basic ops on usarrests task", {
  task = tsk("usarrests")
  expect_task(task)
  expect_task_clust(task)
  expect_identical(task$target_names, character(0))
})

test_that("Basic ops on ruspini task", {
  task = tsk("ruspini")
  expect_task(task)
  expect_task_clust(task)
  expect_identical(task$target_names, character(0))
})

test_that("0 feature task", {
  b = as_data_backend(data.table(ids = 1:30))
  task = TaskClust$new(id = "zero_feat_task", b)
  expect_output(print(task))
  b = task$backend
  expect_backend(b)
  expect_task(task)
  expect_task_clust(task)
  expect_data_table(task$data(), ncols = 1L)

  lrn = lrn("clust.featureless")
  lrn$param_set$values = list(num_clusters = 3L)
  p = lrn$train(task)$predict(task)
  expect_prediction(p)
})
