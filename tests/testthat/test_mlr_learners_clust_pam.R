skip_if_not_installed("clue")

test_that("autotest", {
  learner = lrn("clust.pam")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("predicting errors informatively for unsupported training options", {
  task = tsk("usarrests")
  learner = lrn("clust.pam", stand = TRUE)
  learner$train(task)
  expect_snapshot(error = TRUE, learner$predict(task))
})

test_that("predict checks the training values, not the current ones", {
  task = tsk("usarrests")
  learner = lrn("clust.pam", stand = TRUE)
  learner$train(task)
  learner$param_set$values$stand = NULL
  expect_error(learner$predict(task), "stand = TRUE")

  learner = lrn("clust.pam")
  learner$train(task)
  learner$param_set$values$stand = TRUE
  expect_prediction_clust(learner$predict(task), learner)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.pam")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(k = 2L),
    list(k = 5L),
    list(k = 2L, metric = "manhattan")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})
