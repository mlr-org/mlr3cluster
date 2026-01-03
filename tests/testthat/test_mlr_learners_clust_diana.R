skip_if_not_installed("clue")

test_that("autotest", {
  learner = lrn("clust.diana")
  expect_learner(learner)
  task = generate_tasks(learner)
  learner$train(task[[1L]])
  expect_class(learner$model, "diana")
  expect_warning(learner$predict(task[[1L]]), "doesn't predict on new data")
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.diana")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(k = 2L),
    list(k = 5L),
    list(k = 2L, metric = "manhattan"),
    list(k = 2L, stand = TRUE)
  )

  for (i in seq_along(parset_list)) {
    parset = parset_list[[i]]
    learner$param_set$values = parset

    p = suppressWarnings(learner$train(task)$predict(task))
    expect_prediction_clust(p)

    if ("complete" %chin% learner$properties) {
      expect_prediction_complete(p, learner$predict_type)
    }
    if ("exclusive" %chin% learner$properties) {
      expect_prediction_exclusive(p, learner$predict_type)
    }
  }
})
