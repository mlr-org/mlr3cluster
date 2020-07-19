generate_tasks.LearnerClust = function(learner, N = 30L) {
  data = generate_data(learner, N)
  task = TaskClust$new("proto", mlr3::as_data_backend(data))

  tasks = generate_generic_tasks(learner, task)

  # generate sanity task
  data = with_seed(100, {
    x = seq(from = -10, to = 10, length.out = 100)
    data.table::data.table(
      x = x
    )
  })
  tasks$sanity = TaskClust$new("sanity", mlr3::as_data_backend(data))
  tasks$sanity_reordered = TaskClust$new("sanity_reordered", mlr3::as_data_backend(data))

  tasks
}
registerS3method("generate_tasks", "LearnerClust", generate_tasks.LearnerClust)

sanity_check.PredictionClust = function(prediction) {
  prediction$score(mlr3::msr("clust.silhouette")) >= 0
}
registerS3method("sanity_check", "LearnerClust", sanity_check.PredictionClust)
