#' @title Spherical K-Means Clustering Learner
#'
#' @name mlr_learners_clust.skmeans
#'
#' @description
#' Spherical k-means clustering for data on the unit hypersphere.
#' Calls [skmeans::skmeans()] from package \CRANpkg{skmeans}.
#'
#' The `k` parameter is set to 2 by default since [skmeans::skmeans()] doesn't have a default value for the number of
#' clusters.
#' Observations are partitioned by maximising cosine similarity to cluster prototypes. Predictions on new data assign
#' each observation to the prototype with the highest cosine similarity. Rows with zero norm are not allowed by
#' [skmeans::skmeans()].
#'
#' @templateVar id clust.skmeans
#' @template learner
#'
#' @references
#' `r format_bib("dhillon2001concept", "hornik2012spherical")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustSKMeans = R6Class(
  "LearnerClustSKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("train", "required")),
        method = p_fct(c("genetic", "pclust", "CLUTO", "gmeans", "kmndirs", "LIH", "LIHC"), tags = "train"),
        m = p_dbl(1, default = 1, tags = "train"),
        weights = p_uty(default = 1, tags = "train"),
        maxiter = p_int(1L, tags = c("train", "control")),
        nruns = p_int(1L, tags = c("train", "control")),
        popsize = p_int(1L, tags = c("train", "control")),
        mutations = p_dbl(0, 1, tags = c("train", "control")),
        reltol = p_dbl(0, tags = c("train", "control")),
        verbose = p_lgl(tags = c("train", "control"))
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.skmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "skmeans",
        man = "mlr3cluster::mlr_learners_clust.skmeans",
        label = "Spherical K-Means"
      )
    }
  ),

  private = list(
    .train = function(task) {
      ps = self$param_set
      pv = ps$get_values(tags = "train")
      pv$control = ps$get_values(tags = "control")
      pv = remove_named(pv, names(pv$control))

      m = invoke(skmeans::skmeans, x = as.matrix(task$data()), .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m$cluster)
      }
      m
    },

    .predict = function(task) {
      d = skmeans::skmeans_xdist(as.matrix(task$data()), self$model$prototypes)
      partition = max.col(-d, ties.method = "first")
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.skmeans", LearnerClustSKMeans)
