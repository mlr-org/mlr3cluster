skip_if_not_installed("stream")

test_that("autotest", {
  learner = mlr3::lrn("clust.bico")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.bico")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(k = 5),
    list(k = 5, space = 5L),
    list(k = 5, space = 5L, p = 5L),
    list(k = 5, space = 5L, p = 5L, iterations = 5L)
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
