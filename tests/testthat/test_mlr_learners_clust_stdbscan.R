skip_if_not_installed("stdbscan")

test_that("autotest", {
  learner = lrn("clust.stdbscan", eps_spatial = 25, eps_temporal = 25, min_pts = 2L)
  expect_learner(learner)

  generate_tasks.LearnerClustSTDBSCAN = function(learner, N = 20L) {
    set.seed(1L)
    data = mlbench::mlbench.2dnormals(N, cl = 2L, r = 2, sd = 0.1)
    dt = as.data.frame(data$x)
    # third column (alphabetically) must be non-negative cumulative time
    dt$z = seq_len(N)
    task = TaskClust$new("sanity", mlr3::as_data_backend(dt))
    list(task)
  }
  registerS3method(
    "generate_tasks",
    "LearnerClustSTDBSCAN",
    generate_tasks.LearnerClustSTDBSCAN,
    envir = parent.frame()
  )

  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  geolife_traj = load_dataset("geolife_traj", package = "stdbscan")
  date_time = as.POSIXct(paste(geolife_traj$date, geolife_traj$time), format = "%Y-%m-%d %H:%M:%S", tz = "UTC")
  dt = data.table(
    x = geolife_traj$x,
    y = geolife_traj$y,
    z = as.numeric(date_time - min(date_time))
  )
  task = TaskClust$new("geolife", backend = dt)
  learner = lrn("clust.stdbscan", eps_spatial = 3, eps_temporal = 30, min_pts = 3L)

  # test on multiple paramsets
  parset_list = list(
    list(eps_spatial = 3, eps_temporal = 30, min_pts = 3L),
    list(eps_spatial = 3, eps_temporal = 30, min_pts = 5L),
    list(eps_spatial = 3, eps_temporal = 30, min_pts = 3L, search = "linear")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})
