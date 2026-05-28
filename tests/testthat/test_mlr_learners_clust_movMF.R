skip_if_not_installed("movMF")

test_that("autotest", {
  learner = lrn("clust.movMF")
  expect_learner(learner)
  task = generate_tasks(learner)
  learner$train(task[[1L]])
  expect_class(learner$model, "movMF")
  p = learner$predict(task[[1L]])
  expect_prediction_clust(p, learner)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.movMF")
  expect_learner(learner, task)

  parset_list = list(
    list(k = 2L),
    list(k = 3L, E = "hardmax", nruns = 5L),
    list(k = 3L, nruns = 2L, maxiter = 50L)
  )

  for (type in c("partition", "prob")) {
    learner$predict_type = type
    for (parset in parset_list) {
      learner$param_set$values = parset
      p = learner$train(task)$predict(task)
      expect_prediction_clust(p, learner)
    }
  }
})
