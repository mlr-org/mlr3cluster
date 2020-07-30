#' @include measures.R
#' @include MeasureClust.R
MeasureClustInternal = R6Class("MeasureClustInternal",
  inherit = MeasureClust,
  public = list(
    crit = NULL,
    initialize = function(name) {
      info = measures[[name]]
      super$initialize(
        id = paste0("clust.", name),
        range = c(info$lower, info$upper),
        minimize = info$minimize,
        predict_type = info$predict_type,
        packages = "clusterCrit",
        properties = "requires_task",
        man = paste0("mlr3cluster::mlr_measures_clust.", name)
      )
      self$crit = info$crit

    }
  ),
  private = list(
    .score = function(prediction, task, ...) {
      X = as.matrix(task$data(rows = prediction$row_ids))
      if (!is.double(X)) { # clusterCrit does not convert lgls/ints
        storage.mode(X) = "double"
      }
      intCriteria(X, prediction$partition, self$crit)[[1L]]
    }
  )
)

#' @title Calinski Harabasz Pseudo F-Statistic
#'
#' @templateVar id ch
#' @template measure_internal
measures$ch = make_measure_info("Calinski_Harabasz", lower = 0, upper = Inf, minimize = FALSE)


#' @title Davies-Bouldin Cluster Separation Measure
#'
#' @templateVar id db
#' @template measure_internal
measures$db = make_measure_info("Davies_Bouldin", lower = 0, upper = Inf, minimize = TRUE)


#' @title Dunn Index
#'
#' @templateVar id dunn
#' @template measure_internal
measures$dunn = make_measure_info("Dunn", lower = 0, upper = Inf, minimize = FALSE)


#' @title Rousseeuw's Silhouette Quality Index
#'
#' @templateVar id silhouette
#' @template measure_internal
measures$silhouette = make_measure_info("Silhouette", lower = 0, upper = Inf, minimize = FALSE)
