test_that("Construction", {
  task = tsk("usarrests")
  p = PredictionClust$new(row_ids = task$row_ids, partition = rep.int(1L, nrow(task$data())))
  expect_prediction(p)
  expect_prediction_clust(p)

  expect_prediction(c(p, p))
})

test_that("Internally constructed Prediction", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless", num_clusters = 1L)
  p = learner$train(task)$predict(task)
  expect_prediction(p)
  expect_prediction_clust(p)
})

test_that("filter works", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless", num_clusters = 1L)
  p = learner$train(task)$predict(task)
  pdata = p$data

  pdata = filter_prediction_data(pdata, row_ids = 1:3)
  expect_set_equal(pdata$row_ids, 1:3)
  expect_integer(pdata$partition, len = 3L)
})

test_that("as_prediction_clust", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless", num_clusters = 3L, predict_type = "prob")
  p = learner$train(task)$predict(task)

  tab = as.data.table(p)
  p2 = as_prediction_clust(tab)
  expect_equal(tab, as.data.table(p2))

  # data.frame input must also work (would previously error on `with = FALSE`)
  df = data.frame(row_ids = 1:3, partition = c(1L, 2L, 1L))
  expect_class(as_prediction_clust(df), "PredictionClust")

  df = data.frame(
    row_ids = 1:3,
    partition = c(1L, 2L, 1L),
    prob.1 = c(0.7, 0.2, 0.6),
    prob.2 = c(0.3, 0.8, 0.4)
  )
  p3 = as_prediction_clust(df)
  expect_class(p3, "PredictionClust")
  expect_matrix(p3$prob, nrows = 3L, ncols = 2L)

  # extra columns not prefixed with 'prob.' are rejected
  bad = data.frame(row_ids = 1L, partition = 1L, garbage = 0.5)
  expect_error(as_prediction_clust(bad), "prob")
})

test_that("construction of empty PredictionDataClust", {
  task = tsk("usarrests")

  learner = lrn("clust.featureless", predict_type = "partition")
  learner$train(task)
  pred = learner$predict(task, row_ids = integer())
  expect_prediction(pred)
  expect_set_equal(pred$predict_types, "partition")
  expect_integer(pred$row_ids, len = 0L)
  expect_numeric(pred$partition, len = 0L)
  expect_null(pred$prob)
  expect_data_table(as.data.table(pred), nrows = 0L, ncols = 2L)

  learner = lrn("clust.featureless", predict_type = "prob")
  learner$train(task)
  pred = learner$predict(task, row_ids = integer())
  expect_prediction(pred)
  expect_set_equal(pred$predict_types, c("partition", "prob"))
  expect_integer(pred$row_ids, len = 0L)
  expect_numeric(pred$partition, len = 0L)
  expect_numeric(pred$prob, len = 0L)
  expect_data_table(as.data.table(pred), nrows = 0L, ncols = 3L)
})
