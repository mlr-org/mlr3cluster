# Within Sum of Squares

The total within-cluster sum of squares measures the compactness of the
clustering by summing the squared Euclidean distances of each
observation to its cluster centroid across all clusters: \\WSS =
\sum\_{k=1}^{K} \sum\_{i \in C_k} \\ x_i - \mu_k \\^2\\. Lower values
indicate tighter clusters.

## Dictionary

This [mlr3::Measure](https://mlr3.mlr-org.com/reference/Measure.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html)
or with the associated sugar function
[`mlr3::msr()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_measures$get("clust.wss")
    msr("clust.wss")

## Meta Information

- Task type: “clust”

- Range: \\\[0, \infty)\\

- Minimize: TRUE

- Average: macro

- Required Prediction: “partition”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster)

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
[`mlr_measures_clust.silhouette`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.silhouette.md),
[`mlr_measures_clust.wb_ratio`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.wb_ratio.md)
