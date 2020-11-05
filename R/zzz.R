#' @import data.table
#' @import mlr3misc
#' @import paradox
#' @import mlr3
#' @import checkmate
#' @importFrom R6 R6Class
#' @importFrom clue cl_predict
#' @importFrom clusterCrit intCriteria
"_PACKAGE"

register_mlr3 = function() {

  x = utils::getFromNamespace("mlr_reflections", ns = "mlr3")

  if (length(x$task_types[list("clust"), on = "type", which = TRUE, nomatch = NULL]) == 0L) {
    x$task_types = setkeyv(rbind(x$task_types, rowwise_table(
      ~type, ~package, ~task, ~learner, ~prediction, ~measure,
      "clust", "mlr3cluster", "TaskClust", "LearnerClust", "PredictionClust", "MeasureClust"
    )), "type")
    x$task_col_roles$clust = c(
      "feature", "name", "order", "stratum", "group", "weight")
    x$task_properties$clust = x$task_properties$regr
    x$learner_properties$clust = c(
      "missings", "partitional", "hierarchical", "exclusive",
      "overlapping", "fuzzy", "complete", "partial"
    )
    x$measure_properties$clust = x$measure_properties$regr
    x$learner_predict_types$clust = list(partition = "partition", prob = c("partition", "prob"))
    x$default_measures$clust = "clust.dunn"
  }

  x = utils::getFromNamespace("mlr_tasks", ns = "mlr3")
  x$add("usarrests", load_task_usarrests)

  x = utils::getFromNamespace("mlr_learners", ns = "mlr3")
  x$add("clust.featureless", LearnerClustFeatureless)
  x$add("clust.kmeans", LearnerClustKMeans)
  x$add("clust.pam", LearnerClustPAM)
  x$add("clust.agnes", LearnerClustAgnes)
  x$add("clust.diana", LearnerClustDiana)
  x$add("clust.fanny", LearnerClustFanny)
  x$add("clust.cmeans", LearnerClustCMeans)
  x$add("clust.dbscan", LearnerClustDBSCAN)
  x$add("clust.xmeans", LearnerClustXMeans)
  x$add("clust.cobweb", LearnerClustCobweb)
  x$add("clust.em", LearnerClustEM)
  x$add("clust.ff", LearnerClustFarthestFirst)
  x$add("clust.SimpleKMeans", LearnerClustSimpleKMeans)
  x$add("clust.MBatchKMeans", LearnerClustMiniBatchKMeans)
  x$add("clust.kkmeans", LearnerClustKKMeans)
  x$add("clust.ap", LearnerClustAP)
  x$add("clust.meanshift", LearnerClustMeanShift)

  x = utils::getFromNamespace("mlr_measures", ns = "mlr3")
  x$add("clust.db", MeasureClustInternal, name = "db")
  x$add("clust.dunn", MeasureClustInternal, name = "dunn")
  x$add("clust.ch", MeasureClustInternal, name = "ch")
  x$add("clust.silhouette", MeasureClustInternal, name = "silhouette")
}

.onLoad = function(libname, pkgname) { # nolint
  # nocov start
  backports::import(pkgname)

  register_mlr3()
} # nocov end
