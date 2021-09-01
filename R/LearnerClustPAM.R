#' @title Partitioning Around Medoids Cluster Learner
#'
#' @name mlr_learners_clust.pam
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for PAM clustering implemented in [cluster::pam()].
#' [cluster::pam()] doesn't have a default value for the number of clusters.
#' Therefore, the `k` parameter which corresponds to the number
#' of clusters here is set to 2 by default.
#' The predict method uses [clue::cl_predict()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.pam
#' @template section_dictionary_learner
#' @template example
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
          ParamInt$new(id = "k", lower = 1L, default = 2L, tags = c("required", "train")),
          ParamFct$new(id = "metric", levels = c("euclidian", "manhattan"), tags = "train"),
          ParamUty$new(
            id = "medoids",
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
          ParamLgl$new(id = "stand", default = FALSE, tags = "train"),
          ParamLgl$new(id = "do.swap", default = TRUE, tags = "train"),
          ParamInt$new(id = "pamonce", lower = 0L, upper = 5L, default = 0, tags = "train"),
          ParamInt$new(id = "trace.lev", lower = 0L, default = 0L, tags = "train")
        )
      )
      ps$values = list(k = 2L)

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
          if (sum(unlist(r)) != self$param_set$values$k) {
            msg = sprintf("`medoids` need to contain valid indices from 1")
            msg = sprintf("%s to %s (number of observations)!", msg, self$param_set$values$k)
            stopf(msg)
          }
        }
      }

      pv = self$param_set$get_values(tags = "train")
      m = invoke(cluster::pam, x = task$data(), diss = FALSE, .args = pv)
      if (self$save_assignments) {
        self$assignments = m$clustering
      }

      return(m)
    },
    .predict = function(task) {
      partition = unclass(cl_predict(self$model, newdata = task$data(), type = "class_ids"))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
