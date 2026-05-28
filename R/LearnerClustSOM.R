#' @title Self-Organizing Maps Clustering Learner
#'
#' @name mlr_learners_clust.som
#'
#' @description
#' Self-organizing map (Kohonen network) clustering.
#' Calls [kohonen::som()] from package \CRANpkg{kohonen}.
#'
#' Each map unit corresponds to a cluster, so the number of clusters is `xdim * ydim`. Grid dimensions, topology, and
#' neighbourhood function are exposed directly as parameters and forwarded to [kohonen::somgrid()]. The predict method
#' uses [kohonen::predict.kohonen()] to assign new data to the closest unit.
#'
#' @templateVar id clust.som
#' @template learner
#'
#' @references
#' `r format_bib("kohonen1990self", "wehrens2018kohonen")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustSOM = R6Class(
  "LearnerClustSOM",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        xdim = p_int(1L, default = 8L, tags = c("train", "grid")),
        ydim = p_int(1L, default = 6L, tags = c("train", "grid")),
        topo = p_fct(c("rectangular", "hexagonal"), default = "rectangular", tags = c("train", "grid")),
        neighbourhood.fct = p_fct(c("bubble", "gaussian"), default = "bubble", tags = c("train", "grid")),
        toroidal = p_lgl(default = FALSE, tags = c("train", "grid")),
        rlen = p_int(1L, default = 100L, tags = "train"),
        alpha = p_uty(
          default = c(0.05, 0.01),
          tags = "train",
          custom_check = crate(function(x) check_numeric(x, len = 2L, lower = 0, upper = 1, any.missing = FALSE))
        ),
        radius = p_uty(tags = "train", custom_check = check_numeric),
        user.weights = p_uty(default = 1, tags = "train", custom_check = check_numeric),
        maxNA.fraction = p_dbl(0, 1, default = 0, tags = "train"),
        keep.data = p_lgl(default = TRUE, tags = "train"),
        dist.fcts = p_uty(default = NULL, tags = "train"),
        mode = p_fct(c("online", "batch", "pbatch"), default = "online", tags = "train"),
        cores = p_int(default = -1L, tags = "train"),
        init = p_uty(tags = "train"),
        normalizeDataLayers = p_lgl(default = TRUE, tags = "train")
      )

      super$initialize(
        id = "clust.som",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "kohonen",
        man = "mlr3cluster::mlr_learners_clust.som",
        label = "Self-Organizing Maps"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      grid_args = self$param_set$get_values(tags = "grid")
      pv = remove_named(pv, names(grid_args))
      pv$grid = invoke(kohonen::somgrid, .args = grid_args)

      m = invoke(kohonen::som, X = as.matrix(task$data()), .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m$unit.classif)
      }
      m
    },

    .predict = function(task) {
      p = invoke(predict, self$model, newdata = as.matrix(task$data()))
      PredictionClust$new(task = task, partition = as.integer(p$unit.classif))
    }
  )
)

#' @include zzz.R
register_learner("clust.som", LearnerClustSOM)
