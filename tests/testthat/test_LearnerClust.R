test_that("predict on newdata works / clust", {
  task = tsk("usarrests")$filter(1:40)
  learner = lrn("clust.featureless", num_clusters = 1L)
  expect_error(learner$predict(task), "trained")
  learner$train(task)
  expect_task(learner$state$train_task)
  newdata = tsk("usarrests")$filter(41:50)$data()

  # passing the task
  p = learner$predict_newdata(newdata = newdata, task = task)
  expect_data_table(as.data.table(p), nrows = 10)
  expect_set_equal(as.data.table(p)$row_ids, 1:10)
  expect_null(p$truth)

  # rely on internally stored task representation
  p = learner$predict_newdata(newdata = newdata, task = NULL)
  expect_data_table(as.data.table(p), nrows = 10L)
  expect_set_equal(as.data.table(p)$row_ids, 1:10)
  expect_null(p$truth)
})

test_that("reset()", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless", num_clusters = 2L)

  learner$train(task)
  expect_list(learner$state, names = "unique")
  expect_learner(learner$reset())
  expect_null(learner$state)
})

test_that("empty predict set (#421)", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless", num_clusters = 1L)
  resampling = rsmp("holdout", ratio = 1)
  hout = resampling$instantiate(task)
  model = learner$train(task, hout$train_set(1L))
  pred = learner$predict(task, hout$test_set(1L))
  expect_match(conditionMessage(learner$log$condition[[1L]]), "No data to predict on", fixed = TRUE)
})

test_that("properties follow the clustering taxonomy", {
  for (key in mlr_learners$keys("^clust\\.")) {
    properties = lrn(key)$properties
    expect_length(intersect(properties, c("exclusive", "overlapping", "fuzzy")), 1)
    expect_length(intersect(properties, c("complete", "partial")), 1)
    expect_length(intersect(properties, c("partitional", "hierarchical", "density")), 1)
  }
})

test_that("marshaled models survive a serialization boundary", {
  skip_on_cran()
  skip_if_not_installed("RWeka")
  task = tsk("usarrests")
  ids = keep(mlr_learners$keys("^clust\\."), function(key) "marshal" %chin% lrn(key)$properties)
  expect_character(ids, min.len = 1L)

  for (id in ids) {
    learner = lrn(id)
    learner$train(task)
    expected = learner$predict(task)$partition

    learner$marshal()
    restored = unserialize(serialize(learner, NULL))
    restored$unmarshal()
    expect_identical(restored$predict(task)$partition, expected, info = id)
  }
})

test_that("predict aligns features with the training task's column order", {
  skip_on_cran()
  packages = c(
    "ClusterR",
    "clustMixType",
    "dbscan",
    "flexclust",
    "fpc",
    "kohonen",
    "mclust",
    "movMF",
    "RWeka",
    "skmeans",
    "stdbscan",
    "stream",
    "withr"
  )
  for (pkg in packages) {
    skip_if_not_installed(pkg)
  }
  withr::local_seed(42)
  n = 30L
  # clusters at (0, 10) and (10, 0): swapping coordinates maps each cluster onto the other
  d = data.frame(
    a = c(rnorm(n, 0, 0.5), rnorm(n, 10, 0.5)),
    z = c(rnorm(n, 10, 0.5), rnorm(n, 0, 0.5))
  )
  task = as_task_clust(d)
  task_rev = as_task_clust(d)
  task_rev$col_roles$feature = c("z", "a")

  learners = list(
    lrn("clust.bico"),
    lrn("clust.birch", threshold = 2, branching = 50L, maxLeaf = 20L),
    lrn("clust.cobweb"),
    lrn("clust.dbscan", eps = 3),
    lrn("clust.dbscan_fpc", eps = 3, MinPts = 5L),
    lrn("clust.em"),
    lrn("clust.ff"),
    lrn("clust.hdbscan"),
    lrn("clust.kcca"),
    lrn("clust.MBatchKMeans"),
    lrn("clust.mclust"),
    lrn("clust.movMF"),
    lrn("clust.optics", eps_cl = 3),
    lrn("clust.SimpleKMeans"),
    lrn("clust.skmeans"),
    lrn("clust.som", xdim = 2L, ydim = 2L),
    lrn("clust.xmeans")
  )
  for (learner in learners) {
    learner$train(task)
    p1 = learner$predict(task)
    p2 = learner$predict(task_rev)
    expect_identical(p2$partition, p1$partition, info = learner$id)
  }

  # kproto needs a mixed numeric/factor task
  dk = data.frame(d, f = factor(rep(c("u", "v"), n)))
  task_mixed = as_task_clust(dk)
  task_mixed_rev = as_task_clust(dk)
  task_mixed_rev$col_roles$feature = c("z", "f", "a")
  learner = lrn("clust.kproto")
  learner$train(task_mixed)
  expect_identical(learner$predict(task_mixed_rev)$partition, learner$predict(task_mixed)$partition)

  # stdbscan needs two spatial features and cumulative time as the third
  dst = data.frame(a = d$a, b = d$z, c = as.numeric(seq_len(2 * n)))
  task_st = as_task_clust(dst)
  task_st_rev = as_task_clust(dst)
  task_st_rev$col_roles$feature = c("c", "b", "a")
  learner = lrn("clust.stdbscan", eps_spatial = 3, eps_temporal = 100, min_pts = 5L)
  learner$train(task_st)
  expect_identical(learner$predict(task_st_rev)$partition, learner$predict(task_st)$partition)
})

test_that("assignment saving works", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless")

  expect_true(learner$save_assignments)
  learner$train(task)
  expect_atomic_vector(learner$assignments)
  expect_length(learner$assignments, task$nrow)

  learner$reset()
  learner$save_assignments = FALSE
  expect_false(learner$save_assignments)
  learner$train(task)
  expect_null(learner$assignments)
})
