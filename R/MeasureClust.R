#' @title Cluster Measure
#'
#' @usage NULL
#' @format [R6::R6Class] object inheriting from [mlr3::Measure].
#'
#' @description
#' This measure specializes [mlr3::Measure] for cluster analysis.
#' Predefined measures can be found in the [mlr3misc::Dictionary] [mlr3::mlr_measures].
#'
#' @section Construction:
#' ```
#' MeasureClust$new(id, range, minimize, aggregator = NULL,
#'                 properties = character(), predict_type = "partition",
#'                 task_properties = character(), packages = character()
#'                 man = NA_character_)
#' ```
#' For a description of the arguments, see [mlr3::Measure].
#' The `task_type` is set to `"clust"`.
#' Possible values for `predict_type` are `"partition"` and `"prob"`.
#'
#' @section Fields:
#' See [Measure].
#'
#' @section Methods:
#' See [Measure].
#'
#' @family Measure
#' @seealso Example cluster measures: [`clust.dunn`][mlr_measures_clust.dunn]
#' @export
MeasureClust = R6Class("MeasureClust", inherit = Measure, cloneable = FALSE,
  public = list(
    initialize = function(id, range, minimize = NA, aggregator = NULL, properties = character(), predict_type = "partition", task_properties = character(), packages = character(), man = NA_character_) {
      super$initialize(id, task_type = "clust", range = range, minimize = minimize, aggregator = aggregator,
        properties = properties, predict_type = predict_type, task_properties = task_properties, packages = packages, man = man)
    }
  )
)
