skip_if_not_installed("protoclust")

test_that("autotest", {
  learner = lrn("clust.protoclust")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.protoclust")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(k = 3L),
    list(k = 5L),
    list(k = 3L, method = "manhattan")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})

test_that("predict on training data matches assignments", {
  task = tsk("usarrests")
  learner = lrn("clust.protoclust", k = 3L)
  learner$train(task)
  expect_class(learner$native_model, "protoclust")
  p = learner$predict(task)
  expect_identical(p$partition, learner$assignments)
})

test_that("predict assigns new data to nearest prototype", {
  task = tsk("usarrests")
  learner = lrn("clust.protoclust", k = 3L)
  learner$train(task, row_ids = 1:40)
  p = learner$predict(task, row_ids = 41:50)
  expect_integer(p$partition, len = 10L, lower = 1L, upper = 3L)
})

test_that("changing k between training and predict takes effect", {
  task = tsk("usarrests")
  learner = lrn("clust.protoclust", k = 3L)
  learner$train(task, row_ids = 1:40)
  learner$param_set$set_values(k = 5L)
  p = learner$predict(task, row_ids = 41:50)
  expect_integer(p$partition, len = 10L, lower = 1L, upper = 5L)
})

test_that("predict aligns features by name", {
  task = tsk("usarrests")
  learner = lrn("clust.protoclust", k = 3L)
  learner$train(task)
  p = learner$predict(task)

  data = task$data()
  setcolorder(data, rev(names(data)))
  p_reordered = learner$predict(as_task_clust(data))
  expect_identical(p_reordered$partition, p$partition)
})
