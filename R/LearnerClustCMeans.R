#' @title Fuzzy C-Means Clustering Learner
#'
#' @name mlr_learners_clust.cmeans
#'
#' @description
#' A [LearnerClust] for fuzzy clustering implemented in [e1071::cmeans()].
#' [e1071::cmeans()] doesn't have a default value for the number of clusters.
#' Therefore, the `centers` parameter here is set to 2 by default.
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
        centers = p_uty(
          tags = c("required", "train"), custom_check = check_centers
        ),
        iter.max = p_int(1L, default = 100L, tags = "train"),
        verbose = p_lgl(default = FALSE, tags = "train"),
        dist = p_fct(levels = c("euclidean", "manhattan"), default = "euclidean", tags = "train"),
        method = p_fct(levels = c("cmeans", "ufcl"), default = "cmeans", tags = "train"),
        m = p_dbl(1, default = 2, tags = "train"),
        rate.par = p_dbl(0, 1, tags = "train", depends = quote(method == "ufcl")),
        use_weights = p_lgl(default = FALSE, tags = "train"),
        control = p_uty(tags = "train")
      )

      param_set$set_values(centers = 2L)

      super$initialize(
        id = "clust.cmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = param_set,
        properties = c("partitional", "fuzzy", "complete", "weights"),
        packages = "e1071",
        man = "mlr3cluster::mlr_learners_clust.cmeans",
        label = "Fuzzy C-Means Clustering Learner"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      assert_centers_param(pv$centers, task, test_data_frame, "centers")

      if (isTRUE(pv$use_weights)) {
        pv$weights = task$weights_learner$weight
      }

      m = invoke(e1071::cmeans, x = task$data(), .args = pv, .opts = allow_partial_matching)
      if (self$save_assignments) {
        self$assignments = m$cluster
      }
      m
    },

    .predict = function(task) {
      partition = unclass(invoke(cl_predict, self$model, newdata = task$data(), type = "class_ids"))
      prob = unclass(invoke(cl_predict, self$model, newdata = task$data(), type = "memberships"))
      colnames(prob) = seq_len(ncol(prob))

      PredictionClust$new(task = task, partition = partition, prob = prob)
    }
  )
)

#' @include aaa.R
learners[["clust.cmeans"]] = LearnerClustCMeans
