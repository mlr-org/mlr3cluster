skip_if_not_installed("RWeka")
skip_on_cran()

test_that("autotest", {
  learner = lrn("clust.em")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.em")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(I = 200L, num_slots = 5L),
    list(output_debug_info = TRUE, K = 5L),
    list(M = 1e-3, ll_iter = 1L, ll_cv = 1L)
  )

  for (type in c("partition", "prob")) {
    learner$predict_type = type
    for (parset in parset_list) {
      learner$param_set$values = parset

      p = learner$train(task)$predict(task)
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
    }
  }
})
