#' @title Prediction Object for Cluster Analysis
#'
#' @description
#' This object wraps the predictions returned by a learner of class [LearnerClust], i.e.
#' the predicted partition and cluster probability.
#'
#' @family Prediction
#' @export
PredictionClust = R6Class("PredictionClust", inherit = Prediction,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    #'
    #' @param task ([TaskClust])\cr
    #'   Task, used to extract defaults for `row_ids`.
    #'
    #' @param row_ids (`integer()`)\cr
    #'   Row ids of the predicted observations, i.e. the row ids of the test set.
    #'
    #' @param partition (`integer()`)\cr
    #'   Vector of cluster partitions.
    #'
    #' @param prob (`matrix()`)\cr
    #'   Matrix of cluster membership probabilities.
    initialize = function(task = NULL, row_ids = task$row_ids, partition = NULL, prob = NULL) {
      assert_row_ids(row_ids)
      n = length(row_ids)

      self$task_type = "clust"

      # Check returned predict types have correct names and add to data.table
      self$predict_types = c("partition", "prob")[c(!is.null(partition), !is.null(prob))]
      self$data$tab = data.table(row_id = row_ids)

      if (!is.null(partition)) {
        self$data$tab$partition = assert_integer(partition, len = n, any.missing = FALSE)
      }

      if (!is.null(prob)) {
        prob = assert_matrix(prob, any.missing = FALSE)
        for (i in seq_along(1:ncol(prob))) {
          self$data$tab[, sprintf("cluster_%s", i)] = prob[, i]
        }
      }

    }
  ),

  active = list(
    #' @field partition (`integer()`)\cr
    #' Access the stored partition.
    partition = function() {
      self$data$tab$partition %??% rep(NA_real_, length(self$data$row_ids))
    },

    #' @field prob (`matrix()`)\cr
    #' Access to the stored probabilities.
    prob = function() {
      self$data$tab$prob
    },

    #' @field missing (`integer()`)\cr
    #' Returns `row_ids` for which the predictions are missing or incomplete.
    missing = function() {
      miss = logical(nrow(self$data$tab))

      if ("partition" %in% self$predict_types) {
        miss = miss | is.na(self$data$tab$partition)
      }

      if ("prob" %in% self$predict_types) {
        miss = miss | apply(self$data$prob, 1L, anyMissing)
      }

      self$data$tab$row_id[miss]
    }
  )
)


#' @export
as.data.table.PredictionClust = function(x, ...) {
  copy(x$data$tab)
}

#' @export
c.PredictionClust = function(..., keep_duplicates = TRUE) {
  dots = list(...)
  assert_list(dots, "PredictionClust")
  assert_flag(keep_duplicates)
  if (length(dots) == 1L || TRUE) {
    return(dots[[1L]])
  }

  predict_types = map(dots, "predict_types")
  if (!every(predict_types[-1L], setequal, y = predict_types[[1L]]))
    stopf("Cannot rbind predictions: Different predict_types in objects.")

  tab = map_dtr(dots, function(p) subset(p$data$tab), .fill = FALSE)
  prob = do.call(rbind, map(dots, "prob"))

  if (!keep_duplicates) {
    keep = !duplicated(tab, by = "row_id", fromLast = TRUE)
    tab = tab[keep]
    prob = prob[keep, , drop = FALSE]
  }

  PredictionClust$new(row_ids = tab$row_id, partition = tab$partition, prob = prob)
}
