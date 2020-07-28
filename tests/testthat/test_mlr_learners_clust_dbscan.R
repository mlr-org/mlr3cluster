context("clust.dbscan")

skip_if_not_installed("dbscan")

test_that("autotest", {
  learner = mlr3::lrn("clust.dbscan")
  learner$param_set$values = list(eps = 25)
  expect_learner(learner)

  result = run_autotest(learner)
  expect_true(result, info = result$error)
})


test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = mlr_learners$get("clust.dbscan")
  learner$param_set$values = list(eps = 25)
  expect_learner(learner, task)

  p = learner$train(task)$predict(task)
  expect_prediction_clust(p)

  if ("complete" %in% learner$properties) {
    expect_prediction_complete(p, learner$predict_type)
  }
  if ("exclusive" %in% learner$properties) {
    expect_prediction_exclusive(p, learner$predict_type)
  }
})
