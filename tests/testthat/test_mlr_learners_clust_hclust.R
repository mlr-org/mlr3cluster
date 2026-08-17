test_that("autotest", {
  learner = lrn("clust.hclust")
  expect_learner(learner)
  task = generate_tasks(learner)
  learner$train(task[[1L]])
  expect_class(learner$model, "hclust")
  expect_warning(learner$predict(task[[1L]]), "doesn't predict on new data")
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.hclust")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(k = 3L),
    list(k = 5L),
    list(k = 3L, method = "centroid")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = suppressWarnings(learner$train(task)$predict(task))
    expect_prediction_clust(p, learner)
  }
})

test_that("predict validates k against the training size", {
  task = tsk("usarrests")
  learner = lrn("clust.hclust", k = 3L)
  suppressWarnings(learner$train(task))

  # k is bounded by the number of training observations, not the predict task's rows
  learner$param_set$values$k = task$nrow + 1L
  expect_error(learner$predict(task), sprintf("between 1 and %i", task$nrow))
})
