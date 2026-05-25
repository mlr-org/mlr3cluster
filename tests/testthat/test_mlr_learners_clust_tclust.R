skip_if_not_installed("tclust")

test_that("autotest", {
  learner = lrn("clust.tclust")
  expect_learner(learner)
  task = generate_tasks(learner)
  learner$train(task[[1L]])
  expect_class(learner$model, "tclust")
  expect_warning(learner$predict(task[[1L]]), "doesn't predict on new data")
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.tclust")
  expect_learner(learner, task)

  parset_list = list(
    list(k = 2L),
    list(k = 3L, alpha = 0.1),
    list(k = 3L, restr = "deter", opt = "MIXT")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = suppressWarnings(learner$train(task)$predict(task))
    expect_prediction_clust(p, learner)
  }
})
