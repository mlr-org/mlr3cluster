#' @title K-Means Clustering Learner from Weka
#'
#' @name mlr_learners_clust.SimpleKMeans
#'
#' @description
#' A [LearnerClust] for Simple K Means clustering implemented in [RWeka::SimpleKMeans()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.SimpleKMeans
#' @template learner
#' @examples
#' \dontrun{
#' if (requireNamespace("RWeka")) {
#'   learner = mlr3::lrn("clust.SimpleKMeans")
#'   print(learner)
#'
#'   # available parameters:
#'   learner$param_set$ids()
#' }
#' }
#'
#' @export
LearnerClustSimpleKMeans = R6Class("LearnerClustSimpleKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        A                 = p_uty(default = "weka.core.EuclideanDistance", tags = "train"),
        C                 = p_lgl(default = FALSE, tags = "train"),
        fast              = p_lgl(default = FALSE, tags = "train"),
        I                 = p_int(1L, default = 100L, tags = "train"),
        init              = p_int(0L, 3L, default = 0L, tags = "train"),
        M                 = p_lgl(default = FALSE, tags = "train"),
        max_candidates    = p_int(1L, default = 100L, tags = "train"),
        min_density       = p_int(1L, default = 2L, tags = "train"),
        N                 = p_int(1L, default = 2L, tags = "train"),
        num_slots         = p_int(1L, default = 1L, tags = "train"),
        O                 = p_lgl(default = FALSE, tags = "train"),
        periodic_pruning  = p_int(1L, default = 10000L, tags = "train"),
        S                 = p_int(0L, default = 10L, tags = "train"),
        t2                = p_dbl(default = -1, tags = "train"),
        t1                = p_dbl(default = -1.5, tags = "train"),
        V                 = p_lgl(default = FALSE, tags = "train"),
        output_debug_info = p_lgl(default = FALSE, tags = "train")
      )

      super$initialize(
        id = "clust.SimpleKMeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "RWeka",
        man = "mlr3cluster::mlr_learners_clust.SimpleKMeans",
        label = "K-Means (Weka)"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      names(pv) = chartr("_", "-", names(pv))
      ctrl = do.call(RWeka::Weka_control, pv)
      m = invoke(RWeka::SimpleKMeans, x = task$data(), control = ctrl)
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

#' @include aaa.R
learners[["clust.SimpleKMeans"]] = LearnerClustSimpleKMeans
