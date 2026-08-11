skip_if_not_installed("gmeans")

test_that("autotest", {
  learner = lrn("clust.gmeans")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.gmeans")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(),
    list(k_init = 3L, k_max = 8L),
    list(k_max = 4L, level = 0.01, iter.max = 20L, algorithm = "Lloyd")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})
