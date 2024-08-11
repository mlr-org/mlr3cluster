#' @title K-Means Clustering Learner
#'
#' @name mlr_learners_clust.kmeans
#'
#' @description
#' A [LearnerClust] for k-means clustering implemented in [stats::kmeans()].
#' [stats::kmeans()] doesn't have a default value for the number of clusters.
#' Therefore, the `centers` parameter here is set to 2 by default.
#' The predict method uses [clue::cl_predict()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.kmeans
#' @template learner
#'
#' @references
#' `r format_bib("forgy1965cluster", "hartigan1979algorithm", "lloyd1982least", "macqueen1967some")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustKMeans = R6Class("LearnerClustKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        centers = p_uty(
          tags = c("required", "train"), custom_check = check_centers
        ),
        iter.max = p_int(1L, default = 10L, tags = "train"),
        algorithm = p_fct(
          levels = c("Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"), default = "Hartigan-Wong", tags = "train"
        ),
        nstart = p_int(1L, default = 1L, tags = "train"),
        trace = p_int(0L, default = 0L, tags = "train")
      )

      param_set$set_values(centers = 2L)

      super$initialize(
        id = "clust.kmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = c("stats", "clue"),
        man = "mlr3cluster::mlr_learners_clust.kmeans",
        label = "K-Means"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      if (!is.null(pv$nstart) && !test_int(pv$centers)) {
        warningf("`nstart` parameter is only relevant when `centers` is integer.")
      }

      assert_centers_param(pv$centers, task, test_data_frame, "centers")

      m = invoke(stats::kmeans, x = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = m$cluster
      }
      m
    },

    .predict = function(task) {
      partition = unclass(invoke(cl_predict, self$model, newdata = task$data(), type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.kmeans", LearnerClustKMeans)
