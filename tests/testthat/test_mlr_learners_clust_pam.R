skip_if_not_installed("clue")

test_that("autotest", {
  learner = lrn("clust.pam")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
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

test_that("stand is applied at predict time", {
  task = tsk("usarrests")
  learner = lrn("clust.pam", k = 3L, stand = TRUE)
  learner$train(task)
  p = learner$predict(task)
  expect_identical(p$partition, unname(learner$assignments))
})

test_that("stand handles constant features", {
  data = data.frame(a = rep(c(0, 10), each = 10L), b = rep(c(5, -5), each = 10L), const = 1)
  task = as_task_clust(data)
  learner = lrn("clust.pam", k = 2L, stand = TRUE)
  p = learner$train(task)$predict(task)
  expect_integer(p$partition, len = 20L, any.missing = FALSE)
  expect_identical(p$partition, unname(learner$assignments))
})

test_that("stand reports medoids in the original data units", {
  task = tsk("usarrests")
  learner = lrn("clust.pam", k = 3L, stand = TRUE)
  learner$train(task)
  m = learner$model
  expect_equal(m$medoids, data.matrix(task$data())[m$id.med, , drop = FALSE])
})
