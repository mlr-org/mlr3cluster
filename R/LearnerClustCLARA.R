#' @title CLARA Clustering Learner
#'
#' @name mlr_learners_clust.clara
#'
#' @description
#' Clustering Large Applications (CLARA) clustering.
#' Calls [cluster::clara()] from package \CRANpkg{cluster}.
#'
#' CLARA extends the PAM algorithm to handle larger datasets by working on sub-datasets of fixed size.
#' The `k` parameter is set to 2 by default since [cluster::clara()]
#' doesn't have a default value for the number of clusters.
#' The predict method uses [clue::cl_predict()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.clara
#' @template learner
#'
#' @references
#' `r format_bib("kaufman2009finding", "schubert2019faster")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustCLARA = R6Class(
  "LearnerClustCLARA",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("train", "required")),
        metric = p_fct(c("euclidean", "manhattan", "jaccard"), default = "euclidean", tags = "train"),
        stand = p_lgl(default = FALSE, tags = "train"),
        samples = p_int(1L, default = 5L, tags = "train"),
        sampsize = p_int(1L, tags = "train"),
        trace = p_int(0L, default = 0L, tags = "train"),
        medoids.x = p_lgl(default = TRUE, tags = "train"),
        keep.data = p_lgl(default = TRUE, tags = "train"),
        rngR = p_lgl(default = FALSE, tags = "train"),
        pamLike = p_lgl(default = FALSE, tags = "train"),
        correct.d = p_lgl(default = TRUE, tags = "train")
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.clara",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = c("cluster", "clue"),
        man = "mlr3cluster::mlr_learners_clust.clara",
        label = "CLARA"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(cluster::clara, x = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = m$clustering
      }
      m
    },

    .predict = function(task) {
      partition = unclass(invoke(clue::cl_predict, self$model, newdata = task$data(), type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.clara", LearnerClustCLARA)
