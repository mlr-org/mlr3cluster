#' @title Robust Trimmed Clustering Learner
#'
#' @name mlr_learners_clust.tclust
#'
#' @description
#' Robust trimmed clustering. Each cluster is modeled by a multivariate Gaussian; the most
#' outlying `alpha` fraction of observations is trimmed and labeled with cluster `0` in the returned partition.
#' Calls [tclust::tclust()] from package \CRANpkg{tclust}.
#'
#' The `k` parameter is set to 2 by default since [tclust::tclust()] doesn't have a default value for the number of
#' clusters. There is no predict method for [tclust::tclust()], so the method returns cluster labels for the training
#' data.
#'
#' @section Initial parameter values:
#' - `store_x`:
#'   - Actual default: `TRUE`.
#'   - Adjusted default: `FALSE`.
#'   - Reason for change: Avoid storing the training data in the model to save memory.
#'
#' @templateVar id clust.tclust
#' @template learner
#'
#' @references
#' `r format_bib("garcia2008general", "fritz2012tclust")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustTclust = R6Class(
  "LearnerClustTclust",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("train", "required")),
        alpha = p_dbl(0, 0.5, default = 0.05, tags = "train"),
        nstart = p_int(1L, default = 500L, tags = "train"),
        niter1 = p_int(1L, default = 3L, tags = "train"),
        niter2 = p_int(1L, default = 20L, tags = "train"),
        nkeep = p_int(1L, default = 5L, tags = "train"),
        iter.max = p_int(1L, tags = "train"),
        equal.weights = p_lgl(default = FALSE, tags = "train"),
        restr = p_fct(c("eigen", "deter"), default = "eigen", tags = "train"),
        restr.fact = p_dbl(1, default = 12, tags = "train"),
        cshape = p_dbl(1, default = 1e10, tags = "train"),
        opt = p_fct(c("HARD", "MIXT"), default = "HARD", tags = "train"),
        center = p_lgl(default = FALSE, tags = "train"),
        scale = p_lgl(default = FALSE, tags = "train"),
        store_x = p_lgl(default = TRUE, tags = "train"),
        parallel = p_lgl(default = FALSE, tags = "train"),
        n.cores = p_int(default = -1L, tags = "train", depends = quote(parallel == TRUE)),
        zero_tol = p_dbl(0, default = 1e-16, tags = "train"),
        drop.empty.clust = p_lgl(default = TRUE, tags = "train"),
        trace = p_int(0L, default = 0L, tags = "train")
      )

      param_set$set_values(k = 2L, store_x = FALSE)

      super$initialize(
        id = "clust.tclust",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "partial"),
        packages = "tclust",
        man = "mlr3cluster::mlr_learners_clust.tclust",
        label = "Robust Trimmed Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(tclust::tclust, x = as.matrix(task$data()), .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m$cluster)
      }
      m
    },

    .predict = function(task) {
      warn_prediction_useless(self$id)
      partition = self$assignments %??% as.integer(self$model$cluster)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.tclust", LearnerClustTclust)
