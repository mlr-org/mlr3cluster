#' @title Cluster Task
#'
#' @usage NULL
#' @format [R6::R6Class] object inheriting from [Task]/.
#'
#' @description
#' This task specializes [mlr3::Task] for cluster problems.
#' As an unsupervised task, this task has no target column.
#' Predefined tasks are stored in [mlr3::mlr_tasks].
#'
#' The `task_type` is set to `"clust"`.
#'
#' @section Construction:
#' ```
#' TaskSurv$new(id, backend)
#' ```
#'
#' * `id` :: `character(1)`\cr
#'   Name of the task.
#'
#' * `backend` :: [DataBackend]
#'
#'
#' @section Fields:
#' See [mlr3::Task].
#'
#' @section Methods:
#' See [mlr3::Task].
#'
#' @family Task
#' @export
TaskClust = R6Class("TaskClust", inherit = mlr3::Task,
  public = list(
    initialize = function(id, backend) {
      super$initialize(id = id, task_type = "clust", backend = backend)
    }
  )
)
