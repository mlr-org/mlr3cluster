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
#' @template example
#'
#' @export
LearnerClustKKMeans = R6Class("LearnerClustKKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        centers = p_uty(
          tags = c("required", "train"), default = 2L, custom_check = check_centers
        ),
        kernel = p_fct(
          default = "rbfdot",
          levels = c("vanilladot", "polydot", "rbfdot", "tanhdot", "laplacedot", "besseldot", "anovadot", "splinedot"),
          tags = "train"
        ),
        sigma = p_dbl(0, tags = "train"),
        degree = p_int(1L, default = 3L, tags = "train"),
        scale = p_dbl(0, default = 1, tags = "train"),
        offset = p_dbl(default = 1, tags = "train"),
        order = p_int(default = 1L, tags = "train"),
        alg = p_fct(levels = c("kkmeans", "kerninghan"), default = "kkmeans", tags = "train"),
        p = p_dbl(default = 1, tags = "train")
      )
      param_set$set_values(centers = 2L)

      # add deps
      param_set$add_dep("sigma", "kernel", CondAnyOf$new(c("rbfdot", "anovadot", "besseldot", "laplacedot")))
      param_set$add_dep("degree", "kernel", CondAnyOf$new(c("polydot", "anovadot", "besseldot")))
      param_set$add_dep("scale", "kernel", CondAnyOf$new(c("polydot", "tanhdot")))
      param_set$add_dep("offset", "kernel", CondAnyOf$new(c("polydot", "tanhdot")))
      param_set$add_dep("order", "kernel", CondEqual$new("besseldot"))

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
      check_centers_param(self$param_set$values$centers, task, test_data_frame, "centers")

      pv = self$param_set$get_values(tags = "train")
      m = invoke(kernlab::kkmeans, x = as.matrix(task$data()), .args = pv)
      if (self$save_assignments) {
        self$assignments = m[seq_along(m)]
      }
      return(m)
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

#' @include aaa.R
learners[["clust.kkmeans"]] = LearnerClustKKMeans
