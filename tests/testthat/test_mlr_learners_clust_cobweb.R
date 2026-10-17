skip_if_not_installed("RWeka")
skip_on_cran()

test_that("autotest", {
  learner = lrn("clust.cobweb")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.cobweb")
  expect_learner(learner, task)

  # test on multiple paramsets
  parset_list = list(
    list(A = 0.5),
    list(C = 1L),
    list(S = 100L),
    list(S = 0L),
    list(output_debug_info = TRUE),
    list(do_not_check_capabilities = TRUE),
    list(save_data = TRUE)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})

test_that("logical features are encoded the same way in train and predict", {
  task = as_task_clust(data.table(x = seq_len(20L) / 100, lgl = rep(c(TRUE, FALSE), 10L)))
  learner = lrn("clust.cobweb")$train(task)
  rows = which(task$data()$lgl)
  expect_identical(learner$predict(task, row_ids = rows)$partition, learner$assignments[rows])
})
