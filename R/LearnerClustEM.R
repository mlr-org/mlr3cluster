#' @title Expectation-Maximization Clustering Learner
#'
#' @name mlr_learners_clust.em
#'
#' @description
#' A [LearnerClust] for Expectation-Maximization clustering implemented in
#' [RWeka::list_Weka_interfaces()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.em
#' @template learner
#'
#' @references
#' `r format_bib("witten2002data", "dempster1977maximum")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustEM = R6Class("LearnerClustEM",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        I = p_int(1L, default = 100L, tags = "train"),
        ll_cv = p_dbl(1e-6, default = 1e-6, tags = "train"),
        ll_iter = p_dbl(1e-6, default = 1e-6, tags = "train"),
        M = p_dbl(1e-6, default = 1e-6, tags = "train"),
        max = p_int(-1L, default = -1L, tags = "train"),
        N = p_int(-1L, default = -1L, tags = "train"),
        num_slots = p_int(1L, default = 1L, tags = "train"),
        S = p_int(0L, default = 100L, tags = "train"),
        X = p_int(1L, default = 10L,  tags = "train"),
        K = p_int(1L, default = 10L, tags = "train"),
        V = p_lgl(default = FALSE, tags = "train"),
        output_debug_info = p_lgl(default = FALSE, tags = "train")
      )

      super$initialize(
        id = "clust.em",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "RWeka",
        man = "mlr3cluster::mlr_learners_clust.em",
        label = "Expectation-Maximization Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      names(pv) = chartr("_", "-", names(pv))
      ctrl = invoke(RWeka::Weka_control, .args = pv)
      m = invoke(RWeka::make_Weka_clusterer("weka/clusterers/EM"), x = task$data(), control = ctrl)
      if (self$save_assignments) {
        self$assignments = unname(m$class_ids + 1L)
      }
      m
    },

    .predict = function(task) {
      partition = invoke(predict, self$model, newdata = task$data(), type = "class") + 1L
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.em", LearnerClustEM)
