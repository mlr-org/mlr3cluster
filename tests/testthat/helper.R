walk(
  list.files(system.file("testthat", package = "mlr3"), pattern = "^helper.*\\.[rR]", full.names = TRUE),
  source,
  local = environment()
)
generate_tasks.LearnerClust = function(learner, N = 20L) {
  set.seed(1L)
  centers = sample(c(-sqrt(2), sqrt(2)), N, replace = TRUE)
  x = matrix(stats::rnorm(2L * N, sd = 0.1), ncol = 2L) + centers
  task = TaskClust$new("sanity", as_data_backend(as.data.frame(x)))
  list(task)
}

registerS3method("generate_tasks", "LearnerClust", generate_tasks.LearnerClust)

sanity_check.PredictionClust = function(prediction, task, ...) {
  prediction$score(measures = msr("clust.silhouette"), task = task) > -1L
}

registerS3method("sanity_check", "PredictionClust", sanity_check.PredictionClust)
