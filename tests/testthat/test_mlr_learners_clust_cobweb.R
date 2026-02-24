skip_if_not_installed("RWeka")
skip_on_cran()

test_that("autotest", {
  learner = lrn("clust.cobweb")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.cobweb")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(A = 0.5),
    list(C = 1L),
    list(S = 100L)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})
