#' @title Kernel K-Means Clustering Learner
#'
#' @name mlr_learners_clust.kkmeans
#' @include LearnerClust.R
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
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustKKMeans = R6Class("LearnerClustKKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamUty$new(
            id = "centers", tags = c("required", "train"), default = 2L,
            custom_check = function(x) {
              if (test_data_frame(x)) {
                return(TRUE)
              } else if (test_int(x)) {
                assert_true(x >= 1L)
              } else {
                return("`centers` must be integer or data.frame with initial cluster centers")
              }
            }
          ),
          ParamFct$new(
            id = "kernel", default = "rbfdot",
            levels = c(
              "vanilladot", "polydot", "rbfdot", "tanhdot",
              "laplacedot", "besseldot", "anovadot", "splinedot"),
            tags = "train"),
          ParamDbl$new(id = "sigma", lower = 0, tags = "train"),
          ParamInt$new(id = "degree", default = 3L, lower = 1L, tags = "train"),
          ParamDbl$new(id = "scale", default = 1, lower = 0, tags = "train"),
          ParamDbl$new(id = "offset", default = 1, tags = "train"),
          ParamInt$new(id = "order", default = 1L, tags = "train"),
          ParamFct$new(
            id = "alg", levels = c("kkmeans", "kerninghan"),
            default = "kkmeans", tags = "train"),
          ParamDbl$new(id = "p", default = 1, tags = "train")
        )
      )
      ps$values = list(centers = 2L)

      # add deps
      ps$add_dep(
        "sigma", "kernel",
        CondAnyOf$new(c("rbfdot", "anovadot", "besseldot", "laplacedot")))
      ps$add_dep("degree", "kernel", CondAnyOf$new(c("polydot", "anovadot", "besseldot")))
      ps$add_dep("scale", "kernel", CondAnyOf$new(c("polydot", "tanhdot")))
      ps$add_dep("offset", "kernel", CondAnyOf$new(c("polydot", "tanhdot")))
      ps$add_dep("order", "kernel", CondEqual$new("besseldot"))

      super$initialize(
        id = "clust.kkmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("partitional", "exclusive", "complete"),
        packages = c("kernlab")
      )
    }
  ),
  private = list(
    .train = function(task) {
      check_centers_param(self$param_set$values$centers, task, test_data_frame, "centers")

      pv = self$param_set$get_values(tags = "train")
      m = invoke(kernlab::kkmeans, x = as.matrix(task$data()), .args = pv)
      self$assignments = m[seq_len(length(m))]
      return(m)
    },
    .predict = function(task) {
      # all of predict is taken from mlr2

      c = kernlab::centers(self$model)
      K = kernlab::kernelf(self$model)

      # kernel product between each new datapoint and the centers
      d_xc = matrix(kernlab::kernelMatrix(K, as.matrix(task$data()), c), ncol = nrow(c))
      # kernel product between each new datapoint and itself: rows are identical
      d_xx = matrix(rep(diag(kernlab::kernelMatrix(K, as.matrix(task$data()))),
                        each = ncol(d_xc)), ncol = ncol(d_xc), byrow = TRUE)
      # kernel product between each center and itself: columns are identical
      d_cc = matrix(rep(diag(kernlab::kernelMatrix(K, as.matrix(c))),
                        each = nrow(d_xc)), nrow = nrow(d_xc))
      # this is the squared kernel distance to the centers
      d2 = d_xx + d_cc - 2 * d_xc
      # the nearest center determines cluster assignment
      partition = apply(d2, 1, function(x) which.min(x))

      PredictionClust$new(task = task, partition = partition)
    }
  )
)
