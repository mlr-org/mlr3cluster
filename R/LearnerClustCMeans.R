#' @title Fuzzy C-Means Clustering Learner
#'
#' @name mlr_learners_clust.cmeans
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for fuzzy clustering implemented in [e1071::cmeans()].
#' [e1071::cmeans()] doesn't have a default value for the number of clusters.
#' Therefore, the `centers` parameter here is set to 2 by default.
#' The predict method uses [clue::cl_predict()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.cmeans
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustCMeans = R6Class("LearnerClustCMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamUty$new(
            id = "centers", tags = c("required", "train"), default = 2L,
            custom_check = function(x) {
              if (test_data_frame(x)) {
                return(TRUE)
              } else if (test_int(x)) {
                assert_true(x >= 1L)
              } else {
                return("`centers` must be integer or data.frame with initial cluster centers")
              }
            }
          ),
          ParamInt$new(id = "iter.max", lower = 1L, default = 100L, tags = "train"),
          ParamLgl$new(id = "verbose", default = FALSE, tags = "train"),
          ParamFct$new(
            id = "dist", levels = c("euclidean", "manhattan"),
            default = "euclidean", tags = "train"),
          ParamFct$new(
            id = "method", levels = c("cmeans", "ufcl"),
            default = "cmeans", tags = "train"),
          ParamDbl$new(id = "m", lower = 1L, default = 2L, tags = "train"),
          ParamDbl$new(id = "rate.par", lower = 0L, upper = 1L, tags = "train"),
          ParamUty$new(
            id = "weights", default = 1L,
            custom_check = function(x) {
              if (test_numeric(x)) {
                if (sum(sign(x)) == length(x)) {
                  return(TRUE)
                } else {
                  return("`weights` must contain only positive numbers")
                }
              } else if (test_count(x)) {
                return(TRUE)
              } else {
                return("`weights` must be positive numeric vector or a single positive number")
              }
            },
            tags = "train"),
          ParamUty$new(id = "control", tags = "train")
        )
      )
      # add deps
      ps$add_dep("rate.par", "method", CondEqual$new("ufcl"))

      ps$values = list(centers = 2L)

      super$initialize(
        id = "clust.cmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = c("partition", "prob"),
        param_set = ps,
        properties = c("partitional", "fuzzy", "complete"),
        packages = "e1071"
      )
    }
  ),

  private = list(
    .train = function(task) {
      check_centers_param(self$param_set$values$centers, task, test_data_frame, "centers")

      pv = self$param_set$get_values(tags = "train")
      invoke(e1071::cmeans, x = task$data(), .args = pv, .opts = allow_partial_matching)
    },

    .predict = function(task) {
      partition = unclass(cl_predict(self$model, newdata = task$data(), type = "class_ids"))
      prob = unclass(cl_predict(self$model, newdata = task$data(), type = "memberships"))
      colnames(prob) = seq_len(ncol(prob))

      PredictionClust$new(task = task, partition = partition, prob = prob)
    }
  )
)
