skip_if_not_installed("apcluster")

test_that("autotest", {
  learner = lrn("clust.ap", s = apcluster::negDistMat(r = 2L))
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.ap")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(s = apcluster::negDistMat(r = 2L)),
    list(s = apcluster::linSimMat, details = TRUE, q = 0.5),
    list(s = apcluster::expSimMat, lam = 0.5, nonoise = TRUE, includeSim = TRUE),
    list(s = apcluster::corSimMat, convits = 50L, maxits = 500L)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = suppressWarnings(learner$train(task)$predict(task))
    expect_prediction_clust(p)

    if ("complete" %chin% learner$properties) {
      expect_prediction_complete(p, learner$predict_type)
    }
    if ("exclusive" %chin% learner$properties) {
      expect_prediction_exclusive(p, learner$predict_type)
    }
  }
})
