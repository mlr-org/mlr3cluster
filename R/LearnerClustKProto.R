#' @title K-Prototypes Clustering Learner
#'
#' @name mlr_learners_clust.kproto
#'
#' @description
#' K-prototypes clustering for mixed-type data.
#' Calls [clustMixType::kproto()] from package \CRANpkg{clustMixType}.
#'
#' The `k` parameter is set to 2 by default since [clustMixType::kproto()]
#' doesn't have a default value for the number of clusters.
#'
#' @templateVar id clust.kproto
#' @template learner
#'
#' @references
#' `r format_bib("huang1998extensions")`
#'
#' @export
#' @template seealso_learner
#' @examplesIf mlr3misc::require_namespaces(lrn("clust.kproto")$packages, quietly = TRUE)
#' # Define the Learner and set parameter values
#' learner = lrn("clust.kproto")
#' print(learner)
#'
#' # Define a mixed-type Task (kproto requires at least one factor variable)
#' data = data.frame(
#'   x1 = c(1, 2, 10, 11, 1, 2, 10, 11),
#'   x2 = factor(c("a", "a", "b", "b", "a", "a", "b", "b"))
#' )
#' task = as_task_clust(data)
#'
#' # Train the learner on the task
#' learner$train(task)
#'
#' # Print the model
#' print(learner$model)
#'
#' # Make predictions for the task
#' prediction = learner$predict(task)
#'
#' # Score the predictions
#' prediction$score(task = task)
LearnerClustKProto = R6Class(
  "LearnerClustKProto",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        k = p_uty(tags = c("train", "required")),
        lambda = p_uty(
          default = NULL,
          tags = "train",
          custom_check = crate(function(x) {
            check_numeric(x, lower = 0, any.missing = FALSE, min.len = 1L, null.ok = TRUE)
          })
        ),
        type = p_fct(c("huang", "gower"), default = "huang", tags = "train"),
        iter.max = p_int(1L, default = 100L, tags = "train"),
        nstart = p_int(1L, default = 1L, tags = "train"),
        na.rm = p_fct(c("yes", "no", "imp.internal", "imp.onestep"), default = "yes", tags = "train"),
        verbose = p_lgl(default = TRUE, tags = "train"),
        init = p_fct(c("nbh.dens", "sel.cen", "nstart.m"), default = NULL, special_vals = list(NULL), tags = "train"),
        p_nstart.m = p_dbl(0, 1, default = 0.9, tags = "train", depends = quote(init == "nstart.m"))
      )

      param_set$set_values(k = 2L, verbose = FALSE)

      super$initialize(
        id = "clust.kproto",
        feature_types = c("logical", "integer", "numeric", "factor", "ordered"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "clustMixType",
        man = "mlr3cluster::mlr_learners_clust.kproto",
        label = "K-Prototypes"
      )
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(clustMixType::kproto, x = task$data(), .args = pv)
      if (self$save_assignments) {
        self$assignments = m$cluster
      }
      m
    },

    .predict = function(task) {
      partition = invoke(predict, self$model, newdata = task$data())$cluster
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.kproto", LearnerClustKProto)
