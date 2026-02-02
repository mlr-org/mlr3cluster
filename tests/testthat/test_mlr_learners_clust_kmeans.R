skip_if_not_installed("clue")

test_that("autotest", {
  learner = lrn("clust.kmeans")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.kmeans")
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
    list(centers = 2L, algorithm = "MacQueen")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p)

    if ("complete" %chin% learner$properties) {
      expect_prediction_complete(p, learner$predict_type)
    }
    if ("exclusive" %chin% learner$properties) {
      expect_prediction_exclusive(p, learner$predict_type)
    }
  }
})
