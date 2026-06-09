# Dunn Index

The Dunn index is the ratio of the smallest inter-cluster distance to
the largest intra-cluster diameter, defined as \\D = \min\_{i \neq j}
\delta(C_i, C_j) / \max_k \Delta(C_k)\\ where \\\delta(C_i, C_j)\\ is
the minimum distance between clusters \\i\\ and \\j\\, and
\\\Delta(C_k)\\ is the maximum distance between any two observations in
cluster \\k\\. Higher values indicate compact, well-separated clusters.

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

    mlr_measures$get("clust.dunn")
    msr("clust.dunn")

## Meta Information

- Task type: “clust”

- Range: \\\[0, \infty)\\

- Minimize: FALSE

- Average: macro

- Required Prediction: “partition”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [cluster](https://CRAN.R-project.org/package=cluster)

## References

Dunn, C J (1974). “Well-separated clusters and optimal fuzzy
partitions.” *Journal of Cybernetics*, **4**(1), 95–104.
[doi:10.1080/01969727408546059](https://doi.org/10.1080/01969727408546059)
.

## See also

[Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html) of
[Measures](https://mlr3.mlr-org.com/reference/Measure.html):
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html)

`as.data.table(mlr_measures)` for a complete table of all (also
dynamically created)
[mlr3::Measure](https://mlr3.mlr-org.com/reference/Measure.html)
implementations.

Other cluster measures:
[`mlr_measures_clust.avg_between`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.avg_between.md),
[`mlr_measures_clust.avg_within`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.avg_within.md),
[`mlr_measures_clust.ch`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.ch.md),
[`mlr_measures_clust.davies_bouldin`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.davies_bouldin.md),
[`mlr_measures_clust.dunn2`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.dunn2.md),
[`mlr_measures_clust.entropy`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.entropy.md),
[`mlr_measures_clust.pearsongamma`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.pearsongamma.md),
[`mlr_measures_clust.silhouette`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.silhouette.md),
[`mlr_measures_clust.wb_ratio`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.wb_ratio.md),
[`mlr_measures_clust.wss`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.wss.md)
