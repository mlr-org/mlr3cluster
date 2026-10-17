skip_if_not_installed("e1071")

test_that("autotest", {
  learner = lrn("clust.cmeans")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.cmeans")
  expect_learner(learner, task)

  # test on multiple paramsets
  centers = data.table(
    Assault = c(100L, 200L, 150L, 300L),
    Murder = c(11, 3, 10, 5),
    Rape = c(20, 18, 10, 26),
    UrbanPop = c(60L, 54L, 53L, 69L)
  )

  parset_list = list(
    list(centers = 2L),
    list(centers = centers),
    list(centers = as.matrix(centers)),
    list(centers = 2L, dist = "manhattan", m = 3)
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

test_that("weights accept zeros but need a positive element", {
  task = tsk("usarrests")
  learner = lrn("clust.cmeans", weights = c(0, 0, rep(1, 48)))
  expect_prediction_clust(learner$train(task)$predict(task), learner)

  expect_error(lrn("clust.cmeans", weights = c(-1, 1)), "non-negative")
  expect_error(lrn("clust.cmeans", weights = 0), "positive element")
})
