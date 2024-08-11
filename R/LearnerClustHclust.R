#' @title Agglomerative Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.hclust
#'
#' @description
#' A [LearnerClust] for agglomerative hierarchical clustering implemented in [stats::hclust()].
#' Difference Calculation is done by [stats::dist()]
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
          default = "complete",
          levels = c("ward.D", "ward.D2", "single", "complete", "average", "mcquitty", "median", "centroid"),
          tags = c("train", "hclust")
        ),
        members = p_uty(default = NULL, tags = c("train", "hclust")),
        distmethod = p_fct(
          default = "euclidean", levels = c("euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski"),
          tags = "train"
        ),
        diag = p_lgl(default = FALSE, tags = c("train", "dist")),
        upper = p_lgl(default = FALSE, tags = c("train", "dist")),
        p = p_dbl(default = 2, tags = c("train", "dist"), depends = quote(distmethod == "minkowski")),
        k = p_int(1L, default = 2L, tags = "predict")
      )

      param_set$set_values(k = 2L, distmethod = "euclidean")

      super$initialize(
        id = "clust.hclust",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "stats",
        man = "mlr3cluster::mlr_learners_clust.hclust",
        label = "Agglomerative Hierarchical Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values()
      dist = invoke(stats::dist,
        x = task$data(),
        method = pv$d %??% "euclidean",
        .args = self$param_set$get_values(tags = c("train", "dist"))
      )
      m = invoke(stats::hclust,
        d = dist,
        .args = self$param_set$get_values(tags = c("train", "hclust"))
      )
      if (self$save_assignments) {
        self$assignments = stats::cutree(m, pv$k)
      }
      m
    },

    .predict = function(task) {
      pv = self$param_set$get_values(tags = "predict")
      if (pv$k > task$nrow) {
        stopf("`k` needs to be between 1 and %i", task$nrow)
      }

      warn_prediction_useless(self$id)

      PredictionClust$new(task = task, partition = self$assignments)
    }
  )
)

#' @include zzz.R
register_learner("clust.hclust", LearnerClustHclust)
