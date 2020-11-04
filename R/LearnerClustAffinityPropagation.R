#' @title Affinity Propagation Clustering Learner
#'
#' @name mlr_learners_clust.ap
#' @include LearnerClust.R
#'
#' @description
#' A [LearnerClust] for Affinity Propagation clustering implemented in [apcluster::apcluster()].
#' [apcluster::apcluster()] doesn't have set a default for similarity function.
#' Therefore, the `s` parameter here is set to `apcluster::negDistMat(r = 2L)` by default
#' since this is what is used in the original paper on Affity Propagation clustering.
#' The predict method computes the closest cluster exemplar to find the
#' cluster memberships for new data.
#' The code is taken from
#' [StackOverflow](https://stackoverflow.com/questions/34932692/using-the-apcluster-package-in-r-it-is-possible-to-score-unclustered-data-poi)
#' answer by the `apcluster` package maintainer.
#'
#' @templateVar id clust.ap
#' @template section_dictionary_learner
#' @template example
#'
#' @export
LearnerClustAP = R6Class("LearnerClustAP",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(
        params = list(
          ParamUty$new(id = "s", default = apcluster::negDistMat(r = 2L),
                       tags = c("required", "train")),
          ParamUty$new(id = "p", custom_check = function(x) {
            if (test_numeric(x)) {
              return(TRUE)
            } else {
              stop("`p` needs to be a numeric vector")
            }
          }, default = NA, tags = "train"),
          ParamDbl$new(id = "q", lower = 0L, upper = 1L, tags = "train"),
          ParamInt$new(id = "maxits", lower = 1L, default = 1000L, tags = "train"),
          ParamInt$new(id = "convits", lower = 1L, default = 100L, tags = "train"),
          ParamDbl$new(id = "lam", lower = 0.5, upper = 1L, default = 0.9, tags = "train"),
          ParamLgl$new(id = "includeSim", default = FALSE, tags = "train"),
          ParamLgl$new(id = "details", default = FALSE, tags = "train"),
          ParamLgl$new(id = "nonoise", default = FALSE, tags = "train"),
          ParamInt$new(id = "seed", tags = "train")
        )
      )
      ps$values = list(s = apcluster::negDistMat(r = 2L))

      super$initialize(
        id = "clust.ap",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = ps,
        properties = c("partitional", "exclusive", "complete"),
        packages = "apcluster"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      m = invoke(apcluster::apcluster, x = task$data(), .args = pv)
      # add data points corresponding to examplars
      attributes(m)$exemplar_data = task$data()[m@exemplars, ]

      if (self$save_assignments) {
        self$assignments = apcluster::labels(m, type = "enum")
      }

      return(m)
    },
    .predict = function(task) {
      sim_func = self$param_set$values$s
      exemplar_data = attributes(self$model)$exemplar_data

      sim_mat = sim_func(rbind(exemplar_data, task$data()),
                         sel = (1:nrow(task$data())) +
                           nrow(exemplar_data))[1:nrow(exemplar_data), ]
      partition = unname(apply(sim_mat, 2, which.max))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)
