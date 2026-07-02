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

test_that("k determines the number of clusters", {
  task = tsk("usarrests")
  for (k in c(2L, 3L)) {
    learner = lrn("clust.bico", k = k)
    p = learner$train(task)$predict(task)
    expect_set_equal(unique(p$partition), seq_len(k))
  }
})
