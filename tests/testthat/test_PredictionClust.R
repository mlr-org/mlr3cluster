context("PredictionClust")

test_that("Construction", {
  task = tsk("usarrests")
  p = PredictionClust$new(row_ids = task$row_ids, partition = rep.int(1L, nrow(task$data())))
  expect_prediction(p)
  expect_prediction_clust(p)

  expect_prediction(c(p, p))
})

test_that("Internally constructed Prediction", {
  task = tsk("usarrests")
  lrn = mlr_learners$get("clust.featureless")
  lrn$param_set$values = list(num.clusters = 1L)
  p = lrn$train(task)$predict(task)
  expect_prediction(p)
  expect_prediction_clust(p)
})
