#' @title BICO Clustering Learner
#'
#' @name mlr_learners_clust.bico
#'
#' @description
#' BICO (fast computation of k-means coresets in a data stream) clustering.
#' Calls [stream::DSC_BICO()] from package \CRANpkg{stream}.
#'
#' [stream::DSC_BICO()] only computes the coreset (micro-clusters), so the coreset is reclustered with k-means via
#' [stream::DSC_TwoStage()] and [stream::DSC_Kmeans()] to obtain the final partition with `k` clusters.
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
LearnerClustBICO = R6Class(
  "LearnerClustBICO",
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
        label = "BICO"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      k = pv$k %??% 5L
      data = task$data()
      # DSC_BICO only builds the coreset, so the k-means macro stage is needed for `k` to determine the partition
      m = stream::DSC_TwoStage(
        micro = invoke(stream::DSC_BICO, .args = pv),
        macro = stream::DSC_Kmeans(k = k)
      )
      x = stream::DSD_Memory(data)
      stats::update(m, x, n = nrow(data))

      n_centers = nrow(stream::get_centers(m, type = "macro"))
      if (n_centers < k) {
        warning_input(
          "Learner '%s' found only %i of %i clusters because the coreset is too small, increase `space`.",
          self$id,
          n_centers,
          k
        )
      }

      if (self$save_assignments) {
        self$assignments = as.integer(invoke(predict, m, newdata = data)[[1L]])
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
