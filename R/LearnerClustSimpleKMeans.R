#' @title K-Means Clustering Learner (Weka)
#'
#' @name mlr_learners_clust.SimpleKMeans
#'
#' @description
#' K-means clustering (Weka).
#' Calls [RWeka::SimpleKMeans()] from package \CRANpkg{RWeka}.
#'
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the cluster memberships for new data.
#'
#' @templateVar id clust.SimpleKMeans
#' @template learner
#'
#' @references
#' `r format_bib("witten2002data", "forgy1965cluster", "lloyd1982least", "macqueen1967some")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustSimpleKMeans = R6Class(
  "LearnerClustSimpleKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        A = p_uty(default = "weka.core.EuclideanDistance", tags = "train"),
        C = p_lgl(default = FALSE, tags = "train"),
        fast = p_lgl(default = FALSE, tags = "train"),
        I = p_int(1L, default = 500L, tags = "train"),
        init = p_int(0L, 3L, default = 0L, tags = "train"),
        M = p_lgl(default = FALSE, tags = "train"),
        max_candidates = p_int(1L, default = 100L, tags = "train"),
        min_density = p_dbl(0, default = 2, tags = "train"),
        N = p_int(1L, default = 2L, tags = "train"),
        num_slots = p_int(1L, default = 1L, tags = "train"),
        O = p_lgl(default = FALSE, tags = "train"),
        periodic_pruning = p_int(1L, default = 10000L, tags = "train"),
        S = p_int(0L, default = 10L, tags = "train"),
        t2 = p_dbl(default = -1, tags = "train"),
        t1 = p_dbl(default = -1.25, tags = "train"),
        V = p_lgl(default = FALSE, tags = "train"),
        output_debug_info = p_lgl(default = FALSE, tags = "train")
      )

      super$initialize(
        id = "clust.SimpleKMeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete", "missings", "marshal"),
        packages = "RWeka",
        man = "mlr3cluster::mlr_learners_clust.SimpleKMeans",
        label = "K-Means (Weka)"
      )
    },

    #' @description
    #' Marshal the learner's model.
    #' @param ... (any)\cr
    #'   Additional arguments passed to [mlr3::marshal_model()].
    marshal = function(...) {
      learner_marshal(.learner = self, ...)
    },

    #' @description
    #' Unmarshal the learner's model.
    #' @param ... (any)\cr
    #'   Additional arguments passed to [mlr3::unmarshal_model()].
    unmarshal = function(...) {
      learner_unmarshal(.learner = self, ...)
    }
  ),

  active = list(
    #' @field marshaled (`logical(1)`)\cr
    #' Whether the learner's model is marshaled.
    marshaled = function() {
      learner_marshaled(self)
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      ctrl = weka_control(pv)
      m = invoke(RWeka::SimpleKMeans, x = task$data(), control = ctrl)
      if (self$save_assignments) {
        self$assignments = unname(m$class_ids + 1L)
      }
      m
    },

    .predict = function(task) {
      partition = invoke(predict, self$model, newdata = ordered_features(task, self), type = "class_ids") + 1L
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.SimpleKMeans", LearnerClustSimpleKMeans)
