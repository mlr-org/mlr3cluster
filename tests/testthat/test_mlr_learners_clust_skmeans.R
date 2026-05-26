skip_if_not_installed("skmeans")

test_that("autotest", {
  learner = lrn("clust.skmeans")
  expect_learner(learner)
  task = generate_tasks(learner)
  learner$train(task[[1L]])
  expect_class(learner$model, "skmeans")
  p = learner$predict(task[[1L]])
  expect_prediction_clust(p, learner)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.skmeans")
  expect_learner(learner, task)

  parset_list = list(
    list(k = 2L),
    list(k = 3L, method = "pclust"),
    list(k = 3L, method = "genetic", maxiter = 5L, popsize = 4L)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset
    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})
