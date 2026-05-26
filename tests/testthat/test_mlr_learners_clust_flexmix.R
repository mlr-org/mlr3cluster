skip_if_not_installed("flexmix")

test_that("autotest", {
  learner = lrn("clust.flexmix")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.flexmix")
  expect_learner(learner, task)

  parset_list = list(
    list(k = 2L),
    list(k = 3L, model = "FLXMCmvnorm", diagonal = FALSE),
    list(k = 3L, iter.max = 50L, tolerance = 1e-4, nrep = 2L)
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
