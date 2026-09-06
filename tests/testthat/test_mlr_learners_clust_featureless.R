test_that("autotest", {
  learner = lrn("clust.featureless", num_clusters = 2L)
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(num_clusters = 1L),
    list(num_clusters = 2L),
    list(num_clusters = 3L)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})

test_that("prob predictions are consistent with the partition", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless", predict_type = "prob", num_clusters = 3L)
  p = learner$train(task)$predict(task)
  expect_equal(max.col(p$prob, ties.method = "first"), p$partition)
})

test_that("all feature types are supported", {
  data = data.table::data.table(
    lgl = c(TRUE, FALSE, NA),
    int = c(1L, NA, 3L),
    dbl = c(1.5, 2.5, NA),
    chr = c("a", NA, "c"),
    fct = factor(c("x", "y", NA)),
    ord = factor(c("l", "m", "h"), levels = c("l", "m", "h"), ordered = TRUE),
    pxc = as.POSIXct(c("2020-01-01", "2020-01-02", "2020-01-03"), tz = "UTC"),
    dte = as.Date(c("2020-01-01", "2020-01-02", "2020-01-03"))
  )
  task = as_task_clust(data)
  learner = lrn("clust.featureless", num_clusters = 2L)
  expect_set_equal(learner$feature_types, mlr_reflections$task_feature_types)
  expect_subset("featureless", learner$properties)
  p = learner$train(task)$predict(task)
  expect_prediction_clust(p, learner)
  expect_integer(p$partition, len = 3L, any.missing = FALSE)
})
