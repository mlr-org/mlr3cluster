skip_if_not_installed("apcluster")

test_that("autotest", {
  learner = lrn("clust.ap", s = apcluster::negDistMat(r = 2L))
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.ap")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(s = apcluster::negDistMat(r = 2L)),
    list(s = apcluster::linSimMat, details = TRUE, q = 0.5),
    list(s = apcluster::expSimMat, lam = 0.5, nonoise = TRUE, includeSim = TRUE),
    list(s = apcluster::corSimMat, convits = 50L, maxits = 500L)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = suppressWarnings(learner$train(task)$predict(task))
    expect_prediction_clust(p, learner)
  }
})

test_that("similarity function can be given by name", {
  task = tsk("usarrests")
  learner = lrn("clust.ap", s = "negDistMat")
  expect_false("package:apcluster" %in% search())
  p = learner$train(task)$predict(task)
  expect_prediction_clust(p, learner)
  expect_equal(p$partition, learner$assignments)

  # a user-defined function can be passed by name as well; apcluster resolves it via match.fun(), which only sees
  # the search path, so it must live in the global environment
  assign("my_sim", function(x, sel = NA, ...) apcluster::negDistMat(x, sel = sel, r = 2), envir = globalenv())
  withr::defer(rm("my_sim", envir = globalenv()))
  learner = lrn("clust.ap", s = "my_sim")
  p = learner$train(task)$predict(task)
  expect_prediction_clust(p, learner)
  expect_equal(p$partition, learner$assignments)

  # the parameter only accepts a function or a single string
  expect_error(lrn("clust.ap", s = 1), "s")
})
