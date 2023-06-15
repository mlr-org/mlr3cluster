context("clust.dbscan_fpc")

skip_if_not_installed("fpc")

test_that("autotest", {
  learner = mlr3::lrn("clust.dbscan_fpc")
  learner$param_set$values = list(eps = 25)
  expect_learner(learner)

  result = run_autotest(learner)
  expect_true(result, info = result$error)
})


test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = mlr_learners$get("clust.dbscan_fpc")
  learner$param_set$values = list(eps = 25)
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(eps = 25),
    list(eps = 25, MinPts = 10),
    list(eps = 25, method = "hybrid")
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
