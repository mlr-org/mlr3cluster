#' @title Gaussian Blobs Cluster Task Generator
#'
#' @name mlr_task_generators_blobs
#' @include zzz.R
#'
#' @description
#' A [TaskGenerator][mlr3::TaskGenerator] for isotropic Gaussian blobs, in the spirit of
#' `sklearn.datasets.make_blobs()`.
#' `k` cluster centers are drawn uniformly from the hypercube `[-center_box, center_box]^d`, and the `n`
#' observations are assigned to the centers in a balanced fashion and perturbed with Gaussian noise of standard
#' deviation `sd` in each of the `d` dimensions.
#' The generated [TaskClust] only contains the numeric features `x1`, ..., `xd`; the cluster membership is not
#' stored in the task.
#'
#' @templateVar id blobs
#' @template task_generator
#'
#' @template seealso_task_generator
#' @export
#' @examples
#' generator = tgen("blobs")
#' plot(generator, n = 200)
#'
#' task = generator$generate(200)
#' str(task$data())
#'
#' # 4 well separated clusters in 3 dimensions
#' generator = tgen("blobs", k = 4, d = 3, sd = 0.5)
#' task = generator$generate(500)
#' task
TaskGeneratorBlobs = R6Class(
  "TaskGeneratorBlobs",
  inherit = TaskGenerator,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, default = 3L),
        d = p_int(1L, default = 2L),
        sd = p_dbl(0, default = 1),
        center_box = p_dbl(0, default = 10)
      )

      super$initialize(
        id = "blobs",
        task_type = "clust",
        param_set = param_set,
        label = "Gaussian Blobs Clustering",
        man = "mlr3cluster::mlr_task_generators_blobs"
      )
    },

    #' @description
    #' Creates a simple plot of the first two features of generated data, colored by cluster membership.
    #' @param n (`integer(1)`)\cr
    #'   Number of samples to draw for the plot. Default is 200.
    #' @param pch (`integer(1)`)\cr
    #'   Point char. Passed to [graphics::plot()].
    #' @param ... (any)\cr
    #'   Additional arguments passed to [graphics::plot()].
    plot = function(n = 200L, pch = 19L, ...) {
      obj = private$.generate_obj(n)
      if (ncol(obj$x) < 2L) {
        stopf("Plotting requires at least 2 dimensions, but 'd' is %i", ncol(obj$x))
      }
      plot(obj$x[, 1L], obj$x[, 2L], col = obj$classes, pch = pch, xlab = "x1", ylab = "x2", ...)
    }
  ),

  private = list(
    .generate_obj = function(n) {
      pv = self$param_set$values
      k = pv$k %??% 3L
      d = pv$d %??% 2L
      sd = pv$sd %??% 1
      center_box = pv$center_box %??% 10

      classes = rep_len(seq_len(k), n)
      centers = matrix(runif(k * d, min = -center_box, max = center_box), nrow = k, ncol = d)
      x = centers[classes, , drop = FALSE] + matrix(rnorm(n * d, sd = sd), nrow = n, ncol = d)
      colnames(x) = sprintf("x%i", seq_len(d))

      list(x = x, classes = factor(classes, levels = seq_len(k)))
    },

    .generate = function(n) {
      obj = private$.generate_obj(n)
      TaskClust$new(sprintf("%s_%i", self$id, n), backend = as.data.table(obj$x))
    }
  )
)

register_task_generator("blobs", TaskGeneratorBlobs)
