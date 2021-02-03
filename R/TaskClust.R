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
#' @examples
#' library(mlr3)
#' library(mlr3cluster)
#' task = TaskClust$new("usarrests", backend = USArrests)
#' task$task_type
#'
#' # possible properties:
#' mlr_reflections$task_properties$clust
TaskClust = R6Class("TaskClust",
  inherit = Task,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function(id, backend) {
      super$initialize(id = id, task_type = "clust", backend = backend)
    }
  )
)

#' @title Convert to a Cluster Task
#' @param x (`any`)\cr
#'   Object to convert, e.g. a `data.frame()`.
#' @param ... (`any`)\cr
#'   Additional arguments.
#' @export
as_task_clust = function(x, ...) {
  UseMethod("as_task_clust")
}


#' @rdname as_task_clust
#' @param clone (`logical(1)`)\cr
#'   If `TRUE`, ensures that the returned object is not the same as the input `x`, e.g.
#'   by cloning it or constructing it from a [dictionary][mlr3misc::Dictionary] such as [mlr_learners].
#' @export
as_task_clust.TaskClust = function(x, clone = FALSE, ...) { # nolint
  if (clone) x$clone() else x
}


#' @rdname as_task_clust
#' @param id (`character(1)`)\cr
#'   Id for the new task.
#'   Defaults to the (deparsed and substituted) name of `x`.
#' @export
as_task_clust.data.frame = function(x, id = deparse(substitute(x)), ...) { # nolint
  TaskClust$new(id = id, backend = x)
}


#' @rdname as_task_clust
#' @export
as_task_clust.DataBackend = function(x, id = deparse(substitute(x)), ...) { # nolint
  TaskClust$new(id = id, backend = x)
}
