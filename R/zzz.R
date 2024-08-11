#' @import checkmate
#' @import data.table
#' @import mlr3
#' @import mlr3misc
#' @import paradox
#' @importFrom R6 R6Class
#' @importFrom clue cl_predict
#' @importFrom cluster silhouette
#' @importFrom fpc cluster.stats
#' @importFrom stats model.frame terms predict runif dist
"_PACKAGE"

utils::globalVariables("type")

mlr3cluster_tasks = new.env()
mlr3cluster_learners = new.env()

register_task = function(name, constructor) {
  if (name %in% names(mlr3cluster_tasks)) stopf("task %s registered twice", name)
  mlr3cluster_tasks[[name]] = constructor
}

register_learner = function(name, constructor) {
  if (name %in% names(mlr3cluster_learners)) stopf("learner %s registered twice", name)
  mlr3cluster_learners[[name]] = constructor
}

register_mlr3 = function() {
  # reflections
  mlr_reflections = utils::getFromNamespace("mlr_reflections", ns = "mlr3")
  mlr_reflections$task_types = mlr_reflections$task_types[type != "clust"]
  mlr_reflections$task_types = setkeyv(rbind(mlr_reflections$task_types, rowwise_table(
    ~type,    ~package,       ~task,        ~learner,       ~prediction,        ~prediction_data,       ~measure,
    "clust",  "mlr3cluster",  "TaskClust",  "LearnerClust", "PredictionClust",  "PredictionDataClust",  "MeasureClust"
  ), fill = TRUE), "type")

  mlr_reflections$task_col_roles$clust = mlr_reflections$task_col_roles$regr
  mlr_reflections$task_properties$clust = mlr_reflections$task_properties$regr
  mlr_reflections$learner_properties$clust = c(
    "missings", "partitional", "hierarchical", "exclusive", "overlapping", "fuzzy", "complete", "partial", "density"
  )
  mlr_reflections$learner_predict_types$clust = list(partition = "partition", prob = c("partition", "prob"))
  mlr_reflections$measure_properties$clust = mlr_reflections$measure_properties$regr
  mlr_reflections$default_measures$clust = "clust.dunn"

  # tasks
  mlr_tasks = utils::getFromNamespace("mlr_tasks", ns = "mlr3")
  iwalk(as.list(mlr3cluster_tasks), function(task, id) mlr_tasks$add(id, task))

  # learners
  mlr_learners = utils::getFromNamespace("mlr_learners", ns = "mlr3")
  iwalk(as.list(mlr3cluster_learners), function(learner, id) mlr_learners$add(id, learner))

  # measures
  mlr_measures = utils::getFromNamespace("mlr_measures", ns = "mlr3")
  mlr_measures$add("clust.silhouette", MeasureClustSil, name = "silhouette", label = "Silhouette")
  mlr_measures$add("clust.dunn", MeasureClustFPC, name = "dunn", label = "Dunn")
  mlr_measures$add("clust.ch", MeasureClustFPC, name = "ch", label = "Calinski Harabasz")
  mlr_measures$add("clust.wss", MeasureClustFPC, name = "wss", label = "Within Sum of Squares")
}

.onLoad = function(libname, pkgname) {
  backports::import(pkgname)

  register_namespace_callback(pkgname, "mlr3", register_mlr3)
}

.onUnload = function(libpaths) { # nolint
  walk(names(mlr3cluster_tasks), function(id) mlr_tasks$remove(id))
  walk(names(mlr3cluster_learners), function(id) mlr_learners$remove(id))
  walk(names(measures), function(id) mlr_measures$remove(paste("clust", id, sep = ".")))

  mlr_reflections$task_types = mlr_reflections$task_types[type != "clust"]
  reflections = c(
    "measure_properties", "default_measures", "learner_properties",
    "learner_predict_types",  "task_properties", "task_col_roles"
  )
  walk(reflections, function(x) mlr_reflections[[x]] = remove_named(mlr_reflections[[x]], "clust"))
}

leanify_package()
