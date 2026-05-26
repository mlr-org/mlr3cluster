#' @title Finite Mixture Model Clustering Learner
#'
#' @name mlr_learners_clust.flexmix
#'
#' @description
#' Finite mixture model clustering via the EM algorithm.
#' Calls [flexmix::flexmix()] from package \CRANpkg{flexmix}.
#'
#' The component model is selected through the `model` parameter, exposing the multivariate normal, univariate normal,
#' multivariate binary, and multivariate Poisson drivers shipped with flexmix.
#' The predict method calls `flexmix::clusters()` for cluster assignments and `flexmix::posterior()` for component
#' probabilities on new data.
#'
#' Note that EM can prune components whose prior falls below `minprior` during fitting, so the final number of
#' components may be smaller than `k`.
#'
#' @templateVar id clust.flexmix
#' @template learner
#'
#' @references
#' `r format_bib("leisch2004flexmix", "gruen2008flexmix")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustFlexmix = R6Class(
  "LearnerClustFlexmix",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("train", "required")),
        model = p_fct(
          c("FLXMCmvnorm", "FLXMCnorm1", "FLXMCmvbinary", "FLXMCmvpois"),
          default = "FLXMCmvnorm",
          tags = "train"
        ),
        diagonal = p_lgl(default = TRUE, tags = "train", depends = quote(model == "FLXMCmvnorm")),
        truncated = p_lgl(default = FALSE, tags = "train", depends = quote(model == "FLXMCmvbinary")),
        cluster = p_uty(tags = "train", custom_check = check_numeric),
        iter.max = p_int(1L, default = 200L, tags = c("train", "control")),
        minprior = p_dbl(0, 1, default = 0.05, tags = c("train", "control")),
        tolerance = p_dbl(0, default = 1e-6, tags = c("train", "control")),
        verbose = p_int(0L, default = 0L, tags = c("train", "control")),
        classify = p_fct(
          c("auto", "weighted", "CEM", "SEM", "hard", "random"),
          default = "auto",
          tags = c("train", "control")
        ),
        nrep = p_int(1L, default = 1L, tags = c("train", "control"))
      )

      param_set$set_values(k = 2L, model = "FLXMCmvnorm")

      super$initialize(
        id = "clust.flexmix",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = param_set,
        properties = c("partitional", "fuzzy", "exclusive", "complete"),
        packages = "flexmix",
        man = "mlr3cluster::mlr_learners_clust.flexmix",
        label = "Finite Mixture Model"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      ctrl_pv = self$param_set$get_values(tags = "control")
      pv = remove_named(pv, names(ctrl_pv))

      model_name = pv$model %??% "FLXMCmvnorm"
      driver_args = list()
      if (model_name == "FLXMCmvnorm" && !is.null(pv$diagonal)) {
        driver_args$diagonal = pv$diagonal
      }
      if (model_name == "FLXMCmvbinary" && !is.null(pv$truncated)) {
        driver_args$truncated = pv$truncated
      }
      pv = remove_named(pv, c("model", "diagonal", "truncated"))
      driver = do.call(getExportedValue("flexmix", model_name), driver_args)

      control = do.call(methods::new, c(list("FLXcontrol"), ctrl_pv))

      data = setDF(task$data())
      # multivariate LHS via cbind() so that posterior() can rebuild the design matrix from newdata
      lhs = sprintf("cbind(%s)", paste0("`", colnames(data), "`", collapse = ", "))
      formula = formulate(lhs = lhs, rhs = "1")
      m = invoke(
        flexmix::flexmix,
        formula = formula,
        data = data,
        model = driver,
        control = control,
        .args = pv
      )
      if (self$save_assignments) {
        self$assignments = as.integer(flexmix::clusters(m))
      }
      m
    },

    .predict = function(task) {
      data = setDF(task$data())
      partition = as.integer(flexmix::clusters(self$model, newdata = data))
      prob = NULL
      if (self$predict_type == "prob") {
        prob = flexmix::posterior(self$model, newdata = data)
        colnames(prob) = seq_col(prob)
      }
      PredictionClust$new(task = task, partition = partition, prob = prob)
    }
  )
)

#' @include zzz.R
register_learner("clust.flexmix", LearnerClustFlexmix)
