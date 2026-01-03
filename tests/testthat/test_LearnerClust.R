test_that("predict on newdata works / clust", {
  task = tsk("usarrests")$filter(1:40)
  learner = lrn("clust.featureless", num_clusters = 1L)
  expect_error(learner$predict(task), "trained")
  learner$train(task)
  expect_task(learner$state$train_task)
  newdata = tsk("usarrests")$filter(41:50)$data()

  # passing the task
  p = learner$predict_newdata(newdata = newdata, task = task)
  expect_data_table(as.data.table(p), nrows = 10)
  expect_set_equal(as.data.table(p)$row_ids, 1:10)
  expect_null(p$truth)

  # rely on internally stored task representation
  p = learner$predict_newdata(newdata = newdata, task = NULL)
  expect_data_table(as.data.table(p), nrows = 10L)
  expect_set_equal(as.data.table(p)$row_ids, 1:10)
  expect_null(p$truth)
})

test_that("reset()", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless", num_clusters = 2L)

  learner$train(task)
  expect_list(learner$state, names = "unique")
  expect_learner(learner$reset())
  expect_null(learner$state)
})

test_that("empty predict set (#421)", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless", num_clusters = 1L)
  resampling = rsmp("holdout", ratio = 1)
  hout = resampling$instantiate(task)
  model = learner$train(task, hout$train_set(1L))
  pred = learner$predict(task, hout$test_set(1L))
  expect_match(learner$log$msg, "No data to predict on", fixed = TRUE, all = FALSE)
})

test_that("assignment saving works", {
  task = tsk("usarrests")
  learner = lrn("clust.featureless")

  expect_true(learner$save_assignments)
  learner$train(task)
  expect_vector(learner$assignments)
  expect_length(learner$assignments, task$nrow)

  learner$reset()
  learner$save_assignments = FALSE
  expect_false(learner$save_assignments)
  learner$train(task)
  expect_null(learner$assignments)
})
