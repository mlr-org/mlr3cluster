#' @title BIRCH Clustering Learner
#'
#' @name mlr_learners_clust.birch
#'
#' @description
#' BIRCH (Balanced Iterative Reducing Clustering using Hierarchies) clustering.
#' Calls [stream::DSC_BIRCH()] from \CRANpkg{stream}.
#'
#' @templateVar id clust.birch
#' @template learner
#'
#' @references
#' `r format_bib("zhang1996birch", "zhang1997birch", "hahsler2017stream")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustBIRCH = R6Class("LearnerClustBIRCH",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        threshold = p_dbl(0L, tags = c("train", "required")),
        branching = p_int(1L, tags = c("train", "required")),
        maxLeaf = p_int(1L, tags = c("train", "required")),
        maxMem = p_int(0L, default = 0L, tags = "train"),
        outlierThreshold = p_dbl(default = 0.25, tags = "train")
      )

      super$initialize(
        id = "clust.birch",
        feature_types = c("integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "stream",
        man = "mlr3cluster::mlr_learners_clust.birch",
        label = "BIRCH Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      dt = task$data()
      m = invoke(stream::DSC_BIRCH, .args = pv)
      x = stream::DSD_Memory(dt)
      stats::update(m, x, n = nrow(dt))

      if (self$save_assignments) {
        self$assignments = as.integer(invoke(predict, m, newdata = dt)[[1L]])
      }
      m
    },

    .predict = function(task) {
      partition = as.integer(invoke(predict, self$model, newdata = task$data())[[1L]])
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.birch", LearnerClustBIRCH)
