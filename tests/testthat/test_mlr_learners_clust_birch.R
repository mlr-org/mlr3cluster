skip_if_not_installed("stream")

test_that("autotest", {
  learner = mlr3::lrn("clust.birch", threshold = 0.1, branching = 8L, maxLeaf = 20L)
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.birch", threshold = 0.1, branching = 8L, maxLeaf = 20L)
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(threshold = 0.1, branching = 8L, maxLeaf = 20L),
    list(threshold = 0.2, branching = 4L, maxLeaf = 10, maxMem = 2L),
    list(threshold = 0.3, branching = 12L, maxLeaf = 5L, outlierThreshold = 0.3)
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
