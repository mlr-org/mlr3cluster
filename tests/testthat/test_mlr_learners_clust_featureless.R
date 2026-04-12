test_that("autotest", {
  learner = lrn("clust.featureless", num_clusters = 2L)
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(num_clusters = 1L),
    list(num_clusters = 2L),
    list(num_clusters = 3L)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})
