test_that("default_fallback() returns a featureless learner with matching predict type", {
  fallback = default_fallback(lrn("clust.kmeans"))
  expect_class(fallback, "LearnerClustFeatureless")
  expect_identical(fallback$predict_type, "partition")

  fallback = default_fallback(lrn("clust.featureless", predict_type = "prob"))
  expect_class(fallback, "LearnerClustFeatureless")
  expect_identical(fallback$predict_type, "prob")
})

test_that("resample() with encapsulation uses the default fallback", {
  task = tsk("usarrests")
  # a training error is caught and the fallback prediction is used
  learner = lrn("clust.featureless", num_clusters = 1000L)
  rr = resample(task, learner, rsmp("holdout"), encapsulate = "evaluate")
  expect_class(rr$learners[[1L]]$fallback, "LearnerClustFeatureless")
  expect_data_table(rr$errors, nrows = 1L)
  expect_prediction_clust(rr$prediction())
})

test_that("default fallback works on tasks with factor features", {
  skip_if_not_installed("klaR")
  data = data.table::data.table(x = rnorm(30), f = factor(sample(letters[1:3], 30, replace = TRUE)))
  task = as_task_clust(data)
  rr = resample(task, lrn("clust.kmodes", modes = 2L), rsmp("holdout"), encapsulate = "evaluate")
  expect_prediction_clust(rr$prediction())
})
