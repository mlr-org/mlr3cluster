#' @title Kernel K-Means Clustering Learner
#'
#' @name mlr_learners_clust.kkmeans
#'
#' @description
#' Kernel k-means clustering.
#' Calls [kernlab::kkmeans()] from package \CRANpkg{kernlab}.
#'
#' The `centers` parameter is set to 2 by default since [kernlab::kkmeans()] doesn't have a default value for the number
#' of clusters. Kernel parameters have to be passed directly and not by using the `kpar` list in [kernlab::kkmeans()].
#' The predict method assigns each new observation to the cluster whose centroid is nearest in the kernel-induced
#' feature space, computed from the stored training data. The model is therefore a list containing the fitted
#' [kernlab::kkmeans()] object along with the training data and per-cluster kernel statistics.
#' The task must have at least 2 features.
#'
#' @templateVar id clust.kkmeans
#' @template learner
#'
#' @references
#' `r format_bib("karatzoglou2004kernlab", "dhillon2004unified")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustKKMeans = R6Class(
  "LearnerClustKKMeans",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        centers = p_uty(tags = c("train", "required"), custom_check = check_centers),
        kernel = p_fct(
          levels = c("rbfdot", "polydot", "vanilladot", "tanhdot", "laplacedot", "besseldot", "anovadot", "splinedot"),
          default = "rbfdot",
          tags = "train"
        ),
        sigma = p_dbl(
          0,
          tags = c("train", "kpar"),
          depends = quote(kernel %in% c("rbfdot", "anovadot", "besseldot", "laplacedot"))
        ),
        degree = p_int(
          1L,
          default = 1L,
          tags = c("train", "kpar"),
          depends = quote(kernel %in% c("polydot", "anovadot", "besseldot"))
        ),
        scale = p_dbl(0, default = 1, tags = c("train", "kpar"), depends = quote(kernel %in% c("polydot", "tanhdot"))),
        offset = p_dbl(default = 1, tags = c("train", "kpar"), depends = quote(kernel %in% c("polydot", "tanhdot"))),
        order = p_int(default = 1L, tags = c("train", "kpar"), depends = quote(kernel == "besseldot")),
        alg = p_fct(c("kkmeans", "kerninghan"), default = "kkmeans", tags = "train"),
        p = p_dbl(default = 1, tags = "train")
      )

      param_set$set_values(centers = 2L)

      super$initialize(
        id = "clust.kkmeans",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "kernlab",
        man = "mlr3cluster::mlr_learners_clust.kkmeans",
        label = "Kernel K-Means"
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
      if (task$n_features < 2L) {
        error_input("Task must have at least 2 features, but has %i.", task$n_features)
      }
      pv = self$param_set$get_values(tags = "train")
      assert_centers_param(pv$centers, task, "centers")

      kpar = self$param_set$get_values(tags = c("train", "kpar"))
      if (length(kpar) > 0L) {
        pv = remove_named(pv, names(kpar))
        pv$kpar = kpar
      }

      data = as.matrix(task$data())
      m = invoke(kernlab::kkmeans, x = data, .args = pv)
      if (self$save_assignments) {
        self$assignments = as.integer(m)
      }

      # predict needs the training data and per-cluster kernel means to compute feature-space centroid distances
      cl = as.integer(m)
      clusters = sort(unique(cl))
      # per-cluster kernel blocks avoid materializing the full n x n training kernel matrix
      within = map_dbl(clusters, function(cc) {
        mean(kernlab::kernelMatrix(kernlab::kernelf(m), data[cl == cc, , drop = FALSE]))
      })
      list(model = m, data = data, clusters = clusters, within = within)
    },

    .predict = function(task) {
      m = self$model
      K = kernlab::kernelf(m$model)
      cl = as.integer(m$model)
      # align columns with the training data since the kernel pairs features positionally
      x = as.matrix(task$data())[, colnames(m$data), drop = FALSE]

      # squared feature-space distance to each cluster centroid, dropping the K(x, x) term that is constant per row
      kxt = kernlab::kernelMatrix(K, x, m$data)
      # count-normalized cluster indicator, so one matrix product yields the per-cluster kernel row means
      w = outer(cl, m$clusters, "==")
      w = w / rep(colSums(w), each = length(cl))
      d2 = rep(m$within, each = nrow(kxt)) - 2 * kxt %*% w
      partition = m$clusters[max.col(-d2, ties.method = "random")]

      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.kkmeans", LearnerClustKKMeans)
