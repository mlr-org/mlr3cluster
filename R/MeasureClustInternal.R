#' @include measures.R
#' @include MeasureClust.R
MeasureClustFPC = R6Class(
  "MeasureClustFPC",
  inherit = MeasureClust,
  public = list(
    crit = NULL,
    initialize = function(name, label) {
      info = measures[[name]]
      super$initialize(
        id = paste0("clust.", name),
        range = c(info$lower, info$upper),
        minimize = info$minimize,
        predict_type = info$predict_type,
        packages = "fpc",
        properties = "requires_task",
        label = label,
        man = paste0("mlr3cluster::mlr_measures_clust.", name)
      )
      self$crit = info$crit
    }
  ),
  private = list(
    .score = function(prediction, task, ...) {
      X = dist(task$data(rows = prediction$row_ids))
      suppressWarnings(cluster.stats(X, clustering = prediction$partition, silhouette = FALSE)[[self$crit]])
    }
  )
)

MeasureClustSil = R6Class(
  "MeasureClustSil",
  inherit = MeasureClust,
  public = list(
    crit = NULL,
    initialize = function(name, label) {
      info = measures[[name]]
      super$initialize(
        id = paste0("clust.", name),
        range = c(info$lower, info$upper),
        minimize = info$minimize,
        predict_type = info$predict_type,
        packages = "cluster",
        properties = "requires_task",
        label = label,
        man = paste0("mlr3cluster::mlr_measures_clust.", name)
      )
      self$crit = info$crit
    }
  ),
  private = list(
    .score = function(prediction, task, ...) {
      X = dist(task$data(rows = prediction$row_ids))

      if (length(unique(prediction$partition)) == 1L) {
        0L
      } else {
        mean(silhouette(prediction$partition, X)[, self$crit])
      }
    }
  )
)

#' @title Rousseeuw's Silhouette Quality Index
#'
#' @templateVar id silhouette
#' @template measure_sil
measures$silhouette = make_measure_info("sil_width", "Silhouette", lower = 0, upper = Inf, minimize = FALSE)

#' @title Calinski Harabasz Pseudo F-Statistic
#'
#' @templateVar id ch
#' @template measure_fpc
measures$ch = make_measure_info("ch", "Calinski Harabasz", lower = 0, upper = Inf, minimize = FALSE)

#' @title Dunn Index
#'
#' @templateVar id dunn
#' @template measure_fpc
measures$dunn = make_measure_info("dunn", "Dunn", lower = 0, upper = Inf, minimize = FALSE)

#' @title Within Sum of Squares
#'
#' @templateVar id wss
#' @template measure_fpc
measures$wss = make_measure_info("within.cluster.ss", "Within Sum of Squares", lower = 0, upper = Inf, minimize = TRUE)
