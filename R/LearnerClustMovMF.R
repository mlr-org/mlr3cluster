#' @title von Mises-Fisher Mixture Clustering Learner
#'
#' @name mlr_learners_clust.movMF
#'
#' @description
#' Fits a mixture of von Mises-Fisher distributions via EM, the directional-data analogue of a Gaussian mixture for
#' points on the unit hypersphere.
#' Calls [movMF::movMF()] from package \CRANpkg{movMF}.
#'
#' The `k` parameter is set to 2 by default since [movMF::movMF()] has no default value for the number of mixture
#' components. Rows of `x` are standardised to unit length internally by [movMF::movMF()]. Predictions use the
#' `predict()` method from \pkg{movMF}; `prob` returns the soft memberships.
#'
#' Setting `ids` initializes the EM algorithm from fixed component memberships and stops it after a single iteration,
#' in which case [movMF::movMF()] ignores `start` and `nruns`.
#'
#' @templateVar id clust.movMF
#' @template learner
#'
#' @references
#' `r format_bib("banerjee2005clustering", "hornik2014movmf")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustMovMF = R6Class(
  "LearnerClustMovMF",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("train", "required")),
        E = p_fct(c("softmax", "hardmax", "stochmax"), default = "softmax", tags = "train"),
        kappa = p_uty(tags = "train"),
        ids = p_uty(
          tags = "train",
          custom_check = crate(function(x) check_integerish(x, lower = 1L, any.missing = FALSE))
        ),
        start = p_uty(default = "p", tags = "train"),
        nruns = p_int(1L, default = 1L, tags = c("train", "control")),
        maxiter = p_int(1L, default = 100L, tags = c("train", "control")),
        reltol = p_dbl(0, tags = c("train", "control")),
        minalpha = p_dbl(0, default = 0, tags = c("train", "control")),
        converge = p_lgl(tags = c("train", "control")),
        verbose = p_lgl(default = FALSE, tags = c("train", "control"))
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.movMF",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = param_set,
        properties = c("partitional", "fuzzy", "complete"),
        packages = "movMF",
        man = "mlr3cluster::mlr_learners_clust.movMF",
        label = "von Mises-Fisher Mixture"
      )
    }
  ),

  private = list(
    .train = function(task) {
      ps = self$param_set
      pv = ps$get_values(tags = "train")
      pv$control = ps$get_values(tags = "control")
      pv = remove_named(pv, names(pv$control))

      data = as.matrix(task$data())
      m = invoke(movMF::movMF, x = data, .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(invoke(predict, m, newdata = data, type = "class_ids"))
      }
      m
    },

    .predict = function(task) {
      newdata = as.matrix(ordered_features(task, self))
      partition = as.integer(invoke(predict, self$model, newdata = newdata, type = "class_ids"))
      prob = NULL
      if (self$predict_type == "prob") {
        prob = invoke(predict, self$model, newdata = newdata, type = "memberships")
        colnames(prob) = seq_col(prob)
      }
      list(partition = partition, prob = prob)
    }
  )
)

#' @include zzz.R
register_learner("clust.movMF", LearnerClustMovMF)
