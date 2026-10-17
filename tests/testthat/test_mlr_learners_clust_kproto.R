skip_if_not_installed("clustMixType")

test_that("Learner properties are respected", {
  withr::local_seed(1L)
  data = data.frame(
    x1 = rnorm(20L),
    x2 = rnorm(20L),
    x3 = factor(sample(c("a", "b"), 20L, replace = TRUE))
  )
  task = TaskClust$new("mixed", mlr3::as_data_backend(data))
  learner = lrn("clust.kproto")
  expect_learner(learner)

  parset_list = list(
    list(k = 2L),
    list(k = 3L, type = "gower"),
    list(k = 2L, nstart = 3L)
  )

  for (parset in parset_list) {
    learner$param_set$values = insert_named(list(verbose = FALSE), parset)
    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})

test_that("single-feature task errors", {
  task = as_task_clust(data.frame(x = rnorm(20L)))
  learner = lrn("clust.kproto")
  expect_snapshot(learner$train(task), error = TRUE)
})

test_that("train and predict on mixed-type data", {
  data = data.frame(
    x1 = c(1, 2, 10, 11, 1, 2, 10, 11),
    x2 = factor(c("a", "a", "b", "b", "a", "a", "b", "b"))
  )
  task = TaskClust$new("mixed2", mlr3::as_data_backend(data))

  learner = lrn("clust.kproto", k = 2L)
  p = learner$train(task)$predict(task)
  expect_prediction_clust(p, learner)
  expect_integer(p$partition, len = 8L)
})

test_that("logical features enter the categorical part of the distance", {
  data = data.frame(lgl = rep(c(TRUE, FALSE), each = 10L), x = rep(c(0, 0.1), 10L))
  learner = lrn("clust.kproto", k = data[c(1L, 11L), ])
  learner$train(as_task_clust(data))

  expect_identical(learner$predict_newdata(data)$partition, rep(1:2, each = 10L))
  expect_identical(learner$predict_newdata(data[1:10, ])$partition, rep(1L, 10L))
  expect_true(is.logical(learner$param_set$values$k$lgl))
})

test_that("prototypes are matched to features by name", {
  data = data.frame(z = c(10, 11, 100, 101), a = factor(c("x", "x", "y", "y")))
  learner = lrn("clust.kproto", k = data[c(1L, 4L), ])$train(as_task_clust(data))
  expect_identical(learner$assignments, c(1L, 1L, 2L, 2L))
})
