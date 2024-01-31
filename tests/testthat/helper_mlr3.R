lapply(list.files(system.file("testthat", package = "mlr3"), pattern = "^helper.*\\.[rR]", full.names = TRUE), source)

generate_tasks.LearnerClust = function(learner, N = 20L) { # nolint
  set.seed(1L)
  data = mlbench::mlbench.2dnormals(N, cl = 2L, r = 2, sd = 0.1)
  task = TaskClust$new("sanity", mlr3::as_data_backend(as.data.frame(data$x)))
  list(task)
}
registerS3method("generate_tasks", "LearnerClust", generate_tasks.LearnerClust,
  envir = parent.frame()
)

sanity_check.PredictionClust = function(prediction, task, ...) { # nolint
  prediction$score(measures = msr("clust.silhouette"), task = task) > -1L
}
registerS3method("sanity_check", "PredictionClust", sanity_check.PredictionClust,
  envir = parent.frame()
)
