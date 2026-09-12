test_that("clust task generators are registered", {
  keys = as.data.table(mlr_task_generators)[task_type == "clust", key]
  expect_subset(c("blobs", "moons"), keys)

  for (key in keys) {
    generator = tgen(key)
    expect_task_generator(generator)
    n = 30L
    task = generator$generate(n)
    expect_task(task)
    expect_task_clust(task)
    expect_identical(generator$task_type, task$task_type)
    expect_identical(task$nrow, n)
  }
})

test_that("blobs generator", {
  generator = tgen("blobs")
  expect_identical(generator$param_set$values, list(k = 3L, d = 2L, sd = 1, center_box = 10))
  task = generator$generate(30L)
  expect_identical(task$id, "blobs_30")
  expect_set_equal(task$feature_names, c("x1", "x2"))
  expect_true(all(task$feature_types$type == "numeric"))

  task = tgen("blobs", k = 5L, d = 4L)$generate(50L)
  expect_identical(task$nrow, 50L)
  expect_set_equal(task$feature_names, sprintf("x%i", 1:4))

  task = tgen("blobs", k = 1L, d = 1L)$generate(10L)
  expect_identical(task$nrow, 10L)
  expect_identical(task$feature_names, "x1")
})

test_that("blobs generator is reproducible", {
  generator = tgen("blobs", sd = 0.5)
  task1 = withr::with_seed(1L, generator$generate(40L))
  task2 = withr::with_seed(1L, generator$generate(40L))
  expect_identical(task1$data(), task2$data())
})

test_that("blobs generator generates separated clusters", {
  skip_if_not_installed("clue")
  withr::local_seed(1L)
  task = tgen("blobs", k = 2L, d = 2L, sd = 0.1, center_box = 5)$generate(50L)
  learner = lrn("clust.kmeans", centers = 2L)
  prediction = learner$train(task)$predict(task)
  expect_gt(prediction$score(msr("clust.silhouette"), task = task), 0.9)
})

test_that("blobs generator plot", {
  withr::local_pdf(NULL)
  expect_no_error(plot(tgen("blobs"), n = 50L))
  expect_no_error(tgen("blobs", d = 3L)$plot(n = 50L))
  expect_error(tgen("blobs", d = 1L)$plot(n = 50L), "at least 2 dimensions")
})

test_that("moons generator", {
  generator = tgen("moons")
  expect_identical(generator$param_set$values, list(sd = 0.1))
  task = generator$generate(30L)
  expect_identical(task$id, "moons_30")
  expect_identical(task$feature_names, c("x1", "x2"))
  expect_true(all(task$feature_types$type == "numeric"))
  expect_identical(tgen("moons", sd = 0)$generate(7L)$nrow, 7L)
})

test_that("moons generator is reproducible", {
  generator = tgen("moons", sd = 0.05)
  task1 = withr::with_seed(1L, generator$generate(40L))
  task2 = withr::with_seed(1L, generator$generate(40L))
  expect_identical(task1$data(), task2$data())
})

test_that("moons generator generates two non-convex clusters", {
  skip_if_not_installed("dbscan")
  withr::local_seed(1L)
  generator = tgen("moons", sd = 0.05)
  obj = get_private(generator)$.generate_obj(200L)
  task = as_task_clust(as.data.table(obj$x))
  # a density-based learner recovers the two moons exactly
  prediction = lrn("clust.dbscan", eps = 0.2, minPts = 5L)$train(task)$predict(task)
  expect_identical(length(unique(prediction$partition)), 2L)
  expect_true(all(table(prediction$partition, obj$classes) %in% c(0L, 100L)))
})

test_that("moons generator plot", {
  withr::local_pdf(NULL)
  expect_no_error(plot(tgen("moons"), n = 50L))
})
