#' @title Ruspini Cluster Task
#'
#' @name mlr_tasks_ruspini
#' @format [R6::R6Class] inheriting from [TaskClust].
#'
#' @description
#' A cluster task for the [cluster::ruspini] data set.
#'
#' @templateVar id ruspini
#' @template task
#'
#' @references
#' `r format_bib("ruspini_1970")`
#'
#' @template seealso_task
NULL

load_task_ruspini = function(id = "ruspini") {
  b = as_data_backend(load_dataset("ruspini", "cluster"))
  task = TaskClust$new(id, b, label = "Ruspini")
  b$hash = task$man = "mlr3cluster::mlr_tasks_ruspini"
  task
}

#' @include zzz.R
register_task("ruspini", load_task_ruspini)
