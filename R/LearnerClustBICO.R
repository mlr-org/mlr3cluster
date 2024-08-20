#' @title BICO Clustering Learner
#'
#' @name mlr_learners_clust.bico
#'
#' @description
#' BICO (Fast computation of k-means coresets in a data stream) clustering.
#' Calls [stream::DSC_BICO()] from \CRANpkg{stream}.
#'
#' @templateVar id clust.bico
#' @template learner
#'
#' @references
#' `r format_bib("fichtenberger2013bico", "hahsler2017stream")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustBICO = R6Class("LearnerClustBICO",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_int(1L, default = 5L, tags = "train"),
        space = p_int(1L, default = 10L, tags = "train"),
        p = p_int(1L, default = 10L, tags = "train"),
        iterations = p_int(1L, default = 10L, tags = "train")
      )

      super$initialize(
        id = "clust.bico",
        feature_types = c("integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "stream",
        man = "mlr3cluster::mlr_learners_clust.bico",
        label = "BICO Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      dt = task$data()
      m = invoke(stream::DSC_BICO, .args = pv)
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
register_learner("clust.bico", LearnerClustBICO)
