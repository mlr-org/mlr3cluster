skip_if_not_installed("kohonen")

test_that("autotest", {
  learner = lrn("clust.som")
  expect_learner(learner)
  # autotest uses small synthetic tasks; shrink the grid so xdim*ydim <= n
  configure_learner = function(learner, task) {
    learner$param_set$set_values(xdim = 2L, ydim = 2L)
  }
  result = run_autotest(learner, configure_learner = configure_learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.som")
  expect_learner(learner, task)

  parset_list = list(
    list(xdim = 3L, ydim = 3L),
    list(xdim = 4L, ydim = 2L, topo = "hexagonal", neighbourhood.fct = "gaussian"),
    list(xdim = 3L, ydim = 3L, rlen = 50L, mode = "batch")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})
