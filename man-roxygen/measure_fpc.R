#' @usage NULL
#' @name mlr_measures_clust.<%= id %>
#' @format [R6::R6Class()] inheriting from [MeasureClust].
#'
#' @description
#' The score function calls [fpc::cluster.stats()] from package \CRANpkg{fpc}.
#' "<%= measures[[id]]$crit %>" is used subset output of the function call.
#'
#' @section Construction:
#' This measures can be retrieved from the dictionary [mlr_measures]:
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
