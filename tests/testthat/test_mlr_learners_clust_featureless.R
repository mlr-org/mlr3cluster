context("mlr_learners_clust_featureless")

test_that("autotest", {
  learner = lrn("clust.featureless")
  expect_learner(learner)

  # skip everything for now
  exclude = "(sanity|feat_single_logical|feat_single_integer|feat_single_numeric|"
  exclude = paste(exclude, "feat_all|missings)", sep = "")
  result = run_autotest(learner, exclude = exclude)
  expect_true(result, info = result$error)
})

test_that("Simple training/predict", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless")
  expect_learner(learner, task)

  learner$train(task)
  learner$predict(task)
  expect_class(learner$model, "clust.featureless_model")
  prediction = learner$predict(task)
  perf = prediction$score(msr("clust.silhouette"), task)
  expect_number(perf, lower = 1, upper = 1)
})
