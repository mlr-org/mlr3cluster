#' @import data.table
#' @import mlr3misc
#' @import paradox
#' @import mlr3
#' @import checkmate
#' @importFrom R6 R6Class
#' @importFrom clue cl_predict
#' @importFrom clusterCrit intCriteria
#' @importFrom stats model.frame terms predict runif
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
  x$learner_properties$clust = c("missings", "partitional", "hierarchical", "exclusive", "overlapping", "fuzzy", "complete", "partial")

  # measure
  x$measure_properties$clust = x$measure_properties$regr

  # learner
  x$learner_predict_types$clust = list(partition = "partition", prob = c("partition", "prob"))
  x$default_measures$clust = "clust.dunn"

  # tasks
  x = utils::getFromNamespace("mlr_tasks", ns = "mlr3")
  x$add("usarrests", load_task_usarrests)

  # learners
  x = utils::getFromNamespace("mlr_learners", ns = "mlr3")
  iwalk(learners, function(obj, nm) x$add(nm, obj))

  # measures
  x = utils::getFromNamespace("mlr_measures", ns = "mlr3")
  x$add("clust.db", MeasureClustInternal, name = "db")
  x$add("clust.dunn", MeasureClustInternal, name = "dunn")
  x$add("clust.ch", MeasureClustInternal, name = "ch")
  x$add("clust.silhouette", MeasureClustInternal, name = "silhouette")
  x$add("clust.wss", MeasureClustInternal, name = "wss")
}

.onLoad = function(libname, pkgname) {
  backports::import(pkgname)

  register_mlr3()
}

.onUnload = function(libpaths) { # nolint
  mlr_learners = mlr3::mlr_learners

  walk(names(learners), function(id) mlr_learners$remove(id))
  walk(names(measures), function(id) mlr_measures$remove(paste("clust", id, sep = ".")))
  walk(names(tasks), function(id) mlr_tasks$remove(id))
}

leanify_package()
