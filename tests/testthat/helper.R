walk(
  list.files(system.file("testthat", package = "mlr3"), pattern = "^helper.*\\.[rR]", full.names = TRUE),
  source,
  local = environment()
)
generate_tasks.LearnerClust = function(learner, N = 20L) {
  set.seed(1L)
  task = tgen("blobs", k = 2L, d = 2L, sd = 0.1, center_box = 10)$generate(N)
  task$id = "sanity"
  list(task)
}

registerS3method("generate_tasks", "LearnerClust", generate_tasks.LearnerClust)

sanity_check.PredictionClust = function(prediction, task, ...) {
  prediction$score(measures = msr("clust.silhouette"), task = task) > -1L
}

registerS3method("sanity_check", "PredictionClust", sanity_check.PredictionClust)
