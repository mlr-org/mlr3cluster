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
  expect_integer(pdata$partition, len = 3)
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
