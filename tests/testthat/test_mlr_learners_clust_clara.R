skip_if_not_installed("clue")

test_that("autotest", {
  learner = lrn("clust.clara")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("predicting errors informatively for unsupported training options", {
  task = tsk("usarrests")
  learner = lrn("clust.clara", metric = "jaccard")
  learner$train(task)
  expect_snapshot(error = TRUE, learner$predict(task))

  learner = lrn("clust.clara", medoids.x = FALSE)
  learner$train(task)
  expect_snapshot(error = TRUE, learner$predict(task))

  learner = lrn("clust.clara", stand = TRUE)
  learner$train(task)
  expect_snapshot(error = TRUE, learner$predict(task))
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.clara")
  expect_learner(learner, task)

  parset_list = list(
    list(k = 2L),
    list(k = 5L),
    list(k = 2L, metric = "manhattan"),
    list(k = 3L, pamLike = TRUE)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})
