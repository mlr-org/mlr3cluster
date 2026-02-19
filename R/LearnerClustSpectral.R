#' @title Spectral Clustering Learner
#'
#' @name mlr_learners_clust.specc
#'
#' @description
#' Spectral clustering.
#' Calls [kernlab::specc()] from package \CRANpkg{kernlab}.
#'
#' The `centers` parameter is set to 2 by default since [kernlab::specc()]
#' doesn't have a default value for the number of clusters.
#' Kernel parameters have to be passed directly and not by using the `kpar` list in [kernlab::specc()].
#'
#' There is no predict method for [kernlab::specc()], so the method
#' returns cluster labels for the training data.
#'
#' @templateVar id clust.specc
#' @template learner
#'
#' @references
#' `r format_bib("karatzoglou2004kernlab", "ng2001spectral")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustSpectral = R6Class("LearnerClustSpectral",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        centers = p_int(1L, tags = c("train", "required")),
        kernel = p_fct(
          levels = c("rbfdot", "polydot", "vanilladot", "tanhdot", "laplacedot", "besseldot", "anovadot", "splinedot"),
          default = "rbfdot",
          tags = "train"
        ),
        sigma = p_dbl(
          0, tags = c("train", "kpar"), depends = quote(kernel %in% c("rbfdot", "anovadot", "besseldot", "laplacedot"))
        ),
        degree = p_int(
          1L, default = 3L, tags = c("train", "kpar"),
          depends = quote(kernel %in% c("polydot", "anovadot", "besseldot"))
        ),
        scale = p_dbl(0, default = 1, tags = c("train", "kpar"), depends = quote(kernel %in% c("polydot", "tanhdot"))),
        offset = p_dbl(default = 1, tags = c("train", "kpar"), depends = quote(kernel %in% c("polydot", "tanhdot"))),
        order = p_int(default = 1L, tags = c("train", "kpar"), depends = quote(kernel == "besseldot")),
        nystrom.red = p_lgl(default = FALSE, tags = "train"),
        nystrom.sample = p_int(1L, tags = "train", depends = quote(nystrom.red == TRUE)),
        iterations = p_int(1L, default = 200L, tags = "train"),
        mod.sample = p_dbl(0, 1, default = 0.75, tags = "train")
      )

      param_set$set_values(centers = 2L)

      super$initialize(
        id = "clust.specc",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "kernlab",
        man = "mlr3cluster::mlr_learners_clust.specc",
        label = "Spectral Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")

      kpar = self$param_set$get_values(tags = c("train", "kpar"))
      if (length(kpar) > 0L) {
        pv = remove_named(pv, names(kpar))
        pv$kpar = kpar
      }

      m = invoke(kernlab::specc, x = as.matrix(task$data()), .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m)
      }
      m
    },

    .predict = function(task) {
      warn_prediction_useless(self$id)
      partition = as.integer(self$model)
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.specc", LearnerClustSpectral)
