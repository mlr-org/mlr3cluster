#' @include cluster_stats.R
#' @include measures.R
#' @include MeasureClust.R
MeasureClustSimple = R6Class(
  "MeasureClustSimple",
  inherit = MeasureClust,
  cloneable = FALSE,
  public = list(
    initialize = function(name, label) {
      info = measures[[name]]
      super$initialize(
        id = paste0("clust.", name),
        range = c(info$lower, info$upper),
        minimize = info$minimize,
        predict_type = info$predict_type,
        packages = if (info$input == "dist") "cluster" else character(),
        properties = if (info$input != "none") "requires_task" else character(),
        label = label,
        man = paste0("mlr3cluster::mlr_measures_clust.", name)
      )
      private$.fun = info$fun
      private$.input = info$input
      private$.requires_k2 = info$requires_k2
    }
  ),
  private = list(
    .fun = NULL,
    .input = NULL,
    .requires_k2 = NULL,

    .score = function(prediction, task, ...) {
      if (private$.requires_k2 && length(unique(prediction$partition)) < 2L) {
        return(NaN)
      }
      switch(
        private$.input,
        data = {
          x = as.matrix(task$data(rows = prediction$row_ids))
          private$.fun(x, prediction$partition)
        },
        dist = {
          data = task$data(rows = prediction$row_ids)
          if (any(task$feature_types$type %in% c("factor", "ordered"))) {
            d = as.matrix(cluster::daisy(data, metric = "gower"))
          } else {
            d = as.matrix(stats::dist(data))
          }
          private$.fun(d, prediction$partition)
        },
        none = {
          private$.fun(prediction$partition)
        }
      )
    }
  )
)

MeasureClustSil = R6Class(
  "MeasureClustSil",
  inherit = MeasureClust,
  cloneable = FALSE,
  public = list(
    initialize = function() {
      super$initialize(
        id = "clust.silhouette",
        range = c(-1, 1),
        minimize = FALSE,
        predict_type = "partition",
        packages = "cluster",
        properties = "requires_task",
        label = "Silhouette",
        man = "mlr3cluster::mlr_measures_clust.silhouette"
      )
    }
  ),
  private = list(
    .score = function(prediction, task, ...) {
      data = task$data(rows = prediction$row_ids)
      if (any(task$feature_types$type %in% c("factor", "ordered"))) {
        d = cluster::daisy(data, metric = "gower")
      } else {
        d = stats::dist(data)
      }

      if (length(unique(prediction$partition)) < 2L) {
        return(NaN)
      }
      mean(silhouette(prediction$partition, d)[, "sil_width"])
    }
  )
)

#' @title Rousseeuw's Silhouette Quality Index
#'
#' @description
#' The Silhouette Width measures how well each observation fits within its assigned cluster compared to neighboring
#' clusters. For each observation, the silhouette value is defined as
#' \eqn{s(i) = (b(i) - a(i)) / \max(a(i), b(i))}{s(i) = (b(i) - a(i)) / max(a(i), b(i))}
#' where \eqn{a(i)} is the average distance to all other observations in the same cluster and \eqn{b(i)} is the
#' minimum average distance to observations in any other cluster. The score returned is the mean silhouette width
#' across all observations. Values close to 1 indicate well-clustered observations, values near 0 indicate
#' observations on cluster boundaries, and negative values indicate possible misclassification.
#'
#' @templateVar id silhouette
#' @template measure_sil
#'
#' @references
#' `r format_bib("rousseeuw1987silhouettes")`
NULL

#' @title Calinski Harabasz Pseudo F-Statistic
#'
#' @description
#' The Calinski-Harabasz index (also known as the Variance Ratio Criterion) is the ratio of between-cluster variance
#' to within-cluster variance, adjusted for the number of clusters and observations. It is defined as
#' \eqn{CH = \frac{\mathrm{tr}(B) / (k - 1)}{\mathrm{tr}(W) / (n - k)}}{CH = (tr(B) / (k - 1)) / (tr(W) / (n - k))}
#' where \eqn{B} is the between-cluster scatter matrix, \eqn{W} is the within-cluster scatter matrix, \eqn{k} is
#' the number of clusters, and \eqn{n} is the number of observations. Higher values indicate better-defined clusters.
#'
#' @templateVar id ch
#' @template measure_internal
#'
#' @references
#' `r format_bib("calinski1974dendrite")`
measures$ch = make_measure_info(cluster_ch, lower = 0, upper = Inf, minimize = FALSE, input = "data")

#' @title Dunn Index
#'
#' @description
#' The Dunn index is the ratio of the smallest inter-cluster distance to the largest intra-cluster diameter, defined
#' as \eqn{D = \min_{i \neq j} \delta(C_i, C_j) / \max_k \Delta(C_k)}{D = min(separation) / max(diameter)}
#' where \eqn{\delta(C_i, C_j)}{separation} is the minimum distance between clusters \eqn{i} and \eqn{j}, and
#' \eqn{\Delta(C_k)}{diameter} is the maximum distance between any two observations in cluster \eqn{k}. Higher
#' values indicate compact, well-separated clusters.
#'
#' @templateVar id dunn
#' @template measure_internal
#'
#' @references
#' `r format_bib("dunn1974well")`
measures$dunn = make_measure_info(cluster_dunn, lower = 0, upper = Inf, minimize = FALSE, input = "dist")

#' @title Within Sum of Squares
#'
#' @description
#' The total within-cluster sum of squares measures the compactness of the clustering by summing the squared
#' Euclidean distances of each observation to its cluster centroid across all clusters:
#' \eqn{WSS = \sum_{k=1}^{K} \sum_{i \in C_k} \| x_i - \mu_k \|^2}{WSS = sum over all clusters of sum of
#' squared distances to centroid}. Lower values indicate tighter clusters.
#'
#' @templateVar id wss
#' @template measure_internal
measures$wss = make_measure_info(
  cluster_wss,
  lower = 0,
  upper = Inf,
  minimize = TRUE,
  input = "data",
  requires_k2 = FALSE
)

#' @title Dunn2 Index
#'
#' @description
#' An alternative formulation of the Dunn index that uses average distances instead of extremes. It is defined as the
#' ratio of the minimum average between-cluster distance to the maximum average within-cluster distance:
#' \eqn{D_2 = \min_{i \neq j} \bar{d}(C_i, C_j) / \max_k \bar{d}(C_k)}{D2 = min(avg between) / max(avg within)}.
#' This variant is more robust to outliers than the standard Dunn index. Higher values indicate better separation.
#'
#' @templateVar id dunn2
#' @template measure_internal
#'
#' @references
#' `r format_bib("dunn1974well")`
measures$dunn2 = make_measure_info(cluster_dunn2, lower = 0, upper = Inf, minimize = FALSE, input = "dist")

#' @title Within/Between Ratio
#'
#' @description
#' The ratio of the average within-cluster distance to the average between-cluster distance. The average
#' within-cluster distance is the weighted mean of all pairwise distances within each cluster, and the average
#' between-cluster distance is the mean of all pairwise distances between observations in different clusters. Lower
#' values indicate compact clusters that are well separated from each other.
#'
#' @templateVar id wb_ratio
#' @template measure_internal
measures$wb_ratio = make_measure_info(cluster_wb_ratio, lower = 0, upper = Inf, minimize = TRUE, input = "dist")

#' @title Entropy
#'
#' @description
#' The Shannon entropy of the cluster size distribution, defined as
#' \eqn{H = -\sum_{k=1}^{K} p_k \log(p_k)}{H = -sum(p_k * log(p_k))}
#' where \eqn{p_k = n_k / n} is the proportion of observations in cluster \eqn{k}. Lower values indicate more
#' uneven cluster sizes (with 0 for a single cluster), while higher values indicate more uniform sizes. This measure
#' does not evaluate cluster quality directly but characterizes the balance of the partition.
#'
#' @templateVar id entropy
#' @template measure_internal
measures$entropy = make_measure_info(
  cluster_entropy,
  lower = 0,
  upper = Inf,
  minimize = TRUE,
  input = "none",
  requires_k2 = FALSE
)

#' @title Pearson Gamma
#'
#' @description
#' The Pearson correlation between pairwise distances and a binary indicator of whether two observations belong to
#' different clusters. All within-cluster distances are paired with indicator 0, and all between-cluster distances
#' with indicator 1. Values close to 1 indicate that between-cluster distances tend to be larger than within-cluster
#' distances, suggesting well-separated clusters.
#'
#' @templateVar id pearsongamma
#' @template measure_internal
measures$pearsongamma = make_measure_info(cluster_pearsongamma, lower = -1, upper = 1, minimize = FALSE, input = "dist")

#' @title Davies-Bouldin Index
#'
#' @description
#' The Davies-Bouldin index measures the average similarity between each cluster and the cluster most similar to it,
#' where similarity is the ratio of within-cluster scatter to between-cluster separation. It is defined as
#' \eqn{DB = \frac{1}{k} \sum_{i=1}^{k} \max_{j \neq i} \frac{s_i + s_j}{d_{ij}}}{DB = (1/k) * sum(max((s_i +
#' s_j) / d_ij))} where \eqn{s_i} is the average distance of observations in cluster \eqn{i} to its centroid and
#' \eqn{d_{ij}} is the Euclidean distance between centroids \eqn{i} and \eqn{j}. Lower values indicate better
#' clustering.
#'
#' @templateVar id davies_bouldin
#' @template measure_internal
#'
#' @references
#' `r format_bib("davies1979cluster")`
measures$davies_bouldin = make_measure_info(
  cluster_davies_bouldin,
  lower = 0,
  upper = Inf,
  minimize = TRUE,
  input = "data"
)

#' @title Average Between-Cluster Distance
#'
#' @description
#' The mean of all pairwise distances between observations belonging to different clusters. Higher values indicate
#' greater separation between clusters. This measure is scale-dependent and is most useful for comparing clusterings
#' of the same dataset.
#'
#' @templateVar id avg_between
#' @template measure_internal
measures$avg_between = make_measure_info(cluster_avg_between, lower = 0, upper = Inf, minimize = FALSE, input = "dist")

#' @title Average Within-Cluster Distance
#'
#' @description
#' The weighted mean of average pairwise distances within each cluster, where weights are the cluster sizes. Lower
#' values indicate more compact clusters. This measure is scale-dependent and is most useful for comparing
#' clusterings of the same dataset.
#'
#' @templateVar id avg_within
#' @template measure_internal
measures$avg_within = make_measure_info(
  cluster_avg_within,
  lower = 0,
  upper = Inf,
  minimize = TRUE,
  input = "dist",
  requires_k2 = FALSE
)
