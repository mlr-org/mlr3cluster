#' @title US Arrests Cluster Task
#'
#' @name mlr_tasks_usarrests
#' @format [R6::R6Class] inheriting from [TaskClust].
#'
#' @section Construction:
#' ```
#' mlr_tasks$get("usarrests")
#' tsk("usarrests")
#' ```
#'
#' @description
#' A cluster task for the [datasets::USArrests] data set.
NULL

load_task_usarrests = function(id = "usarrests") {
  b = as_data_backend(load_dataset("USArrests", "datasets"))
  task = TaskClust$new(id, b, "US Arrests")
  b$hash = task$man = "mlr3cluster::mlr_tasks_usarrests"
  task
}

tasks[["usarrests"]] = load_task_usarrests
