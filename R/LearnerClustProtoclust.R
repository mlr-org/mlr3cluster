#' @title Prototype Hierarchical Clustering Learner
#'
#' @name mlr_learners_clust.protoclust
#'
#' @description
#' Hierarchical clustering using minimax linkage with prototypes.
#' Calls [protoclust::protoclust()] from package \CRANpkg{protoclust}.
#'
#' The predict method cuts the tree at the current `k` via [protoclust::protocut()] and assigns each new observation
#' to the cluster of its nearest prototype, using the same distance method as during training. The model is therefore
#' a list containing the fitted [protoclust::protoclust()] object along with the training data.
#'
#' @templateVar id clust.protoclust
#' @template learner
#'
#' @references
#' `r format_bib("bien2011hierarchical")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustProtoclust = R6Class(
  "LearnerClustProtoclust",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        method = p_fct(
          levels = c("euclidean", "maximum", "manhattan", "canberra", "binary", "minkowski"),
          default = "euclidean",
          tags = c("train", "dist")
        ),
        diag = p_lgl(default = FALSE, tags = c("train", "dist")),
        upper = p_lgl(default = FALSE, tags = c("train", "dist")),
        p = p_dbl(0, default = 2, tags = c("train", "dist"), depends = quote(method == "minkowski")),
        verb = p_lgl(default = FALSE, tags = c("train", "protoclust")),
        k = p_int(1L, tags = c("train", "protocut", "predict"))
      )

      param_set$set_values(k = 2L)

      super$initialize(
        id = "clust.protoclust",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("hierarchical", "exclusive", "complete"),
        packages = "protoclust",
        man = "mlr3cluster::mlr_learners_clust.protoclust",
        label = "Prototype Hierarchical Clustering"
      )
    }
  ),

  active = list(
    #' @field native_model (any)\cr
    #' The fitted model.
    native_model = function(rhs) {
      assert_ro_binding(rhs)
      self$model$model
    }
  ),

  private = list(
    .train = function(task) {
      ps = self$param_set
      data = as.matrix(task$data())
      d = invoke(stats::dist, x = data, .args = ps$get_values(tags = c("train", "dist")))
      m = invoke(protoclust::protoclust, d = d, .args = ps$get_values(tags = c("train", "protoclust")))
      if (self$save_assignments) {
        self$assignments = invoke(
          protoclust::protocut,
          hc = m,
          .args = ps$get_values(tags = c("train", "protocut"))
        )$cl
      }
      # predict needs the training data to compute distances to the prototype observations
      list(model = m, data = data)
    },

    .predict = function(task) {
      m = self$model
      pv = self$param_set$get_values(tags = "predict")
      if (pv$k > nrow(m$data)) {
        error_input("`k` needs to be between 1 and %i.", nrow(m$data))
      }

      pc = invoke(
        protoclust::protocut,
        hc = m$model,
        .args = self$param_set$get_values(tags = c("train", "protocut"))
      )
      x = as.matrix(ordered_features(task, self))
      protos = m$data[pc$protos, , drop = FALSE]
      d = invoke(stats::dist, x = rbind(protos, x), .args = self$param_set$get_values(tags = c("train", "dist")))
      d = as.matrix(d)[-seq_len(nrow(protos)), seq_len(nrow(protos)), drop = FALSE]
      partition = pc$cl[pc$protos][max.col(-d, ties.method = "first")]

      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.protoclust", LearnerClustProtoclust)
