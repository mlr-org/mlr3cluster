#' @title Cluster Measure
#'
#' @description
#' This measure specializes [mlr3::Measure] for cluster analysis:
#'
#' * `task_type` is set to `"clust"`.
#' * Possible values for `predict_type` are `"partition"` and `"prob"`.
#'
#' Predefined measures can be found in the [mlr3misc::Dictionary] [mlr3::mlr_measures].
#'
#' @template param_id
#' @template param_range
#' @template param_minimize
#' @template param_average
#' @template param_aggregator
#' @template param_predict_type
#' @template param_measure_properties
#' @template param_predict_sets
#' @template param_task_properties
#' @template param_packages
#' @template param_label
#' @template param_man
#'
#' @seealso
#' Example cluster measures: [`clust.dunn`][mlr_measures_clust.dunn]
#' @export
MeasureClust = R6Class("MeasureClust",
  inherit = Measure, cloneable = FALSE,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function(id, range, minimize = NA, aggregator = NULL, properties = character(),
      predict_type = "partition", task_properties = character(),
      packages = character(), label = NA_character_, man = NA_character_) {
      super$initialize(id,
        task_type = "clust", range = range, minimize = minimize,
        aggregator = aggregator, properties = properties,
        predict_type = predict_type, task_properties = task_properties,
        packages = c("mlr3cluster", packages), label = label, man = man
      )
    }
  )
)
