#' @title Expectation-Maximization Clustering Learner
#'
#' @name mlr_learners_clust.em
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for Expectation-Maximization clustering implemented in
#' [RWeka::list_Weka_interfaces()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.em
#' @template learner
#' @template example
#'
#' @export
LearnerClustEM = R6Class("LearnerClustEM",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ps(
        I = p_int(default = 100L, lower = 1L, tags = "train"),
        ll_cv = p_dbl(default = 1e-6, lower = 1e-6, tags = "train"),
        ll_iter = p_dbl(default = 1e-6, lower = 1e-6, tags = "train"),
        M = p_dbl(default = 1e-6, lower = 1e-6, tags = "train"),
        max = p_int(default = -1L, lower = -1L, tags = "train"),
        N = p_int(default = -1L, lower = -1L, tags = "train"),
        num_slots = p_int(default = 1L, lower = 1L, tags = "train"),
        S = p_int(default = 100L, lower = 0L, tags = "train"),
        X = p_int(default = 10L, lower = 1L, tags = "train"),
        K = p_int(default = 10L, lower = 1L, tags = "train"),
        V = p_lgl(default = FALSE, tags = "train"),
        output_debug_info = p_lgl(default = FALSE, tags = "train")
      )

      super$initialize(
        id = "clust.em",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("partitional", "exclusive", "complete"),
        packages = "RWeka",
        label = "Expectation-Maximization Clustering"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      names(pv) = chartr("_", "-", names(pv))
      ctrl = do.call(RWeka::Weka_control, pv)
      m = invoke(RWeka::make_Weka_clusterer("weka/clusterers/EM"), x = task$data(), control = ctrl)
      if (self$save_assignments) {
        self$assignments = unname(m$class_ids + 1L)
      }

      return(m)
    },

    .predict = function(task) {
      partition = predict(self$model, newdata = task$data(), type = "class") + 1L
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

learners[["clust.em"]] = LearnerClustEM
