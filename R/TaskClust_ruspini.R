#' @title Ruspini Cluster Task
#'
#' @name mlr_tasks_ruspini
#' @include aaa.R
#' @format [R6::R6Class] inheriting from [TaskClust].
#'
#' @section Construction:
#' ```
#' mlr_tasks$get("ruspini")
#' tsk("ruspini")
#' ```
#'
#' @description
#' A cluster task for the [cluster::ruspini] data set.
#'
NULL

load_task_ruspini = function(id = "ruspini") {
  b = as_data_backend(load_dataset("ruspini", "cluster"))
  task = TaskClust$new(id, b, label = "Ruspini")
  b$hash = task$man = "mlr3cluster::mlr_tasks_ruspini"
  task
}

tasks[["ruspini"]] = load_task_ruspini
