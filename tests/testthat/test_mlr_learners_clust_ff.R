skip_if_not_installed("RWeka")
skip_on_cran()

test_that("autotest", {
  learner = lrn("clust.ff")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.ff")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(N = 1L),
    list(N = 3L, S = 3L),
    list(S = 100L)
  )

  for (i in seq_along(parset_list)) {
    parset = parset_list[[i]]
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
