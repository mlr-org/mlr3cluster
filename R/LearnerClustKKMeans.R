#' @title Kernel K-Means Clustering Learner
#'
#' @name mlr_learners_clust.kkmeans
#'
#' @description
#' A [LearnerClust] for kernel k-means clustering implemented in [kernlab::kkmeans()].
#' [kernlab::kkmeans()] doesn't have a default value for the number of clusters.
#' Therefore, the `centers` parameter here is set to 2 by default.
#' Kernel parameters have to be passed directly and not by using the `kpar` list in `kkmeans`.
#' The predict method finds the nearest center in kernel distance to
#' assign clusters for new data points.
#'
#' @templateVar id clust.kkmeans
#' @template learner
#'
#' @references
#' `r format_bib("karatzoglou2004kernlab", "dhillon2004unified")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustKKMeans = R6Class("LearnerClustKKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        centers = p_uty(
          tags = c("required", "train"), custom_check = check_centers
        ),
        kernel = p_fct(
          default = "rbfdot",
          levels = c("vanilladot", "polydot", "rbfdot", "tanhdot", "laplacedot", "besseldot", "anovadot", "splinedot"),
          tags = "train"
        ),
        sigma = p_dbl(
          0, tags = "train", depends = quote(kernel %in% c("rbfdot", "anovadot", "besseldot", "laplacedot"))
        ),
        degree = p_int(
          1L, default = 3L, tags = "train", depends = quote(kernel %in% c("polydot", "anovadot", "besseldot"))
        ),
        scale = p_dbl(0, default = 1, tags = "train", depends = quote(kernel %in% c("polydot", "tanhdot"))),
        offset = p_dbl(default = 1, tags = "train", depends = quote(kernel %in% c("polydot", "tanhdot"))),
        order = p_int(default = 1L, tags = "train", depends = quote(kernel == "besseldot")),
        alg = p_fct(levels = c("kkmeans", "kerninghan"), default = "kkmeans", tags = "train"),
        p = p_dbl(default = 1, tags = "train")
      )

      param_set$set_values(centers = 2L)

      super$initialize(
        id = "clust.kkmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "kernlab",
        man = "mlr3cluster::mlr_learners_clust.kkmeans",
        label = "Kernel K-Means"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      assert_centers_param(pv$centers, task, test_data_frame, "centers")

      m = invoke(kernlab::kkmeans, x = as.matrix(task$data()), .args = pv)
      if (self$save_assignments) {
        self$assignments = m[seq_along(m)]
      }
      m
    },

    .predict = function(task) {
      # all of predict is taken from mlr2

      c = kernlab::centers(self$model)
      K = kernlab::kernelf(self$model)

      # kernel product between each new datapoint and the centers
      d_xc = matrix(kernlab::kernelMatrix(K, as.matrix(task$data()), c), ncol = nrow(c))
      # kernel product between each new datapoint and itself: rows are identical
      d_xx = matrix(
        rep(diag(kernlab::kernelMatrix(K, as.matrix(task$data()))), each = ncol(d_xc)),
        ncol = ncol(d_xc), byrow = TRUE
      )
      # kernel product between each center and itself: columns are identical
      d_cc = matrix(
        rep(diag(kernlab::kernelMatrix(K, as.matrix(c))), each = nrow(d_xc)), nrow = nrow(d_xc)
      )
      # this is the squared kernel distance to the centers
      d2 = d_xx + d_cc - 2 * d_xc
      # the nearest center determines cluster assignment
      partition = apply(d2, 1L, which.min)

      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.kkmeans", LearnerClustKKMeans)
