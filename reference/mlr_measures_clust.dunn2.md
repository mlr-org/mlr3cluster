# Dunn2 Index

An alternative formulation of the Dunn index that uses average distances
instead of extremes. It is defined as the ratio of the minimum average
between-cluster distance to the maximum average within-cluster distance:
\\D_2 = \min\_{i \neq j} \bar{d}(C_i, C_j) / \max_k \bar{d}(C_k)\\. This
variant is more robust to outliers than the standard Dunn index. Higher
values indicate better separation.

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

    mlr_measures$get("clust.dunn2")
    msr("clust.dunn2")

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
[`mlr_measures_clust.avg_between`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.avg_between.md),
[`mlr_measures_clust.avg_within`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.avg_within.md),
[`mlr_measures_clust.ch`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.ch.md),
[`mlr_measures_clust.davies_bouldin`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.davies_bouldin.md),
[`mlr_measures_clust.dunn`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn.md),
[`mlr_measures_clust.entropy`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.entropy.md),
[`mlr_measures_clust.pearsongamma`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.pearsongamma.md),
[`mlr_measures_clust.silhouette`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.silhouette.md),
[`mlr_measures_clust.wb_ratio`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wb_ratio.md),
[`mlr_measures_clust.wss`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wss.md)
