skip_if_not_installed("stream")

test_that("autotest", {
  learner = lrn("clust.bico")
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

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})

test_that("small coreset warns when k clusters cannot be found", {
  withr::local_seed(42L)
  task = tsk("usarrests")
  # space = 1L triggers an infinite loop in stream::DSC_BICO() on some platforms, space = 2L still underfills k
  learner = lrn("clust.bico", k = 5L, space = 2L)
  expect_snapshot(learner$train(task))
})

test_that("k determines the number of clusters", {
  withr::local_seed(42L)
  task = tsk("usarrests")
  for (k in c(2L, 3L)) {
    learner = lrn("clust.bico", k = k)
    p = learner$train(task)$predict(task)
    expect_set_equal(unique(p$partition), seq_len(k))
  }
})
