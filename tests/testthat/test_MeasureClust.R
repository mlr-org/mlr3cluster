test_that("Cluster measures", {
  keys = mlr_measures$keys("clust")
  task = tsk("usarrests")
  learner = lrn("clust.kmeans", centers = 2)
  p = learner$train(task)$predict(task)

  for (key in keys) {
    m = mlr_measures$get(key)
    if (m$task_type == "clust") {
      perf = m$score(prediction = p, task = task, learner = learner)
      expect_number(perf, na.ok = FALSE, lower = m$range[1], upper = m$range[2])
    }
  }
})
