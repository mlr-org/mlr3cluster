skip_if_not_installed("dbscan")

test_that("autotest", {
  learner = mlr3::lrn("clust.optics", eps = 25, eps_cl = 20)
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.optics")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(eps_cl = 25),
    list(eps = 25, eps_cl = 20),
    list(eps_cl = 25, search = "linear")
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
