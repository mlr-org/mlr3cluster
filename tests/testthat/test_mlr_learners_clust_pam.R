context("clust.pam")

skip_if_not_installed("clue")

test_that("autotest", {
  learner = mlr3::lrn("clust.pam")
  expect_learner(learner)

  result = run_autotest(learner)
  expect_true(result, info = result$error)
})
