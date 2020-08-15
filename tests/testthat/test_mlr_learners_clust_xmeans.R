context("clust.xmeans")

skip_if_not_installed("RWeka")

test_that("autotest", {
  learner = mlr3::lrn("clust.xmeans")
  expect_learner(learner)

  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = mlr_learners$get("clust.xmeans")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(use_kdtree = TRUE),
    list(L = 2L),
    list(I = 5L)
  )

  for (i in seq_along(parset_list)) {
    parset = parset_list[[i]]
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p)

    if ("complete" %in% learner$properties) {
      expect_prediction_complete(p, learner$predict_type)
    }
    if ("exclusive" %in% learner$properties) {
      expect_prediction_exclusive(p, learner$predict_type)
    }
  }
})
