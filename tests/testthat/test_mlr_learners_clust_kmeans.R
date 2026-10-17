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
    list(centers = as.matrix(centers)),
    list(centers = 2L, algorithm = "MacQueen")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})

test_that("centers are matched to features by name", {
  data = data.frame(z = c(10, 11, 100, 101), a = 1:4)
  learner = lrn("clust.kmeans", centers = data[c(1L, 4L), ])$train(as_task_clust(data))
  expect_identical(learner$assignments, c(1L, 1L, 2L, 2L))
})
