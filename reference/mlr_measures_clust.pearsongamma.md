# Pearson Gamma

The Pearson correlation between pairwise distances and a binary
indicator of whether two observations belong to different clusters. All
within-cluster distances are paired with indicator 0, and all
between-cluster distances with indicator 1. Values close to 1 indicate
that between-cluster distances tend to be larger than within-cluster
distances, suggesting well-separated clusters.

## Details

If the task contains factor or ordered features, Gower distances
([`cluster::daisy()`](https://rdrr.io/pkg/cluster/man/daisy.html)) are
used instead of Euclidean distances.

## Dictionary

This [mlr3::Measure](https://mlr3.mlr-org.com/reference/Measure.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html)
or with the associated sugar function
[`mlr3::msr()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_measures$get("clust.pearsongamma")
    msr("clust.pearsongamma")

## Meta Information

- Task type: “clust”

- Range: \\\[-1, 1\]\\

- Minimize: FALSE

- Average: macro

- Required Prediction: “partition”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [cluster](https://CRAN.R-project.org/package=cluster)

## See also

[Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html) of
[Measures](https://mlr3.mlr-org.com/reference/Measure.html):
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html)

`as.data.table(mlr_measures)` for a complete table of all (also
dynamically created)
[mlr3::Measure](https://mlr3.mlr-org.com/reference/Measure.html)
implementations.

Other cluster measures:
[`mlr_measures_clust.avg_between`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.avg_between.md),
[`mlr_measures_clust.avg_within`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.avg_within.md),
[`mlr_measures_clust.ch`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.ch.md),
[`mlr_measures_clust.davies_bouldin`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.davies_bouldin.md),
[`mlr_measures_clust.dunn`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn.md),
[`mlr_measures_clust.dunn2`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn2.md),
[`mlr_measures_clust.entropy`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.entropy.md),
[`mlr_measures_clust.silhouette`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.silhouette.md),
[`mlr_measures_clust.wb_ratio`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wb_ratio.md),
[`mlr_measures_clust.wss`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wss.md)
