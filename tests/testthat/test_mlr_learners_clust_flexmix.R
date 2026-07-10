skip_if_not_installed("flexmix")

test_that("autotest", {
  learner = lrn("clust.flexmix")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("nrep runs repeated EM initializations", {
  task = tsk("usarrests")

  # unset and nrep = 1 are equivalent
  learner0 = lrn("clust.flexmix", k = 2L)
  withr::local_seed(42)
  learner0$train(task)
  learner1 = lrn("clust.flexmix", k = 2L, nrep = 1L)
  withr::local_seed(42)
  learner1$train(task)
  expect_identical(learner1$assignments, learner0$assignments)
  seed_nrep1 = .Random.seed

  # nrep = 5 consumes more RNG draws than a single run, proving the repetitions happen
  learner5 = lrn("clust.flexmix", k = 2L, nrep = 5L)
  withr::local_seed(42)
  learner5$train(task)
  expect_false(identical(.Random.seed, seed_nrep1))
})

test_that("nrep combined with cluster errors", {
  task = tsk("usarrests")
  learner = lrn("clust.flexmix", k = 2L, nrep = 2L, cluster = rep(1:2, length.out = task$nrow))
  expect_snapshot(error = TRUE, learner$train(task))
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.flexmix")
  expect_learner(learner, task)

  parset_list = list(
    list(k = 2L),
    list(k = 3L, model = "FLXMCmvnorm", diagonal = FALSE),
    list(k = 3L, iter.max = 50L, tolerance = 1e-4, nrep = 2L)
  )

  for (type in c("partition", "prob")) {
    learner$predict_type = type
    for (parset in parset_list) {
      learner$param_set$values = parset
      p = learner$train(task)$predict(task)
      expect_prediction_clust(p, learner)
    }
  }
})
