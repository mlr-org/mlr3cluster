expect_prediction_clust = function(p) {
  expect_prediction(p)
  checkmate::expect_r6(p, "PredictionClust",
                       public = c("row_ids", "truth", "predict_types", "prob", "partition"))
  checkmate::expect_numeric(p$truth, any.missing = TRUE, len = length(p$row_ids), null.ok = TRUE)
  checkmate::expect_numeric(p$partition, any.missing = FALSE, len = length(p$row_ids),
                            null.ok = TRUE)
  if ("prob" %in% p$predict_types) {
    checkmate::expect_numeric(p$prob, any.missing = FALSE, len = length(p$row_ids), lower = 0)
  }
}

expect_task_clust = function(task) {
  checkmate::expect_r6(task, "TaskClust")
}
