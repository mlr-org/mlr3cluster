#' @title Prototype Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.protoclust
#'
#' @description
#' Hierarchical clustering using minimax linkage with prototypes.
#' Calls [protoclust::protoclust()] from package \CRANpkg{protoclust}.
#'
#' @templateVar id clust.protoclust
#' @template learner
#'
#' @references
#' `r format_bib("bien2011hierarchical")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustProtoclust = R6Class(
  "LearnerClustProtoclust",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        method = p_fct(
          levels = c("euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski"),
          default = "euclidean",
          tags = c("train", "dist")
        ),
        diag = p_lgl(default = FALSE, tags = c("train", "dist")),
        upper = p_lgl(default = FALSE, tags = c("train", "dist")),
        p = p_dbl(default = 2, tags = c("train", "dist"), depends = quote(method == "minkowski")),
        verb = p_lgl(default = FALSE, tags = c("train", "protoclust")),
        k = p_int(1L, default = NULL, special_vals = list(NULL), tags = c("train", "protocut", "predict"))
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.protoclust",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "protoclust",
        man = "mlr3cluster::mlr_learners_clust.protoclust",
        label = "Prototype Hierarchical Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      ps = self$param_set
      d = invoke(stats::dist, x = task$data(), .args = ps$get_values(tags = c("train", "dist")))
      m = invoke(protoclust::protoclust, d = d, .args = ps$get_values(tags = c("train", "protoclust")))
      if (self$save_assignments) {
        self$assignments = invoke(
          protoclust::protocut,
          hc = m,
          .args = ps$get_values(tags = c("train", "protocut"))
        )$cl
      }
      m
    },

    .predict = function(task) {
      pv = self$param_set$get_values(tags = "predict")
      if (pv$k > task$nrow) {
        error_input("`k` needs to be between 1 and %i.", task$nrow)
      }

      warn_prediction_useless(self$id)

      PredictionClust$new(task = task, partition = self$assignments)
    }
  )
)

#' @include zzz.R
register_learner("clust.protoclust", LearnerClustProtoclust)
