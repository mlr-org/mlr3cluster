context("MeasureClust")

test_that("Cluster measures", {
  keys = mlr_measures$keys("clust")
  task = tsk("usarrests")
  learner = mlr_learners$get("clust.kmeans")
  learner$param_set$values = list(centers = 2)
  learner$train(task)
  p = learner$predict(task)

  for (key in keys) {
    m = mlr_measures$get(key)
    if (m$task_type == "clust") {
      perf = m$score(prediction = p, task = task, learner = learner)
      expect_number(perf, na.ok = FALSE, lower = m$range[1], upper = m$range[2])
    }
  }
})
