test_that("clust task generators are registered", {
  keys = as.data.table(mlr_task_generators)[task_type == "clust", key]
  expect_subset("blobs", keys)

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
  set.seed(1L)
  task1 = generator$generate(40L)
  set.seed(1L)
  task2 = generator$generate(40L)
  expect_identical(task1$data(), task2$data())
})

test_that("blobs generator generates separated clusters", {
  set.seed(1L)
  task = tgen("blobs", k = 2L, d = 2L, sd = 0.1, center_box = 5)$generate(50L)
  learner = lrn("clust.kmeans", centers = 2L)
  prediction = learner$train(task)$predict(task)
  expect_gt(prediction$score(msr("clust.silhouette"), task = task), 0.9)
})

test_that("blobs generator plot", {
  grDevices::pdf(NULL)
  on.exit(grDevices::dev.off(), add = TRUE)
  expect_no_error(plot(tgen("blobs"), n = 50L))
  expect_no_error(tgen("blobs", d = 3L)$plot(n = 50L))
  expect_error(tgen("blobs", d = 1L)$plot(n = 50L), "at least 2 dimensions")
})
