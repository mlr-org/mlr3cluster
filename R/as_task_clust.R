#' @title Convert to a Cluster Task
#'
#' @description
#' Convert object to a [TaskClust] or a list of [TaskClust].
#' This is a S3 generic, specialized for at least the following objects:
#'
#' 1. [TaskClust]: returns the object as-is, possibly cloned.
#' 2. [`formula`], [data.frame()], [matrix()], and [mlr3::DataBackend]: provides an alternative to the
#'    constructor of [TaskClust].
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
as_task_clust.TaskClust = function(x, clone = FALSE, ...) {
  if (clone) x$clone() else x
}

#' @rdname as_task_clust
#' @param id (`character(1)`)\cr
#'   Id for the new task.
#'   Defaults to the (deparsed and substituted) name of the data argument.
#' @template param_label
#' @export
as_task_clust.data.frame = function(x, id = deparse1(substitute(x)), label = NA_character_, ...) {
  force(id)

  ii = which(map_lgl(keep(x, is.double), anyInfinite))
  if (length(ii) > 0L) {
    warning_input("Detected columns with unsupported Inf values in data: %s", str_collapse(names(ii)))
  }

  TaskClust$new(id = id, backend = x, label = label)
}

#' @rdname as_task_clust
#' @export
as_task_clust.matrix = function(x, id = deparse1(substitute(x)), label = NA_character_, ...) {
  force(id)

  assert_matrix(x, col.names = "unique", min.rows = 1L, min.cols = 1L)

  as_task_clust(as.data.table(x), id = id, label = label, ...)
}

#' @rdname as_task_clust
#' @export
as_task_clust.DataBackend = function(x, id = deparse1(substitute(x)), label = NA_character_, ...) {
  force(id)

  TaskClust$new(id = id, backend = x, label = label)
}

#' @rdname as_task_clust
#' @param data (`data.frame()`)\cr
#'   Data frame containing all columns specified in formula `x`.
#' @export
as_task_clust.formula = function(x, data, id = deparse1(substitute(data)), label = NA_character_, ...) {
  force(id)

  assert_data_frame(data)
  assert_subset(all.vars(x), c(names(data), "."), .var.name = "formula")
  if (attr(terms(x, data = data), "response")) {
    error_input("Formula %s has a response.", format(x))
  }
  tab = model.frame(x, data, na.action = "na.pass")
  setattr(tab, "terms", NULL)
  setattr(tab, "na.action", NULL)

  as_task_clust(tab, id = id, label = label, ...)
}

#' @rdname as_task_clust
#' @export
as_tasks_clust = function(x, ...) {
  UseMethod("as_tasks_clust")
}

#' @rdname as_task_clust
#' @export
as_tasks_clust.list = function(x, clone = FALSE, ...) {
  lapply(x, as_task_clust, clone = clone, ...)
}

#' @rdname as_task_clust
#' @export
as_tasks_clust.TaskClust = function(x, clone = FALSE, ...) {
  list(if (clone) x$clone() else x)
}
