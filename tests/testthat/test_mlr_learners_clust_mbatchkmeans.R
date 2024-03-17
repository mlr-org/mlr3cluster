skip_if_not_installed("ClusterR")

test_that("autotest", {
  learner = mlr3::lrn("clust.MBatchKMeans")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.MBatchKMeans")
  expect_learner(learner, task)

  # test on multiple paramsets
  centers = data.frame(matrix(ncol = length(colnames(task$data())), nrow = 4L))
  colnames(centers) = colnames(task$data())
  centers$Assault = c(100, 200, 150, 300)
  centers$Murder = c(11, 3, 10, 5)
  centers$Rape = c(20, 18, 10, 26)
  centers$UrbanPop = c(60, 54, 53, 69)
  colnames(centers) = NULL
  centers = as.matrix(centers)

  parset_list = list(
    list(clusters = 2L),
    list(clusters = 4L, CENTROIDS = centers, initializer = "random"),
    list(clusters = 2L, early_stop_iter = 20L, batch_size = 15L, tol = 1e-03)
  )

  for (type in c("partition", "prob")) {
    learner$predict_type = type
    for (i in seq_along(parset_list)) {
      parset = parset_list[[i]]
      learner$param_set$values = parset

      p = learner$train(task)$predict(task)
      expect_prediction_clust(p)

      if ("complete" %in% learner$properties) {
        expect_prediction_complete(p, learner$predict_type)
      }
      if ("exclusive" %in% learner$properties) {
        expect_prediction_exclusive(p, "partition")
      }
      if (learner$predict_type == "prob") {
        expect_prediction_fuzzy(p)
      }

      learner$reset()
    }
  }
})
