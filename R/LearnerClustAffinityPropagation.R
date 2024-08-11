#' @title Affinity Propagation Clustering Learner
#'
#' @name mlr_learners_clust.ap
#'
#' @description
#' A [LearnerClust] for Affinity Propagation clustering implemented in [apcluster::apcluster()].
#' [apcluster::apcluster()] doesn't have set a default for similarity function.
#' The predict method computes the closest cluster exemplar to find the
#' cluster memberships for new data.
#' The code is taken from
#' [StackOverflow](https://stackoverflow.com/questions/34932692/using-the-apcluster-package-in-r-it-is-possible-to-score-unclustered-data-poi)
#' answer by the `apcluster` package maintainer.
#'
#' @templateVar id clust.ap
#' @template learner
#'
#' @references
#' `r format_bib("bodenhofer2011apcluster", "frey2007clustering")`
#'
#' @export
#' @template seealso_learner
#' @template example
LearnerClustAP = R6Class("LearnerClustAP",
  inherit = LearnerClust,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      param_set = ps(
        s = p_uty(tags = c("required", "train")),
        p = p_uty(default = NA, tags = "train", custom_check = check_numeric),
        q = p_dbl(0, 1, tags = "train"),
        maxits = p_int(1L, default = 1000L, tags = "train"),
        convits = p_int(1L, default = 100L, tags = "train"),
        lam = p_dbl(0.5, 1, default = 0.9, tags = "train"),
        includeSim = p_lgl(default = FALSE, tags = "train"),
        details = p_lgl(default = FALSE, tags = "train"),
        nonoise = p_lgl(default = FALSE, tags = "train"),
        seed = p_int(tags = "train")
      )

      super$initialize(
        id = "clust.ap",
        feature_types = c("logical", "integer", "numeric"),
        predict_types = "partition",
        param_set = param_set,
        properties = c("partitional", "exclusive", "complete"),
        packages = "apcluster",
        man = "mlr3cluster::mlr_learners_clust.ap",
        label = "Affinity Propagation Clustering"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      d = task$data()
      m = invoke(apcluster::apcluster, x = d, .args = pv)
      # add data points corresponding to examplars
      attributes(m)$exemplar_data = d[m@exemplars, ]

      if (self$save_assignments) {
        self$assignments = apcluster::labels(m, type = "enum")
      }
      m
    },

    .predict = function(task) {
      pv = self$param_set$get_values()
      sim_func = pv$s
      exemplar_data = attributes(self$model)$exemplar_data

      d = task$data()
      sim_mat = sim_func(
        rbind(exemplar_data, d),
        sel = (seq_len(nrow(d))) + nrow(exemplar_data)
      )[seq_len(nrow(exemplar_data)), ]
      partition = unname(apply(sim_mat, 2, which.max))
      PredictionClust$new(task = task, partition = partition)
    }
  )
)

#' @include zzz.R
register_learner("clust.ap", LearnerClustAP)
