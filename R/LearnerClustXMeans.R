#' @title X-means Clustering Learner
#'
#' @name mlr_learners_clust.xmeans
#'
#' @description
#' A [LearnerClust] for X-means clustering implemented in [RWeka::XMeans()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.xmeans
#' @template learner
#'
#' @references
#' `r format_bib("witten2002data", "pelleg2000x")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustXMeans = R6Class("LearnerClustXMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        B                 = p_dbl(0, default = 1, tags = "train"),
        C                 = p_dbl(0, default = 0, tags = "train"),
        D                 = p_uty(default = "weka.core.EuclideanDistance", tags = "train"),
        H                 = p_int(1L, default = 4L, tags = "train"),
        I                 = p_int(1L, default = 1L, tags = "train"),
        J                 = p_int(1L, default = 1000L, tags = "train"),
        K                 = p_uty(default = "", tags = "train"),
        L                 = p_int(1L, default = 2L, tags = "train"),
        M                 = p_int(1L, default = 1000L, tags = "train"),
        S                 = p_int(1L, default = 10L, tags = "train"),
        U                 = p_int(0L, default = 0L, tags = "train"),
        use_kdtree        = p_lgl(default = FALSE, tags = "train"),
        N                 = p_uty(tags = "train"),
        O                 = p_uty(tags = "train"),
        Y                 = p_uty(tags = "train"),
        output_debug_info = p_lgl(default = FALSE, tags = "train")
      )

      super$initialize(
        id = "clust.xmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "RWeka",
        man = "mlr3cluster::mlr_learners_clust.xmeans",
        label = "X-means"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      names(pv) = chartr("_", "-", names(pv))
      ctrl = invoke(RWeka::Weka_control, .args = pv)
      m = invoke(RWeka::XMeans, x = task$data(), control = ctrl)
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
register_learner("clust.xmeans", LearnerClustXMeans)
