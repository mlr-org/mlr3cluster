skip_if_not_installed("e1071")

test_that("autotest", {
  learner = lrn("clust.cmeans")
  expect_learner(learner)
  result = run_autotest(learner)
  expect_true(result, info = result$error)
})

test_that("Learner properties are respected", {
  task = tsk("usarrests")
  learner = lrn("clust.cmeans")
  expect_learner(learner, task)

  # test on multiple paramsets
  centers = data.frame(matrix(ncol = length(colnames(task$data())), nrow = 4L))
  colnames(centers) = colnames(task$data())
  centers$Assault = c(100, 200, 150, 300)
  centers$Murder = c(11, 3, 10, 5)
  centers$Rape = c(20, 18, 10, 26)
  centers$UrbanPop = c(60, 54, 53, 69)

  parset_list = list(
    list(centers = 2L),
    list(centers = centers),
    list(centers = 2L, dist = "manhattan", m = 3)
  )

  for (i in seq_along(parset_list)) {
    parset = parset_list[[i]]
    learner$param_set$values = parset

    p = learner$train(task)$predict(task)
    expect_prediction_clust(p)

    if ("complete" %chin% learner$properties) {
      expect_prediction_complete(p, learner$predict_type)
    }
    if ("exclusive" %chin% learner$properties) {
      expect_prediction_exclusive(p, learner$predict_type)
    }
    if ("fuzzy" %chin% learner$properties) {
      expect_prediction_fuzzy(p)
    }
  }
})
