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
#'   Defaults to the (deparsed and substituted) name of the data argument.
#' @export
as_task_clust.data.frame = function(x, id = deparse(substitute(x)), ...) { # nolint
  ii = which(map_lgl(keep(x, is.double), anyInfinite))
  if (length(ii)) {
    warningf("Detected columns with unsupported Inf values in data: %s", str_collapse(names(ii)))
  }

  TaskClust$new(id = id, backend = x)
}


#' @rdname as_task_clust
#' @export
as_task_clust.DataBackend = function(x, id = deparse(substitute(x)), ...) { # nolint
  TaskClust$new(id = id, backend = x)
}

#' @rdname as_task_clust
#' @param data (`data.frame()`)\cr
#'   Data frame containing all columns specified in formula `x`.
#' @export
as_task_clust.formula = function(x, data, id = deparse(substitute(data)), ...) { # nolint
  assert_data_frame(data)
  assert_subset(all.vars(x), c(names(data), "."), .var.name = "formula")
  if (attributes(terms(x, data = data))$response) {
    stopf("Formula %s has a response", format(x))
  }
  tab = model.frame(x, data)

  as_task_clust(tab, id = id, ...)
}
