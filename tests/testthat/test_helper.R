test_that("assert_centers_param aligns centers with the task features", {
  task = as_task_clust(data.frame(z = c(10, 11, 100, 101), a = 1:4))
  centers = data.frame(z = c(10, 101), a = c(1L, 4L))

  expect_identical(assert_centers_param(centers, task, "centers"), centers[c("a", "z")])
  expect_identical(
    assert_centers_param(as.matrix(centers), task, "centers"),
    as.matrix(centers)[, c("a", "z")]
  )
  expect_identical(assert_centers_param(unname(as.matrix(centers)), task, "centers"), unname(as.matrix(centers)))
  expect_identical(assert_centers_param(2L, task, "centers"), 2L)
  expect_error(assert_centers_param(centers[1L], task, "centers"), "one column per task feature")
  expect_error(assert_centers_param(data.frame(x = 1, y = 2), task, "centers"), "column names must match")
})
