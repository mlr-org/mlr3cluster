#' @title Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.hclust
#'
#' @description
#' Agglomerative hierarchical clustering.
#' Calls [stats::hclust()] from package \pkg{stats}.
#'
#' Distance calculation is done by [stats::dist()].
#'
#' @templateVar id clust.hclust
#' @template learner
#'
#' @references
#' `r format_bib("becker1988s", "everitt1974cluster", "hartigan1975clustering", "sneath1973numerical", "anderberg1973cluster", "gordon1999classification", "murtagh1985multidimensional", "mcquitty1966similarity", "legendre2012numerical", "murtagh2014ward")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustHclust = R6Class("LearnerClustHclust",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        method = p_fct(
          levels = c("ward.D", "ward.D2", "single", "complete", "average", "mcquitty", "median", "centroid"),
          default = "complete",
          tags = c("train", "hclust")
        ),
        members = p_uty(default = NULL, tags = c("train", "hclust")),
        distmethod = p_fct(
          levels = c("euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski"),
          default = "euclidean",
          tags = "train"
        ),
        diag = p_lgl(default = FALSE, tags = c("train", "dist")),
        upper = p_lgl(default = FALSE, tags = c("train", "dist")),
        p = p_dbl(default = 2, tags = c("train", "dist"), depends = quote(distmethod == "minkowski")),
        k = p_int(1L, default = NULL, special_vals = list(NULL), tags = c("train", "cutree", "predict"))
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.hclust",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "stats",
        man = "mlr3cluster::mlr_learners_clust.hclust",
        label = "Hierarchical Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      ps = self$param_set
      dist = invoke(
        stats::dist,
        x = task$data(),
        method = ps$get_values(tags = "train")$distmethod %??% "euclidean",
        .args = ps$get_values(tags = c("train", "dist"))
      )
      m = invoke(
        stats::hclust,
        d = dist,
        .args = ps$get_values(tags = c("train", "hclust"))
      )
      if (self$save_assignments) {
        self$assignments = invoke(
          stats::cutree,
          tree = m,
          .args = ps$get_values(tags = c("train", "cutree"))
        )
      }
      m
    },

    .predict = function(task) {
      pv = self$param_set$get_values(tags = "predict")
      if (pv$k > task$nrow) {
        error_input("`k` needs to be between 1 and %i.", task$nrow)
      }

      warn_prediction_useless(self$id)
      partition = self$assignments %??% invoke(
        stats::cutree,
        tree = self$model,
        .args = self$param_set$get_values(tags = c("train", "cutree"))
      )

      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.hclust", LearnerClustHclust)
