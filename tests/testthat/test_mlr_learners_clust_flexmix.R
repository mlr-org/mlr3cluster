skip_if_not_installed("flexmix")
skip_if_not_installed("mvtnorm")

test_that("autotest", {
  learner = lrn("clust.flexmix")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("nrep runs repeated EM initializations", {
  task = tsk("usarrests")

  # unset nrep uses the upstream default of 3
  learner0 = lrn("clust.flexmix", k = 2L)
  withr::local_seed(42)
  learner0$train(task)
  seed_unset = .Random.seed
  learner3 = lrn("clust.flexmix", k = 2L, nrep = 3L)
  withr::local_seed(42)
  learner3$train(task)
  expect_identical(.Random.seed, seed_unset)

  # nrep = 1 consumes fewer RNG draws, proving the repetitions happen
  learner1 = lrn("clust.flexmix", k = 2L, nrep = 1L)
  withr::local_seed(42)
  learner1$train(task)
  expect_false(identical(.Random.seed, seed_unset))
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
