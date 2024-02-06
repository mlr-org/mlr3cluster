#' @title X-means Clustering Learner
#'
#' @name mlr_learners_clust.xmeans
#' @include LearnerClust.R
#' @include aaa.R
#'
#' @description
#' A [LearnerClust] for X-means clustering implemented in [RWeka::XMeans()].
#' The predict method uses [RWeka::predict.Weka_clusterer()] to compute the
#' cluster memberships for new data.
#'
#' @templateVar id clust.xmeans
#' @template learner
#' @template example
#'
#' @export
LearnerClustXMeans = R6Class("LearnerClustXMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        B                 = p_dbl(default = 1, lower = 0, tags = "train"),
        C                 = p_dbl(default = 0, lower = 0, tags = "train"),
        D                 = p_uty(default = "weka.core.EuclideanDistance", tags = "train"),
        H                 = p_int(default = 4L, lower = 1L, tags = "train"),
        I                 = p_int(default = 1L, lower = 1L, tags = "train"),
        J                 = p_int(default = 1000L, lower = 1L, tags = "train"),
        K                 = p_uty(default = "", tags = "train"),
        L                 = p_int(default = 2L, lower = 1L, tags = "train"),
        M                 = p_int(default = 1000L, lower = 1L, tags = "train"),
        S                 = p_int(default = 10L, lower = 1L, tags = "train"),
        U                 = p_int(default = 0L, lower = 0L, tags = "train"),
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
      ctrl = do.call(RWeka::Weka_control, pv)
      m = invoke(RWeka::XMeans, x = task$data(), control = ctrl)
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

learners[["clust.xmeans"]] = LearnerClustXMeans
