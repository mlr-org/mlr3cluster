#' @title K-Modes Clustering Learner
#'
#' @name mlr_learners_clust.kmodes
#'
#' @description
#' K-modes clustering for categorical data.
#' Calls [klaR::kmodes()] from package \CRANpkg{klaR}.
#'
#' All feature values are treated as categories.
#' Numeric features are accepted, but [klaR::kmodes()] warns when they contain more than 30 distinct values.
#'
#' The `modes` parameter is set to 2 by default since [klaR::kmodes()] does not have a default value for the number of
#' clusters.
#' Since [klaR::kmodes()] does not provide a predict method, new observations are assigned to their closest learned
#' mode.
#' Prediction always uses unweighted simple matching distance, including for models trained with `weighted = TRUE`.
#'
#' @templateVar id clust.kmodes
#' @template learner
#'
#' @references
#' `r format_bib("huang1997fast")`
#'
#' @export
#' @template seealso_learner
#' @examplesIf mlr3misc::require_namespaces(lrn("clust.kmodes")$packages, quietly = TRUE)
#' # Define the learner
#' learner = lrn("clust.kmodes", modes = 2L)
#'
#' # Define a categorical task
#' data = data.frame(
#'   color = factor(c("red", "red", "blue", "blue")),
#'   shape = factor(c("round", "round", "square", "square"))
#' )
#' task = as_task_clust(data)
#'
#' # Train and predict
#' learner$train(task)
#' prediction = learner$predict(task)
LearnerClustKModes = R6Class(
  "LearnerClustKModes",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        modes = p_uty(
          tags = c("train", "required"),
          custom_check = crate(function(x) check_data_frame(x) %check||% check_int(x, lower = 1L))
        ),
        iter.max = p_int(1L, default = 10L, tags = "train"),
        weighted = p_lgl(default = FALSE, tags = "train"),
        fast = p_lgl(default = TRUE, tags = "train"),
        ties = p_fct(c("first", "last", "random"), default = "first", tags = "predict")
      )

      param_set$set_values(modes = 2L)

      super$initialize(
        id = "clust.kmodes",
        feature_types = c("logical", "integer", "numeric", "factor", "ordered"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "klaR",
        man = "mlr3cluster::mlr_learners_clust.kmodes",
        label = "K-Modes"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      assert_centers_param(pv$modes, task, "modes")

      data = task$data()
      if (test_data_frame(pv$modes)) {
        if (!test_names(names(pv$modes), permutation.of = names(data))) {
          error_input("`modes` column names must match the task features.")
        }
        pv$modes = as.data.frame(pv$modes)[names(data)]
      }

      m = invoke(klaR::kmodes, data = data, .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m$cluster)
      }
      m
    },

    .predict = function(task) {
      if (identical(task$hash, self$state$task_hash)) {
        partition = as.integer(self$model$cluster)
      } else {
        pv = self$param_set$get_values(tags = "predict")
        newdata = ordered_features(task, self)
        modes = self$model$modes
        distances = matrix(0, nrow = nrow(newdata), ncol = nrow(modes))

        for (j in seq_along(newdata)) {
          values = newdata[[j]]
          mode_values = modes[[j]]
          # klaR drops the ordered class from learned modes, so align the local mode type before comparison.
          if (is.factor(values)) {
            mode_values = as_factor(mode_values, levels(values), ordered = is.ordered(values))
          }
          distances = distances + outer(values, mode_values, "!=")
        }

        partition = max.col(-distances, ties.method = pv$ties %??% "first")
      }
      list(partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.kmodes", LearnerClustKModes)
