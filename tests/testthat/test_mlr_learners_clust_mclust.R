skip_if_not_installed("mclust")

test_that("autotest", {
  learner = lrn("clust.mclust")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.mclust")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(G = 1:4, modelNames = "EII"),
    list(initialization = list(noise = 1)),
    list(G = 3)
  )

  for (type in c("partition", "prob")) {
    learner$predict_type = type
    for (parset in parset_list) {
      learner$param_set$values = parset

      p = suppressWarnings(learner$train(task)$predict(task))
      expect_prediction_clust(p)

      if ("complete" %chin% learner$properties) {
        expect_prediction_complete(p, learner$predict_type)
      }
      if ("exclusive" %chin% learner$properties) {
        expect_prediction_exclusive(p, "partition")
      }
      if (learner$predict_type == "prob") {
        expect_prediction_fuzzy(p)
      }

      learner$reset()
    }
  }
})
