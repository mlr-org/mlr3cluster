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
