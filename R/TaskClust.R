#' @title Cluster Task
#'
#' @description
#' This task specializes [mlr3::Task] for cluster problems.
#' As an unsupervised task, this task has no target column.
#' The `task_type` is set to `"clust"`.
#'
#' Predefined tasks are stored in the [dictionary][mlr3misc::Dictionary] [mlr_tasks].
#'
#' @template param_id
#' @template param_backend
#' @family Task
#' @export
TaskClust = R6Class("TaskClust", inherit = Task,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function(id, backend) {
      super$initialize(id = id, task_type = "clust", backend = backend)
    }
  )
)
