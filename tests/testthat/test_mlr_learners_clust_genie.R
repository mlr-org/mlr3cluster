skip_if_not_installed("genieclust")

test_that("autotest", {
  learner = lrn("clust.genie")
  expect_learner(learner)
  task = generate_tasks(learner)
  learner$train(task[[1L]])
  expect_class(learner$model, "hclust")
  expect_warning(learner$predict(task[[1L]]), "doesn't predict on new data")
})

test_that("single-feature task errors", {
  task = as_task_clust(data.frame(x = rnorm(20L)))
  learner = lrn("clust.genie")
  expect_snapshot(learner$train(task), error = TRUE)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.genie")
  expect_learner(learner, task)

  parset_list = list(
    list(k = 3L),
    list(k = 5L, gini_threshold = 0.5),
    list(k = 3L, distance = "manhattan")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = suppressWarnings(learner$train(task)$predict(task))
    expect_prediction_clust(p, learner)
  }
})

test_that("predict validates k against the training size", {
  task = tsk("usarrests")
  learner = lrn("clust.genie", k = 3L)
  suppressWarnings(learner$train(task))

  # k is bounded by the number of training observations, not the predict task's rows
  learner$param_set$values$k = task$nrow + 1L
  expect_error(learner$predict(task), sprintf("between 1 and %i", task$nrow))
})
