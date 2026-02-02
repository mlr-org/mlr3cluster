expect_prediction_clust = function(p) {
  expect_prediction(p)
  expect_r6(p, "PredictionClust", public = c("row_ids", "truth", "predict_types", "prob", "partition"))
  expect_numeric(p$truth, any.missing = TRUE, len = length(p$row_ids), null.ok = TRUE)
  expect_numeric(p$partition, any.missing = FALSE, len = length(p$row_ids), null.ok = TRUE)
  if ("prob" %chin% p$predict_types) {
    expect_matrix(p$prob, "numeric", any.missing = FALSE, nrows = length(p$row_ids))
  }
}

expect_task_clust = function(task) expect_r6(task, "TaskClust")

expect_prediction_complete = function(p, predict_type) {
  expect_false(anyMissing(p[[predict_type]]))
}

expect_prediction_exclusive = function(p, predict_type) {
  expect_atomic(p[[predict_type]])
  expect_integer(p[[predict_type]])
}

expect_prediction_fuzzy = function(p, predict_type) {
  expect_numeric(p$prob, lower = 0, upper = 1)
  expect_numeric(round(rowSums(p$prob), 2), lower = 1, upper = 1)

  partition = max.col(p$prob, ties.method = "first")
  partition = as.numeric(colnames(p$prob)[partition])
  expect_all_true(partition == p$partition)
}
