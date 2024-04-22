skip_if_not_installed("stream")

test_that("autotest", {
  learner = mlr3::lrn("clust.bico")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})
