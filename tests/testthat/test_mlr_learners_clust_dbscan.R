skip_if_not_installed("dbscan")

test_that("autotest", {
  learner = lrn("clust.dbscan", eps = 25)
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.dbscan", eps = 25)
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(eps = 25),
    list(eps = 25, minPts = 10L),
    list(eps = 25, search = "linear")
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
