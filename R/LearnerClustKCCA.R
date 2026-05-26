#' @title K-Centroids Cluster Analysis Learner
#'
#' @name mlr_learners_clust.kcca
#'
#' @description
#' K-Centroids Cluster Analysis - a unified framework for partitional clustering with selectable distance / centroid
#' families: standard k-means, k-medians, spherical k-means (`"angle"`), Jaccard, and extended Jaccard.
#' Calls [flexclust::kcca()] from package \CRANpkg{flexclust}.
#'
#' The `k` parameter is set to 2 by default since [flexclust::kcca()] has no default value for the number of clusters.
#' Predictions reproduce the upstream `predict()` logic directly via slot access (preprocess new data with the
#' family's `preproc`, then assign each row with the family's `cluster` function). This avoids an S4 dispatch
#' conflict triggered when both \pkg{flexclust} and \pkg{kernlab} are loaded, since both packages define an
#' S4 class named `"kcca"`.
#'
#' @templateVar id clust.kcca
#' @template learner
#'
#' @references
#' `r format_bib("leisch2006toolbox")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustKCCA = R6Class(
  "LearnerClustKCCA",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("train", "required")),
        family = p_fct(c("kmeans", "kmedians", "angle", "jaccard", "ejaccard"), default = "kmeans", tags = "train"),
        weights = p_uty(tags = "train", custom_check = check_numeric),
        group = p_uty(tags = "train"),
        simple = p_lgl(default = FALSE, tags = "train"),
        save.data = p_lgl(default = FALSE, tags = "train"),
        iter.max = p_int(1L, default = 200L, tags = c("train", "control")),
        tolerance = p_dbl(0, default = 1e-6, tags = c("train", "control")),
        verbose = p_int(0L, default = 0L, tags = c("train", "control")),
        classify = p_fct(c("auto", "weighted", "hard"), default = "auto", tags = c("train", "control")),
        initcent = p_uty(tags = c("train", "control")),
        gamma = p_dbl(0, default = 1, tags = c("train", "control")),
        ntry = p_int(1L, default = 5L, tags = c("train", "control")),
        min.size = p_int(1L, default = 2L, tags = c("train", "control"))
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.kcca",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "flexclust",
        man = "mlr3cluster::mlr_learners_clust.kcca",
        label = "K-Centroids Cluster Analysis"
      )
    }
  ),

  private = list(
    .train = function(task) {
      ps = self$param_set
      pv = ps$get_values(tags = "train")
      pv = pv[setdiff(names(pv), ps$ids(tags = "control"))]

      control_args = ps$get_values(tags = "control")
      if (length(control_args) > 0L) {
        pv$control = invoke(methods::new, "flexclustControl", .args = control_args)
      }
      pv$family = flexclust::kccaFamily(pv$family %??% "kmeans")

      m = invoke(flexclust::kcca, x = as.matrix(task$data()), .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(flexclust::clusters(m))
      }
      m
    },

    .predict = function(task) {
      newdata = self$model@family@preproc(as.matrix(task$data()))
      partition = as.integer(self$model@family@cluster(newdata, self$model@centers))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.kcca", LearnerClustKCCA)
