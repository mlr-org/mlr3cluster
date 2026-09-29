skip_if_not_installed("fpc")

test_that("autotest", {
  learner = lrn("clust.dbscan_fpc", eps = 1)
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("predicting errors informatively when trained with seeds = FALSE", {
  task = tsk("usarrests")
  learner = lrn("clust.dbscan_fpc", eps = 25, seeds = FALSE)
  learner$train(task)
  expect_snapshot(error = TRUE, learner$predict(task))

  learner = lrn("clust.dbscan_fpc", eps = 25, scale = TRUE)
  learner$train(task)
  expect_snapshot(error = TRUE, learner$predict(task))
})

test_that("predict checks the training values, not the current ones", {
  task = tsk("usarrests")
  learner = lrn("clust.dbscan_fpc", eps = 25, seeds = FALSE)
  learner$train(task)
  learner$param_set$values$seeds = NULL
  expect_error(learner$predict(task), "seeds = TRUE")

  learner = lrn("clust.dbscan_fpc", eps = 0.8, scale = TRUE)
  learner$train(task)
  learner$param_set$values$scale = NULL
  expect_error(learner$predict(task), "scale = TRUE")

  learner = lrn("clust.dbscan_fpc", eps = 25)
  learner$train(task)
  learner$param_set$values = list(eps = 25, seeds = FALSE, scale = TRUE)
  expect_prediction_clust(learner$predict(task), learner)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.dbscan_fpc", eps = 25)
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(eps = 25),
    list(eps = 25, MinPts = 10),
    list(eps = 25, method = "hybrid")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_class(learner$native_model, "dbscan")
    expect_prediction_clust(p, learner)
  }
})
