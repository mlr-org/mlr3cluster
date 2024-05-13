#' @title US Arrests Cluster Task
#'
#' @name mlr_tasks_usarrests
#' @format [R6::R6Class] inheriting from [TaskClust].
#'
#' @section Construction:
#'
#' ```
#' mlr_tasks$get("usarrests")
#' tsk("usarrests")
#' ```
#'
#' @description
#' A cluster task for the [datasets::USArrests] data set.
#' Rownames are stored as variable `"states"` with column role `"name"`.
#'
NULL

load_task_usarrests = function(id = "usarrests") {
  b = as_data_backend(load_dataset("USArrests", "datasets", keep_rownames = TRUE), keep_rownames = "state")
  task = TaskClust$new(id, b, label = "US Arrests")
  b$hash = task$man = "mlr3cluster::mlr_tasks_usarrests"
  task$col_roles$name = "state"
  task$col_roles$feature = setdiff(task$col_roles$feature, "state")
  task
}

#' @include aaa.R
tasks[["usarrests"]] = load_task_usarrests
