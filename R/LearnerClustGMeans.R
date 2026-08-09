#' @title G-Means Clustering Learner
#'
#' @name mlr_learners_clust.gmeans
#'
#' @description
#' G-means clustering.
#' Calls [gmeans::gmeans()] from package \CRANpkg{gmeans}.
#'
#' G-means extends k-means by automatically determining the number of clusters: starting from `k_init` centers, each
#' cluster is repeatedly split in two unless an Anderson-Darling test suggests its points already follow a Gaussian
#' distribution, until no more centers are added or `k_max` is reached. The predict method assigns new observations to
#' the nearest cluster center.
#'
#' @templateVar id clust.gmeans
#' @template learner
#'
#' @references
#' `r format_bib("hamerly2003learning")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustGMeans = R6Class(
  "LearnerClustGMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k_init = p_int(1L, default = 2L, tags = "train"),
        k_max = p_int(1L, default = 10L, tags = "train"),
        level = p_dbl(0, 1, default = 0.05, tags = "train"),
        iter.max = p_int(1L, default = 10L, tags = "train"),
        algorithm = p_fct(
          c("Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"),
          default = "Hartigan-Wong",
          tags = "train"
        ),
        trace = p_lgl(default = FALSE, tags = "train"),
        method = p_fct(c("euclidean", "manhattan", "minkowski"), default = "euclidean", tags = "predict"),
        p = p_dbl(default = 2, tags = "predict", depends = quote(method == "minkowski"))
      )

      super$initialize(
        id = "clust.gmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "gmeans",
        man = "mlr3cluster::mlr_learners_clust.gmeans",
        label = "G-Means"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(gmeans::gmeans, x = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m$cluster)
      }
      m
    },

    .predict = function(task) {
      pv = self$param_set$get_values(tags = "predict")
      data = as.matrix(ordered_features(task, self))
      partition = as.integer(invoke(predict, self$model, newdata = data, .args = pv))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.gmeans", LearnerClustGMeans)
