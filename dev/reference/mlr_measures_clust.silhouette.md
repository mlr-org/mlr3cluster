# Rousseeuw's Silhouette Quality Index

The Silhouette Width measures how well each observation fits within its
assigned cluster compared to neighboring clusters. For each observation,
the silhouette value is defined as \\s(i) = (b(i) - a(i)) / \max(a(i),
b(i))\\ where \\a(i)\\ is the average distance to all other observations
in the same cluster and \\b(i)\\ is the minimum average distance to
observations in any other cluster. The score returned is the mean
silhouette width across all observations. Values close to 1 indicate
well-clustered observations, values near 0 indicate observations on
cluster boundaries, and negative values indicate possible
misclassification.

The score function calls
[`cluster::silhouette()`](https://rdrr.io/pkg/cluster/man/silhouette.html)
from package [cluster](https://CRAN.R-project.org/package=cluster).

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

    mlr_measures$get("clust.silhouette")
    msr("clust.silhouette")

## Meta Information

- Task type: “clust”

- Range: \\\[-1, 1\]\\

- Minimize: FALSE

- Average: macro

- Required Prediction: “partition”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [cluster](https://CRAN.R-project.org/package=cluster)

## References

Rousseeuw, J P (1987). “Silhouettes: A graphical aid to the
interpretation and validation of cluster analysis.” *Journal of
Computational and Applied Mathematics*, **20**, 53–65.
[doi:10.1016/0377-0427(87)90125-7](https://doi.org/10.1016/0377-0427%2887%2990125-7)
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
[`mlr_measures_clust.dunn`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.dunn.md),
[`mlr_measures_clust.dunn2`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.dunn2.md),
[`mlr_measures_clust.entropy`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.entropy.md),
[`mlr_measures_clust.pearsongamma`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.pearsongamma.md),
[`mlr_measures_clust.wb_ratio`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.wb_ratio.md),
[`mlr_measures_clust.wss`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.wss.md)
