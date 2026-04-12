test_that("Cluster measures", {
  keys = mlr_measures$keys("clust")
  task = tsk("usarrests")
  learner = lrn("clust.kmeans", centers = 2L)
  p = learner$train(task)$predict(task)

  for (key in keys) {
    m = mlr_measures$get(key)
    if (m$task_type == "clust") {
      perf = m$score(prediction = p, task = task, learner = learner)
      expect_number(perf, na.ok = FALSE, lower = m$range[1L], upper = m$range[2L])
    }
  }
})

test_that("Single-cluster edge cases are handled consistently", {
  task = tsk("usarrests")
  p = PredictionClust$new(task = task, partition = rep.int(1L, task$nrow))

  expect_true(is.nan(msr("clust.silhouette")$score(prediction = p, task = task)))
  expect_true(is.nan(msr("clust.ch")$score(prediction = p, task = task)))
  expect_true(is.nan(msr("clust.dunn")$score(prediction = p, task = task)))
  expect_true(is.nan(msr("clust.dunn2")$score(prediction = p, task = task)))
  expect_true(is.nan(msr("clust.wb_ratio")$score(prediction = p, task = task)))
  expect_true(is.nan(msr("clust.pearsongamma")$score(prediction = p, task = task)))
  expect_true(is.nan(msr("clust.davies_bouldin")$score(prediction = p, task = task)))
  expect_true(is.nan(msr("clust.avg_between")$score(prediction = p, task = task)))

  expect_equal(
    msr("clust.avg_within")$score(prediction = p, task = task),
    cluster_avg_within(as.matrix(stats::dist(task$data())), p$partition)
  )
  expect_equal(msr("clust.entropy")$score(prediction = p, task = task), 0)
  expect_equal(msr("clust.wss")$score(prediction = p, task = task), cluster_wss(as.matrix(task$data()), p$partition))
})
