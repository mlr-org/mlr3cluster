skip_if_not_installed("flexclust")

test_that("autotest", {
  learner = lrn("clust.kcca")
  expect_learner(learner)
  task = generate_tasks(learner)
  learner$train(task[[1L]])
  expect_class(learner$model, "kcca")
  p = learner$predict(task[[1L]])
  expect_prediction_clust(p, learner)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.kcca")
  expect_learner(learner, task)

  parset_list = list(
    list(k = 2L),
    list(k = 3L, family = "kmedians"),
    list(k = 3L, family = "angle"),
    list(k = 3L, iter.max = 50L, tolerance = 1e-4)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset
    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})
