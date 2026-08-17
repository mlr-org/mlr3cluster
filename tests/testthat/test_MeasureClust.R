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

test_that("Data measures error on factor features", {
  data = data.frame(
    x1 = c(1, 2, 10, 11, 1, 2, 10, 11),
    x2 = factor(c("a", "a", "b", "b", "a", "a", "b", "b"))
  )
  task = TaskClust$new("mixed", mlr3::as_data_backend(data))
  p = PredictionClust$new(task = task, partition = rep(1:2, each = 4L))

  expect_snapshot(msr("clust.ch")$score(prediction = p, task = task), error = TRUE)
  expect_snapshot(msr("clust.wss")$score(prediction = p, task = task), error = TRUE)
  expect_snapshot(msr("clust.sse_ratio")$score(prediction = p, task = task), error = TRUE)
  expect_snapshot(msr("clust.davies_bouldin")$score(prediction = p, task = task), error = TRUE)
})

test_that("empty predictions score as NaN", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless")$train(task)
  p = learner$predict(task, row_ids = integer())

  for (key in mlr_measures$keys("clust")) {
    expect_true(is.nan(msr(key)$score(prediction = p, task = task, learner = learner)), info = key)
  }
})

test_that("clust.pred_strength refits the learner and scores stability", {
  set.seed(1)
  task = tsk("ruspini")
  learner = lrn("clust.kmeans", centers = 4L, nstart = 20L)
  resampling = rsmp("holdout")$instantiate(task)
  learner$train(task, row_ids = resampling$train_set(1L))
  p = learner$predict(task, row_ids = resampling$test_set(1L))

  m = msr("clust.pred_strength")
  expect_subset(c("requires_task", "requires_learner"), m$properties)
  model = learner$model
  perf = m$score(prediction = p, task = task, learner = learner)
  expect_number(perf, lower = 0, upper = 1)

  # well-separated data: the clustering must be recoverable
  expect_gt(perf, 0.8)

  # scoring refits a clone and must not touch the passed learner
  expect_identical(learner$model, model)
})

test_that("clust.pred_strength matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  n = nrow(x)
  # clust.pam mirrors fpc's claraCBI with centroid classification: both train with
  # cluster::pam() and assign new observations to the nearest medoid, so the only
  # random draw in fpc::prediction.strength() is the half split, replayed below
  for (k in c(2L, 3L, 5L)) {
    withr::local_seed(1L)
    expected = fpc::prediction.strength(
      x,
      Gmin = k,
      Gmax = k,
      M = 1,
      clustermethod = fpc::claraCBI,
      classification = "centroid"
    )$mean.pred[[k]]

    withr::local_seed(1L)
    nperm = sample(n, n)
    halves = list(seq_len(floor(n / 2)), seq(floor(n / 2) + 1L, n))
    task = as_task_clust(as.data.frame(x[nperm, ]), id = "usarrests_perm")

    m = msr("clust.pred_strength")
    scores = map_dbl(1:2, function(i) {
      learner = lrn("clust.pam", k = k)
      learner$train(task, row_ids = halves[[3L - i]])
      p = learner$predict(task, row_ids = halves[[i]])
      m$score(prediction = p, task = task, learner = learner)
    })

    expect_equal(mean(scores), expected, info = sprintf("k=%d", k))
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
