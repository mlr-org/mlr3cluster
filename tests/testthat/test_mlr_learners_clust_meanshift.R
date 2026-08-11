skip_if_not_installed("LPCM")

test_that("autotest", {
  learner = lrn("clust.meanshift")
  expect_learner(learner)
  result = run_autotest(learner, exclude = "sanity")
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.meanshift")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(h = 2L),
    list(subset = 1:3, scaled = 2L),
    list(thr = 0.1, iter = 100L)
  )

  for (parset in parset_list) {
    # keep the adjusted default, otherwise LPCM::ms plots during training
    learner$param_set$values = insert_named(list(plot = FALSE), parset)

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})

test_that("predict on training data matches assignments", {
  task = tsk("usarrests")
  learner = lrn("clust.meanshift", h = 0.2)
  learner$train(task)
  expect_class(learner$model, "ms")
  p = learner$predict(task)
  expect_identical(p$partition, learner$assignments)
})

test_that("predict uses the trained convergence threshold", {
  task = tsk("usarrests")
  learner = lrn("clust.meanshift", h = 0.2, thr = 0.2)
  learner$train(task)
  expect_identical(learner$predict(task)$partition, learner$assignments)
})

test_that("predict assigns new data to fitted modes", {
  task = tsk("usarrests")
  learner = lrn("clust.meanshift", h = 0.2)
  learner$train(task, row_ids = 1:40)
  p = learner$predict(task, row_ids = 41:50)
  expect_integer(p$partition, len = 10L, lower = 1L, upper = nrow(learner$model$cluster.center))
})

test_that("predict aligns features by name", {
  task = tsk("usarrests")
  learner = lrn("clust.meanshift", h = 0.2)
  learner$train(task)
  p = learner$predict(task)

  data = task$data()
  setcolorder(data, rev(names(data)))
  p_reordered = learner$predict(as_task_clust(data))
  expect_identical(p_reordered$partition, p$partition)
})
