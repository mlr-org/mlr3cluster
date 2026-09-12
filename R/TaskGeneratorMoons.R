#' @title Moons Cluster Task Generator
#'
#' @name mlr_task_generators_moons
#' @include zzz.R
#'
#' @description
#' A [TaskGenerator][mlr3::TaskGenerator] for two interleaving half circles ("moons"), in the spirit of
#' `sklearn.datasets.make_moons()`.
#' The `n` observations are split evenly between an upper half circle centered at the origin and a lower half circle
#' shifted to the right and down so that the two arcs interleave.
#' Each observation is perturbed with Gaussian noise of standard deviation `sd`.
#' The generated [TaskClust] only contains the numeric features `x1` and `x2`; the cluster membership is not
#' stored in the task.
#' The parameter `sd` is initialized to `0.1`.
#'
#' The clusters are not convex, which makes this generator a standard test case for density-based and
#' connectivity-based methods such as DBSCAN, single linkage or spectral clustering, where centroid-based methods
#' such as k-means fail.
#'
#' @templateVar id moons
#' @template task_generator
#'
#' @template seealso_task_generator
#' @export
#' @examples
#' generator = tgen("moons")
#' plot(generator, n = 200)
#'
#' task = generator$generate(200)
#' str(task$data())
TaskGeneratorMoons = R6Class(
  "TaskGeneratorMoons",
  inherit = TaskGenerator,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(sd = p_dbl(0, tags = "required"))
      param_set$set_values(sd = 0.1)

      super$initialize(
        id = "moons",
        task_type = "clust",
        param_set = param_set,
        label = "Moons Clustering",
        man = "mlr3cluster::mlr_task_generators_moons"
      )
    },

    #' @description
    #' Creates a simple plot of generated data, colored by cluster membership.
    #' @param n (`integer(1)`)\cr
    #'   Number of samples to draw for the plot. Default is `200`.
    #' @param pch (`integer(1)`)\cr
    #'   Point char. Passed to [graphics::plot()].
    #' @param ... (any)\cr
    #'   Additional arguments passed to [graphics::plot()].
    plot = function(n = 200L, pch = 19L, ...) {
      obj = private$.generate_obj(n)
      plot(obj$x[, 1L], obj$x[, 2L], col = obj$classes, pch = pch, xlab = "x1", ylab = "x2", ...)
    }
  ),

  private = list(
    .generate_obj = function(n) {
      sd = self$param_set$get_values()$sd

      classes = rep_len(1:2, n)
      theta = runif(n, 0, pi)
      outer = classes == 1L
      x1 = fifelse(outer, cos(theta), 1 - cos(theta))
      x2 = fifelse(outer, sin(theta), 0.5 - sin(theta))
      x = cbind(x1 = x1 + rnorm(n, sd = sd), x2 = x2 + rnorm(n, sd = sd))

      list(x = x, classes = factor(classes, levels = 1:2))
    },

    .generate = function(n) {
      obj = private$.generate_obj(n)
      TaskClust$new(sprintf("%s_%i", self$id, n), backend = as.data.table(obj$x))
    }
  )
)

register_task_generator("moons", TaskGeneratorMoons)
