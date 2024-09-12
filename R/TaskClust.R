#' @title Cluster Task
#'
#' @description
#' This task specializes [mlr3::Task] for cluster problems.
#' As an unsupervised task, this task has no target column.
#' The `task_type` is set to `"clust"`.
#'
#' Predefined tasks are stored in the [dictionary][mlr3misc::Dictionary] [mlr3::mlr_tasks].
#'
#' @template param_id
#' @template param_backend
#' @template param_label
#' @family Task
#' @export
#' @examples
#' library(mlr3)
#' library(mlr3cluster)
#' task = TaskClust$new("usarrests", backend = USArrests)
#' task$task_type
#'
#' # possible properties:
#' mlr_reflections$task_properties$clust
TaskClust = R6Class("TaskClust",
  inherit = TaskUnsupervised,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function(id, backend, label = NA_character_) {
      super$initialize(id = id, task_type = "clust", backend = backend, label = label)
    }
  )
)
