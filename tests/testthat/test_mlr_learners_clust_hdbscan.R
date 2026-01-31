skip_if_not_installed("dbscan")

test_that("autotest", {
  learner = lrn("clust.hdbscan", minPts = 5L)
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.hdbscan", minPts = 5L)
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(minPts = 5L),
    list(minPts = 5L, gen_hdbscan_tree = TRUE),
    list(minPts = 5L, gen_simplified_tree = TRUE),
    list(minPts = 5L, gen_hdbscan_tree = TRUE, gen_simplified_tree = TRUE)
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
