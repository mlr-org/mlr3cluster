#' @title Convert to a Cluster Task
#'
#' @description
#' Convert object to a [TaskClust].
#' This is a S3 generic, specialized for at least the following objects:
#'
#' 1. [TaskClust]: ensure the identity.
#' 2. [data.frame()] and [DataBackend]: provides an alternative to calling constructor of [TaskClust].
#'
#' @inheritParams mlr3::as_task
#'
#' @return [TaskClust].
#' @export
#' @examples
#' as_task_clust(datasets::USArrests)
as_task_clust = function(x, ...) {
  UseMethod("as_task_clust")
}


#' @rdname as_task_clust
#' @param clone (`logical(1)`)\cr
#'   If `TRUE`, ensures that the returned object is not the same as the input `x`.
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
