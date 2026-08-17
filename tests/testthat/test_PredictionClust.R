test_that("Construction", {
  task = tsk("usarrests")
  p = PredictionClust$new(row_ids = task$row_ids, partition = rep.int(1L, nrow(task$data())))
  expect_prediction(p)
  expect_prediction_clust(p)

  expect_prediction(c(p, p))
})

test_that("partition derived from prob uses cluster labels", {
  prob = matrix(c(0.1, 0.9, 0.8, 0.2), nrow = 2L, byrow = TRUE, dimnames = list(NULL, c("3", "7")))
  p = PredictionClust$new(row_ids = 1:2, prob = prob)
  expect_identical(p$partition, c(7L, 3L))
})

test_that("partition derived from prob falls back to positions for non-integer labels", {
  prob = matrix(c(0.1, 0.9, 0.8, 0.2), nrow = 2L, byrow = TRUE, dimnames = list(NULL, c("a", "b")))
  expect_no_warning({
    p = PredictionClust$new(row_ids = 1:2, prob = prob)
  })
  expect_identical(p$partition, c(2L, 1L))
})

test_that("partition labels must appear among the prob column labels", {
  prob = matrix(c(0.1, 0.9, 0.8, 0.2), nrow = 2L, byrow = TRUE, dimnames = list(NULL, c("3", "7")))
  p = PredictionClust$new(row_ids = 1:2, partition = c(7L, 3L), prob = prob)
  expect_prediction_clust(p)

  expect_snapshot(error = TRUE, {
    PredictionClust$new(row_ids = 1:2, partition = c(1L, 2L), prob = prob)
  })
})

test_that("partition check falls back to positions for non-integer prob labels", {
  prob = matrix(c(0.1, 0.9, 0.8, 0.2), nrow = 2L, byrow = TRUE, dimnames = list(NULL, c("a", "b")))
  p = PredictionClust$new(row_ids = 1:2, partition = c(2L, 1L), prob = prob)
  expect_prediction_clust(p)

  expect_snapshot(error = TRUE, {
    PredictionClust$new(row_ids = 1:2, partition = c(2L, 3L), prob = prob)
  })
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

test_that("as_prediction_clust() coerces a whole-numbered partition to integer", {
  df = data.frame(row_ids = c(1, 2, 3), partition = c(1, 2, 1))
  p = as_prediction_clust(df)
  expect_integer(p$partition, len = 3L)
  expect_identical(p$partition, c(1L, 2L, 1L))
})

test_that("as_prediction_clust() rejects a non-integral partition", {
  expect_snapshot(
    error = TRUE,
    as_prediction_clust(data.frame(row_ids = 1:3, partition = c(1.5, 2, 3)))
  )
})

test_that("combining empty and non-empty prob predictions works", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless", num_clusters = 3L, predict_type = "prob")
  learner$train(task)
  p_full = learner$predict(task, row_ids = 1:10)
  p_empty = learner$predict(task, row_ids = integer())

  combined = c(p_empty, p_full)
  expect_prediction(combined)
  expect_identical(combined$row_ids, 1:10)
  expect_matrix(combined$prob, nrows = 10L, ncols = 3L)

  combined = c(p_empty, p_empty)
  expect_prediction(combined)
  expect_matrix(combined$prob, nrows = 0L)

  # a prediction filtered to zero rows keeps its k columns, unlike the empty placeholder
  p_filtered = learner$predict(task, row_ids = 1:10)$filter(integer())
  combined = c(p_empty, p_filtered)
  expect_prediction(combined)
  expect_matrix(combined$prob, nrows = 0L, ncols = 3L)
})

test_that("combined and empty prediction data keep the PredictionData class", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless")$train(task)
  p1 = learner$predict(task, row_ids = 1:5)
  p2 = learner$predict(task, row_ids = 6:10)
  expect_class(c(p1$data, p2$data), c("PredictionDataClust", "PredictionData"))

  pdata = mlr3::create_empty_prediction_data(task, learner)
  expect_class(pdata, c("PredictionDataClust", "PredictionData"))
})

test_that("resampling with an empty test set works", {
  rr = resample(tsk("usarrests"), lrn("clust.featureless"), rsmp("holdout", ratio = 1))
  expect_r6_class(rr, "ResampleResult")
  pred = rr$prediction()
  expect_prediction(pred)
  expect_integer(pred$row_ids, len = 0L)
})

test_that("combining empty prob predictions with conflicting clusters errors", {
  task = tsk("usarrests")
  learner3 = lrn("clust.featureless", num_clusters = 3L, predict_type = "prob")$train(task)
  learner4 = lrn("clust.featureless", num_clusters = 4L, predict_type = "prob")$train(task)
  p3 = learner3$predict(task, row_ids = 1:5)$filter(integer())
  p4 = learner4$predict(task, row_ids = 1:5)$filter(integer())
  expect_snapshot(error = TRUE, c(p3, p4))
})

test_that("as.data.table works for unchecked prob-only predictions", {
  prob = matrix(c(0.7, 0.3, 0.2, 0.8), nrow = 2L, byrow = TRUE, dimnames = list(NULL, c("1", "2")))
  p = PredictionClust$new(row_ids = 1:2, prob = prob, check = FALSE)
  tab = as.data.table(p)
  expect_named(tab, c("row_ids", "partition", "prob.1", "prob.2"))
  expect_identical(tab$partition, c(NA_integer_, NA_integer_))
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
  expect_matrix(pred$prob, nrows = 0L, ncols = 0L)
  expect_data_table(as.data.table(pred), nrows = 0L, ncols = 2L)
  expect_named(as.data.table(pred), c("row_ids", "partition"))
})

test_that("measure weights are carried through the prediction", {
  withr::local_seed(1)
  data = as.data.frame(datasets::USArrests)
  data$w = runif(nrow(data), 1, 2)
  task = as_task_clust(data)
  task$set_col_roles("w", "weights_measure")

  learner = lrn("clust.featureless", predict_type = "prob")
  p = learner$train(task)$predict(task)
  expect_numeric(p$weights, len = task$nrow, any.missing = FALSE)
  expect_equal(p$weights, data$w)
  expect_named(as.data.table(p), c("row_ids", "partition", "prob.1", "weights"))

  # filtering keeps the weights aligned with the retained rows
  pf = p$filter(p$row_ids[c(3L, 7L, 11L)])
  expect_numeric(pf$weights, len = 3L)
  expect_equal(pf$weights, data$w[c(3L, 7L, 11L)])

  # combining preserves the weights
  pc = c(learner$predict(task, 1:10), learner$predict(task, 11:20))
  expect_numeric(pc$weights, len = 20L)
  expect_equal(pc$weights, data$w[1:20])

  # round trip via data.table
  expect_identical(as_prediction_clust(as.data.table(p))$data, p$data)

  # empty predict sets carry a zero-length weights vector
  pe = learner$predict(task, row_ids = integer())
  expect_numeric(pe$weights, len = 0L)
})

test_that("combining weighted and unweighted predictions errors", {
  withr::local_seed(1)
  data = as.data.frame(datasets::USArrests)
  data$w = runif(nrow(data), 1, 2)
  task_weighted = as_task_clust(data)
  task_weighted$set_col_roles("w", "weights_measure")
  task = as_task_clust(as.data.frame(datasets::USArrests))

  learner = lrn("clust.featureless")
  a = learner$train(task_weighted)$predict(task_weighted)
  b = learner$train(task)$predict(task)
  expect_snapshot(error = TRUE, c(a, b))
})
