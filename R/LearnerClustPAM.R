#' @title Partitioning Around Medoids Clustering Learner
#'
#' @name mlr_learners_clust.pam
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
#' @template learner
#'
#' @references
#' `r format_bib("reynolds2006clustering", "schubert2019faster")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustPAM = R6Class("LearnerClustPAM",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, tags = c("required", "train")),
        metric = p_fct(levels = c("euclidian", "manhattan"), tags = "train"),
        medoids = p_uty(
          default = NULL, tags = "train", custom_check = crate(function(x) check_integerish(x, null.ok = TRUE))
        ),
        stand = p_lgl(default = FALSE, tags = "train"),
        do.swap = p_lgl(default = TRUE, tags = "train"),
        pamonce = p_int(0L, 5L, default = 0L, tags = "train"),
        trace.lev = p_int(0L, default = 0L, tags = "train")
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.pam",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "cluster",
        man = "mlr3cluster::mlr_learners_clust.pam",
        label = "Partitioning Around Medoids"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      if (!is.null(pv$medoids)) {
        if (length(pv$medoids) != pv$k) {
          stopf("number of `medoids`' needs to match `k`!")
        }
        if (sum(pv$medoids <= task$nrow & pv$medoids >= 1L) != pv$k) {
          msg = sprintf("`medoids` need to contain valid indices from 1")
          stopf("%s to %s (number of observations)!", msg, pv$k)
        }
      }

      m = invoke(cluster::pam, x = task$data(), diss = FALSE, .args = pv)
      if (self$save_assignments) {
        self$assignments = m$clustering
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
register_learner("clust.pam", LearnerClustPAM)
