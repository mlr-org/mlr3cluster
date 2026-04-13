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

test_that("Measures work with factor features via Gower distance", {
  data = data.frame(
    x1 = c(1, 2, 10, 11, 1, 2, 10, 11),
    x2 = factor(c("a", "a", "b", "b", "a", "a", "b", "b"))
  )
  task = TaskClust$new("mixed", mlr3::as_data_backend(data))
  partition = rep(1:2, each = 4L)
  p = PredictionClust$new(task = task, partition = partition)

  dist_keys = c(
    "clust.silhouette",
    "clust.dunn",
    "clust.dunn2",
    "clust.wb_ratio",
    "clust.pearsongamma",
    "clust.avg_between",
    "clust.avg_within"
  )
  for (key in dist_keys) {
    m = msr(key)
    perf = m$score(prediction = p, task = task)
    expect_number(perf, na.ok = FALSE, lower = m$range[1L], upper = m$range[2L], info = key)
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
