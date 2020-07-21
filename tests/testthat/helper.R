library(mlr3)
library(mlr3cluster)
library(checkmate)
library(testthat)

lapply(list.files(system.file("testthat", package = "mlr3"),
                  pattern = "^helper.*\\.[rR]$", full.names = TRUE), source)

generate_tasks.LearnerClust = function(learner, N = 20L) {
  set.seed(1)
  data = mlbench::mlbench.2dnormals(N, cl = 2, r = 2, sd = 0.1)
  task = TaskClust$new("sanity", mlr3::as_data_backend(as.data.frame(data$x)))
  list(task)
}
registerS3method("generate_tasks", "LearnerClust", generate_tasks.LearnerClust, envir = parent.frame())

sanity_check.PredictionClust = function(prediction, task, ...) {
  prediction$score(measure = msr("clust.silhouette"), task = task) > 0
}
registerS3method("sanity_check", "PredictionClust", sanity_check.PredictionClust, envir = parent.frame())


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

expect_prediction_complete = function(p, predict_type) {
  expect_true(length(p$row_ids) == length(p[[predict_type]]))
  expect_false(checkmate::anyMissing(p[[predict_type]]))
}

expect_prediction_exclusive = function(p, predict_type) {
  expect_true(length(p$row_ids) == length(p[[predict_type]]))
  expect_atomic(p[[predict_type]])
  expect_integer(p[[predict_type]])
}
