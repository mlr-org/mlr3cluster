context("TaskClust")

test_that("Basic ops on usarrests task", {
  task = tsk("usarrests")
  expect_task(task)
  expect_task_clust(task)
  expect_identical(task$target_names, character(0))
})
