context("clust.meanshift")

skip_if_not_installed("LPCM")

test_that("autotest", {
  learner = mlr3::lrn("clust.meanshift")
  expect_learner(learner)

  result = run_autotest(learner)
  expect_true(result, info = result$error)
})


test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = mlr_learners$get("clust.meanshift")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(h = 2L),
    list(subset = 1:3, scaled = 2L),
    list(thr = 0.1, iter = 100L)
  )

  for (i in seq_along(parset_list)) {
    parset = parset_list[[i]]
    learner$param_set$values = parset

    p = suppressWarnings(learner$train(task)$predict(task), classes = "predictionUselessWarning")
    expect_prediction_clust(p)

    if ("complete" %in% learner$properties) {
      expect_prediction_complete(p, learner$predict_type)
    }
    if ("exclusive" %in% learner$properties) {
      expect_prediction_exclusive(p, learner$predict_type)
    }
  }
})
