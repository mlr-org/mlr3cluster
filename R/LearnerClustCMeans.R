#' @title Fuzzy C-Means Clustering Learner
#'
#' @name mlr_learners_clust.cmeans
#'
#' @description
#' Fuzzy c-means clustering.
#' Calls [e1071::cmeans()] from package \CRANpkg{e1071}.
#'
#' The `centers` parameter is set to 2 by default since [e1071::cmeans()]
#' doesn't have a default value for the number of clusters.
#' The predict method uses [clue::cl_predict()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.cmeans
#' @template learner
#'
#' @references
#' `r format_bib("dimitriadou2008misc", "bezdek2013pattern")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustCMeans = R6Class("LearnerClustCMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        centers = p_uty(tags = c("train", "required"), custom_check = check_centers),
        iter.max = p_int(1L, default = 100L, tags = "train"),
        verbose = p_lgl(default = FALSE, tags = "train"),
        dist = p_fct(c("euclidean", "manhattan"), default = "euclidean", tags = "train"),
        method = p_fct(c("cmeans", "ufcl"), default = "cmeans", tags = "train"),
        m = p_dbl(1, default = 2, tags = "train"),
        rate.par = p_dbl(0, 1, tags = "train", depends = quote(method == "ufcl")),
        weights = p_uty(default = 1L, tags = "train", custom_check = crate(function(x) {
          if (test_numeric(x) && all(x > 0) || check_count(x, positive = TRUE)) {
            TRUE
          } else {
            "`weights` must be positive numeric vector or a single positive number"
          }
        })),
        control = p_uty(tags = "train")
      )

      param_set$set_values(centers = 2L)

      super$initialize(
        id = "clust.cmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = param_set,
        properties = c("partitional", "fuzzy", "complete"),
        packages = c("e1071", "clue"),
        man = "mlr3cluster::mlr_learners_clust.cmeans",
        label = "Fuzzy C-Means"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      assert_centers_param(pv$centers, task, test_data_frame, "centers")

      m = invoke(e1071::cmeans, x = task$data(), .args = pv, .opts = allow_partial_matching)
      if (self$save_assignments) {
        self$assignments = m$cluster
      }
      m
    },

    .predict = function(task) {
      partition = unclass(invoke(clue::cl_predict, self$model, newdata = task$data(), type = "class_ids"))
      prob = NULL
      if (self$predict_type == "prob") {
        prob = unclass(invoke(clue::cl_predict, self$model, newdata = task$data(), type = "memberships"))
        colnames(prob) = seq_len(ncol(prob))
      }
      PredictionClust$new(task = task, partition = partition, prob = prob)
    }
  )
)

#' @include zzz.R
register_learner("clust.cmeans", LearnerClustCMeans)
