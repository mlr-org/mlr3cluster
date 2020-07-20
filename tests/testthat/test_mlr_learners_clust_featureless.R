context("mlr_learners_clust_featureless")

test_that("autotest", {
  learner = lrn("clust.featureless")
  expect_learner(learner)

  result = run_autotest(learner)
  expect_true(result, info = result$error)
})
