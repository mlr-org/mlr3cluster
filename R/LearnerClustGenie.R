#' @title Genie Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.genie
#'
#' @description
#' Genie hierarchical clustering, a fast and robust outlier-resistant algorithm based on the
#' Gini inequality measure applied to cluster sizes during the linkage process.
#' Calls [genieclust::gclust()] from package \CRANpkg{genieclust}.
#'
#' There is no predict method for [genieclust::gclust()], so the method returns cluster labels
#' for the training data obtained via [stats::cutree()] at the requested `k`.
#'
#' @templateVar id clust.genie
#' @template learner
#'
#' @references
#' `r format_bib("gagolewski2016genie", "gagolewski2021genieclust")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustGenie = R6Class(
  "LearnerClustGenie",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        gini_threshold = p_dbl(0, 1, default = 0.3, tags = c("train", "gclust")),
        M = p_int(0L, default = 0L, tags = c("train", "gclust")),
        distance = p_fct(
          c("euclidean", "l2", "manhattan", "cityblock", "l1", "cosine"),
          default = "euclidean",
          tags = c("train", "gclust")
        ),
        verbose = p_lgl(default = FALSE, tags = c("train", "gclust")),
        k = p_int(1L, default = 2L, tags = c("train", "cutree", "predict"))
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.genie",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "genieclust",
        man = "mlr3cluster::mlr_learners_clust.genie",
        label = "Genie Hierarchical Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      ps = self$param_set
      m = invoke(
        genieclust::gclust,
        d = as.matrix(task$data()),
        .args = ps$get_values(tags = c("train", "gclust"))
      )
      if (self$save_assignments) {
        self$assignments = invoke(stats::cutree, tree = m, .args = ps$get_values(tags = c("train", "cutree")))
      }
      m
    },

    .predict = function(task) {
      pv = self$param_set$get_values(tags = "predict")
      if (pv$k > task$nrow) {
        error_input("`k` needs to be between 1 and %i.", task$nrow)
      }

      warn_prediction_useless(self$id)
      partition = self$assignments %??%
        invoke(stats::cutree, tree = self$model, .args = self$param_set$get_values(tags = c("train", "cutree")))

      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.genie", LearnerClustGenie)
