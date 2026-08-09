skip_if_not_installed("ClusterR")

test_that("autotest", {
  learner = lrn("clust.kmeans_rcpp")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.kmeans_rcpp")
  expect_learner(learner, task)

  # test on multiple paramsets
  centers = as.matrix(data.table(
    Assault = c(100L, 200L, 150L, 300L),
    Murder = c(11, 3, 10, 5),
    Rape = c(20, 18, 10, 26),
    UrbanPop = c(60L, 54L, 53L, 69L)
  ))

  parset_list = list(
    list(clusters = 2L),
    list(clusters = 4L, CENTROIDS = centers, initializer = "random"),
    list(clusters = 2L, num_init = 3L, max_iters = 50L, tol = 1e-03)
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
