skip_if_not_installed("kernlab")

test_that("autotest", {
  learner = lrn("clust.kkmeans")
  expect_learner(learner)
  result = run_autotest(learner, exclude = "sanity") # kkmeans is non-deterministic and can produce k=1
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.kkmeans")
  expect_learner(learner, task)

  # test on multiple paramsets
  centers = data.table(
    Assault = c(100L, 200L, 150L, 300L),
    Murder = c(11, 3, 10, 5),
    Rape = c(20, 18, 10, 26),
    UrbanPop = c(60L, 54L, 53L, 69L)
  )

  parset_list = list(
    list(centers = 2L, kernel = "polydot", degree = 2L),
    list(centers = centers, kernel = "laplacedot", sigma = 2L),
    list(centers = as.matrix(centers)),
    list(centers = 3L, kernel = "anovadot")
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})

test_that("predict aligns features by name", {
  set.seed(42L)
  task = tsk("usarrests")
  learner = lrn("clust.kkmeans", centers = 2L)
  learner$train(task)
  p = learner$predict(task)

  data = task$data()
  setcolorder(data, rev(names(data)))
  p_reordered = learner$predict(as_task_clust(data))
  expect_identical(p_reordered$partition, p$partition)
})

test_that("predict matches training assignments for nonlinear kernels", {
  set.seed(42L)
  task = tsk("usarrests")
  learner = lrn("clust.kkmeans", centers = 3L, kernel = "rbfdot")
  learner$train(task)
  p = learner$predict(task)
  # kkmeans terminates on stale bound estimates, so a perfect match is not guaranteed
  expect_gte(mean(p$partition == learner$assignments), 0.95)
})
