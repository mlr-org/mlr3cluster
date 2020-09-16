context("mlr_learners_clust_featureless")

test_that("autotest", {
  learner = lrn("clust.featureless")
  expect_learner(learner)

  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = mlr_learners$get("clust.featureless")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(num_clusters = 1L),
    list(num_clusters = 2L),
    list(num_clusters = 3L)
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
