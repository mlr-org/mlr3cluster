#' @title Mean Shift Clustering Learner
#'
#' @name mlr_learners_clust.meanshift
#'
#' @description
#' Mean shift clustering.
#' Calls [LPCM::ms()] from package \CRANpkg{LPCM}.
#'
#' The predict method runs the mean-shift iteration from each new observation with the trained bandwidth via
#' [LPCM::ms.rep()] and assigns it to the mode it converges to, i.e. the basin of attraction of the fitted modes.
#'
#' @section Initial parameter values:
#' - `plot`:
#'   - Actual default: `TRUE`.
#'   - Adjusted default: `FALSE`.
#'   - Reason for change: Suppress plotting during training.
#'
#' @templateVar id clust.meanshift
#' @template learner
#'
#' @references
#' `r format_bib("cheng1995mean")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustMeanShift = R6Class(
  "LearnerClustMeanShift",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        h = p_uty(tags = "train", custom_check = check_numeric),
        subset = p_uty(tags = "train", custom_check = check_numeric),
        thr = p_dbl(default = 0.01, tags = "train"),
        scaled = p_int(0L, default = 1L, tags = "train"),
        iter = p_int(1L, default = 200L, tags = "train"),
        plot = p_lgl(default = TRUE, tags = "train")
      )

      param_set$set_values(plot = FALSE)

      super$initialize(
        id = "clust.meanshift",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("density", "exclusive", "complete"),
        packages = "LPCM",
        man = "mlr3cluster::mlr_learners_clust.meanshift",
        label = "Mean Shift"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      if (!is.null(pv$subset) && length(pv$subset) > task$nrow) {
        error_config("`subset` length must be less than or equal to number of observations in task.")
      }

      m = invoke(LPCM::ms, X = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m$cluster.label)
      }
      m
    },

    .predict = function(task) {
      m = self$model
      x = as.matrix(ordered_features(task, self))
      x = sweep(x, 2L, m$scaled.by, "/")

      # mirror the convergence criterion LPCM::ms() applies during training
      pv = self$param_set$get_values(tags = "train")
      args = list(X = as.matrix(m$data), h = m$h)
      if (!is.null(pv$thr)) {
        args$thresh = pv$thr^2
      }
      if (!is.null(pv$iter)) {
        args$iter = pv$iter
      }
      partition = map_int(seq_len(nrow(x)), function(i) {
        final = invoke(LPCM::ms.rep, x = x[i, ], .args = args)$final
        which_min(rowSums(sweep(m$cluster.center, 2L, final, "-")^2), ties_method = "first")
      })

      list(partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.meanshift", LearnerClustMeanShift)
