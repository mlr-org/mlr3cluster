#' @import data.table
#' @import mlr3misc
#' @import paradox
#' @import mlr3
#' @import checkmate
#' @importFrom R6 R6Class
#' @importFrom clue cl_predict
#' @importFrom fpc cluster.stats
#' @importFrom cluster silhouette
#' @importFrom stats model.frame terms predict runif dist
"_PACKAGE"

register_mlr3 = function() {
  # reflections
  x = utils::getFromNamespace("mlr_reflections", ns = "mlr3")

  # task
  x$task_types = x$task_types[!"clust"]
  x$task_types = setkeyv(rbind(x$task_types, rowwise_table(
    ~type,    ~package,       ~task,        ~learner,       ~prediction,        ~prediction_data,       ~measure,
    "clust",  "mlr3cluster",  "TaskClust",  "LearnerClust", "PredictionClust",  "PredictionDataClust",  "MeasureClust"
  ), fill = TRUE), "type")

  x$task_col_roles$clust = x$task_col_roles$regr
  x$task_properties$clust = x$task_properties$regr
  x$learner_properties$clust = c(
    "missings", "partitional", "hierarchical", "exclusive", "overlapping", "fuzzy", "complete", "partial", "density"
  )

  # measure
  x$measure_properties$clust = x$measure_properties$regr

  # learner
  x$learner_predict_types$clust = list(partition = "partition", prob = c("partition", "prob"))
  x$default_measures$clust = "clust.dunn"

  # tasks
  x = utils::getFromNamespace("mlr_tasks", ns = "mlr3")
  x$add("usarrests", load_task_usarrests)
  x$add("ruspini", load_task_ruspini)

  # learners
  x = utils::getFromNamespace("mlr_learners", ns = "mlr3")
  iwalk(learners, function(obj, nm) x$add(nm, obj))

  # measures
  x = utils::getFromNamespace("mlr_measures", ns = "mlr3")
  x$add("clust.silhouette", MeasureClustSil, name = "silhouette", label = "Silhouette")
  x$add("clust.dunn", MeasureClustFPC, name = "dunn", label = "Dunn")
  x$add("clust.ch", MeasureClustFPC, name = "ch", label = "Calinski Harabasz")
  x$add("clust.wss", MeasureClustFPC, name = "wss", label = "Within Sum of Squares")
}

.onLoad = function(libname, pkgname) {
  backports::import(pkgname)

  register_mlr3()
}

.onUnload = function(libpaths) { # nolint
  mlr_learners = mlr3::mlr_learners
  mlr_measures = mlr3::mlr_measures
  mlr_tasks = mlr3::mlr_tasks

  walk(names(learners), function(id) mlr_learners$remove(id))
  walk(names(measures), function(id) mlr_measures$remove(paste("clust", id, sep = ".")))
  walk(names(tasks), function(id) mlr_tasks$remove(id))
}

leanify_package()
