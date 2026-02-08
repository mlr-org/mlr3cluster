#' @usage NULL
#' @name mlr_measures_clust.<%= id %>
#' @format [R6::R6Class()] inheriting from [MeasureClust].
#'
#' @description
#' The score function calls [cluster::silhouette()] from package \CRANpkg{cluster}.
#' "<%= measures[[id]]$crit %>" is used to subset the output of the function call.
#'
#' @section Construction:
#' This measure can be retrieved from the dictionary [mlr3::mlr_measures]:
#' ```
#' mlr_measures$get("clust.<%= id %>")
#' msr("clust.<%= id %>")
#' ```
#'
#' @section Meta Information:
#' <% item = measures[[id]] %>
#' * Range: <%= rd_format_range(item$lower, item$upper) %>
#' * Minimize: `<%= item$minimize %>`
#' * Required predict type: `<%= item$predict_type %>`
#'
#'
#' @family cluster measures
#'
#' @seealso
#' [Dictionary][mlr3misc::Dictionary] of [Measures][mlr3::Measure]: [mlr3::mlr_measures]
#'
#' `as.data.table(mlr_measures)` for a complete table of all (also dynamically created) [mlr3::Measure] implementations.
