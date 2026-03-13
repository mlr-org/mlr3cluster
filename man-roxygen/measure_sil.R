#' @name mlr_measures_clust.<%= id %>
#'
#' @description
#' The score function calls [cluster::silhouette()] from package \CRANpkg{cluster}.
#'
#' @section Dictionary:
#' This [mlr3::Measure] can be instantiated via the [dictionary][mlr3misc::Dictionary] [mlr3::mlr_measures] or with the
#' associated sugar function [mlr3::msr()]:
#' ```
#' mlr_measures$get("clust.<%= id %>")
#' msr("clust.<%= id %>")
#' ```
#'
#' @section Meta Information:
#' `r mlr3misc::rd_info(mlr3::msr("clust.<%= id %>"))`
#'
#' @family cluster measures
#'
#' @seealso
#' [Dictionary][mlr3misc::Dictionary] of [Measures][mlr3::Measure]: [mlr3::mlr_measures]
#'
#' `as.data.table(mlr_measures)` for a complete table of all (also dynamically created) [mlr3::Measure] implementations.
