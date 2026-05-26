#' @title Kernel K-Means Clustering Learner
#'
#' @name mlr_learners_clust.kkmeans
#'
#' @description
#' Kernel k-means clustering.
#' Calls [kernlab::kkmeans()] from package \CRANpkg{kernlab}.
#'
#' The `centers` parameter is set to 2 by default since [kernlab::kkmeans()]
#' doesn't have a default value for the number of clusters.
#' Kernel parameters have to be passed directly and not by using the `kpar` list in [kernlab::kkmeans()].
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
LearnerClustKKMeans = R6Class(
  "LearnerClustKKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        centers = p_uty(tags = c("train", "required"), custom_check = check_centers),
        kernel = p_fct(
          levels = c("rbfdot", "polydot", "vanilladot", "tanhdot", "laplacedot", "besseldot", "anovadot", "splinedot"),
          default = "rbfdot",
          tags = "train"
        ),
        sigma = p_dbl(
          0,
          tags = c("train", "kpar"),
          depends = quote(kernel %in% c("rbfdot", "anovadot", "besseldot", "laplacedot"))
        ),
        degree = p_int(
          1L,
          default = 3L,
          tags = c("train", "kpar"),
          depends = quote(kernel %in% c("polydot", "anovadot", "besseldot"))
        ),
        scale = p_dbl(0, default = 1, tags = c("train", "kpar"), depends = quote(kernel %in% c("polydot", "tanhdot"))),
        offset = p_dbl(default = 1, tags = c("train", "kpar"), depends = quote(kernel %in% c("polydot", "tanhdot"))),
        order = p_int(default = 1L, tags = c("train", "kpar"), depends = quote(kernel == "besseldot")),
        alg = p_fct(c("kkmeans", "kerninghan"), default = "kkmeans", tags = "train"),
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

      kpar = self$param_set$get_values(tags = c("train", "kpar"))
      if (length(kpar) > 0L) {
        pv = remove_named(pv, names(kpar))
        pv$kpar = kpar
      }

      m = invoke(kernlab::kkmeans, x = as.matrix(task$data()), .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m)
      }
      m
    },

    .predict = function(task) {
      centers = kernlab::centers(self$model)
      K = kernlab::kernelf(self$model)
      x = as.matrix(task$data())

      # squared kernel distance: ||phi(x) - phi(c)||^2 = K(x,x) + K(c,c) - 2 K(x,c)
      kxc = kernlab::kernelMatrix(K, x, centers)
      kxx = diag(kernlab::kernelMatrix(K, x))
      kcc = diag(kernlab::kernelMatrix(K, centers))
      d2 = outer(kxx, kcc, `+`) - 2 * kxc
      partition = max.col(-d2, ties.method = "random")

      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.kkmeans", LearnerClustKKMeans)
