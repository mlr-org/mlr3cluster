skip_if_not_installed("kernlab")

test_that("autotest", {
  learner = lrn("clust.specc")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.specc")
  expect_learner(learner, task)

  parset_list = list(
    list(centers = 2L, kernel = "polydot", degree = 2L),
    list(centers = 3L, kernel = "rbfdot"),
    list(centers = 3L, kernel = "vanilladot")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p)

    if ("complete" %chin% learner$properties) {
      expect_prediction_complete(p, learner$predict_type)
    }
    if ("exclusive" %chin% learner$properties) {
      expect_prediction_exclusive(p, learner$predict_type)
    }
  }
})
