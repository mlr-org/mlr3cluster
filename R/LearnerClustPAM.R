#' @title Partitioning Around Medoids Cluster Learner
#'
#' @name mlr_learners_clust.pam
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for PAM clustering implemented in [cluster::pam()].
#' The default number of clusters has been initialized to 2.
#' Predictions are generated using [clue::cl_predict()].
#'
#' @templateVar id clust.pam
#' @template section_dictionary_learner
#'
#' @export
LearnerClustPAM = R6Class("LearnerClustPAM",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamInt$new("k", lower = 1L, default = 2L, tags = c("required", "train")),
          ParamFct$new("metric", levels = c("euclidian", "manhattan"), tags = "train"),
          ParamUty$new("medoids",
            default = NULL, tags = "train",
            custom_check = function(x) {
              if (test_integerish(x)) {
                return(TRUE)
              } else if (test_null(x)) {
                return(TRUE)
              } else {
                stop("`medoids` needs to be either `NULL` or vector with row indices!")
              }
            }
          ),
          ParamLgl$new("stand", default = FALSE, tags = "train"),
          ParamLgl$new("do.swap", default = TRUE, tags = "train"),
          ParamInt$new("pamonce", lower = 0L, upper = 5L, default = 0, tags = "train"),
          ParamInt$new("trace.lev", lower = 0L, default = 0L, tags = "train")
        )
      )
      ps$values = list(
        k = 2L, stand = FALSE, do.swap = TRUE, pamonce = 0L, medoids = NULL,
        trace.lev = 0L
      )

      super$initialize(
        id = "clust.pam",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("partitional", "exclusive", "complete"),
        packages = "cluster"
      )
    }
  ),
  private = list(
    .train = function(task) {
      if (!is.null(self$param_set$values$medoids)) {
        if (test_true(length(self$param_set$values$medoids) != self$param_set$values$k)) {
          stop("number of `medoids`' needs to match `k`!")
        } else {
          r = unname(lapply(self$param_set$values$medoids, function(i) {
            test_true(i <= task$nrow) && test_true(i >= 1)
          }))
          if (test_true(sum(unlist(r)) != self$param_set$values$k)) {
            msg = sprintf("`medoids` need to contain valid indices from 1")
            msg = sprintf("%s to %s (number of observations)!", msg, self$param_set$values$k)
            stop(msg)
          }
        }
      }

      pv = self$param_set$get_values(tags = "train")
      invoke(cluster::pam, x = task$data(), diss = FALSE, .args = pv)
    },
    .predict = function(task) {
      partition = unclass(cl_predict(self$model, newdata = task$data(), type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
