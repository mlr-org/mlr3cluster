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
