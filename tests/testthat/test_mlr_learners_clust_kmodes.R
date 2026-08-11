skip_if_not_installed("klaR")

test_that("autotest", {
  learner = lrn("clust.kmodes")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("paramtest", {
  learner = lrn("clust.kmodes")
  result = run_paramtest(learner, klaR::kmodes, exclude = "data", tag = "train")
  expect_true(
    result,
    info = paste0(
      "\nMissing parameters in mlr3 param set:\n",
      paste0("- ", result$missing, "\n", collapse = ""),
      "\nOutdated parameters in mlr3 param set:\n",
      paste0("- ", result$extra, "\n", collapse = "")
    )
  )
})

test_that("Learner properties are respected", {
  data = data.frame(
    color = factor(rep(c("red", "blue"), each = 4L)),
    shape = ordered(rep(c("round", "square"), each = 4L))
  )
  task = as_task_clust(data)
  learner = lrn("clust.kmodes")
  expect_learner(learner, task)

  parset_list = list(
    list(modes = 2L),
    list(modes = 2L, iter.max = 2L, fast = FALSE),
    list(modes = data[c(1L, 5L), ], weighted = TRUE)
  )

  for (parset in parset_list) {
    learner$param_set$values = parset
    p = learner$train(task)$predict(task)
    expect_prediction_clust(p, learner)
  }
})

test_that("predicts new categorical data and aligns features", {
  train = data.frame(
    shape = ordered(c("round", "round", "square", "square", "square", "round")),
    color = factor(c("red", "red", "red", "blue", "blue", "blue"))
  )
  newdata = data.frame(
    color = factor(c("red", "blue"), levels = levels(train$color)),
    shape = ordered(c("round", "square"), levels = levels(train$shape))
  )

  learner = lrn("clust.kmodes", modes = train[c(1L, 4L), ])
  learner$train(as_task_clust(train))
  p1 = learner$predict_newdata(newdata)
  p2 = learner$predict_newdata(newdata[c("shape", "color")])

  expect_prediction_clust(p1, learner)
  expect_identical(p2$partition, p1$partition)
  expect_length(p1$partition, 2L)
})

test_that("user-supplied modes are aligned by feature name", {
  train = data.frame(
    z_shape = factor(rep(c("round", "square"), each = 3L)),
    a_color = factor(rep(c("red", "blue"), each = 3L))
  )
  task = as_task_clust(train)
  learner = lrn("clust.kmodes", modes = train[c(1L, 4L), ], weighted = TRUE)

  expect_no_condition(learner$train(task))
  expect_identical(
    learner$predict_newdata(train[c(1L, 4L), ])$partition,
    c(1L, 2L)
  )
})

test_that("predicting the training task returns fitted assignments", {
  withr::local_seed(1L)
  data = data.frame(
    x = factor(sample(letters[1:3], 100L, replace = TRUE)),
    y = factor(sample(letters[1:3], 100L, replace = TRUE))
  )
  task = as_task_clust(data)
  learner = lrn("clust.kmodes", modes = 2L)$train(task)

  expect_identical(learner$predict(task)$partition, as.integer(learner$model$cluster))
})

test_that("prediction ties are configurable", {
  train = data.frame(
    x = factor(c("a", "a", "b", "b")),
    y = factor(c("a", "a", "b", "b"))
  )
  newdata = data.frame(
    x = factor("a", levels = levels(train$x)),
    y = factor("b", levels = levels(train$y))
  )
  learner = lrn("clust.kmodes", modes = train[c(1L, 3L), ])$train(as_task_clust(train))

  learner$param_set$set_values(ties = "first")
  expect_identical(learner$predict_newdata(newdata)$partition, 1L)
  learner$param_set$set_values(ties = "last")
  expect_identical(learner$predict_newdata(newdata)$partition, 2L)
  learner$param_set$set_values(ties = "random")
  withr::local_seed(1L)
  expect_integer(learner$predict_newdata(newdata)$partition, lower = 1L, upper = 2L)

  learner$param_set$values = list(modes = train[c(1L, 3L), ])
  expect_identical(learner$predict_newdata(newdata)$partition, 1L)
})

test_that("numeric categories retain their native values", {
  train = data.frame(
    y = factor(c("a", "a", "b", "b")),
    x = c(100000L, 100000L, 200000L, 200000L)
  )
  learner = lrn(
    "clust.kmodes",
    modes = train[c(1L, 3L), ],
    weighted = TRUE
  )$train(as_task_clust(train))

  expect_identical(learner$predict_newdata(train[3L, ])$partition, 2L)
})

test_that("prediction handles unseen numeric categories", {
  train = data.frame(x = c(1L, 1L, 2L, 2L), y = c(1L, 1L, 2L, 2L))
  learner = lrn("clust.kmodes", modes = train[c(1L, 3L), ], weighted = TRUE)$train(as_task_clust(train))

  expect_identical(learner$predict_newdata(data.frame(x = 3L, y = 1L))$partition, 1L)
})

test_that("invalid modes error informatively", {
  task = as_task_clust(data.frame(x = factor(c("a", "b")), y = factor(c("a", "b"))))

  expect_snapshot(lrn("clust.kmodes", modes = data.frame(x = factor("a")))$train(task), error = TRUE)
  expect_snapshot(
    lrn(
      "clust.kmodes",
      modes = data.frame(a = factor("a"), b = factor("a"))
    )$train(task),
    error = TRUE
  )
})
