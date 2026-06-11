# Davies-Bouldin Index

The Davies-Bouldin index measures the average similarity between each
cluster and the cluster most similar to it, where similarity is the
ratio of within-cluster scatter to between-cluster separation. It is
defined as \\DB = \frac{1}{k} \sum\_{i=1}^{k} \max\_{j \neq i}
\frac{s_i + s_j}{d\_{ij}}\\ where \\s_i\\ is the average distance of
observations in cluster \\i\\ to its centroid and \\d\_{ij}\\ is the
Euclidean distance between centroids \\i\\ and \\j\\. Lower values
indicate better clustering.

## Dictionary

This [mlr3::Measure](https://mlr3.mlr-org.com/reference/Measure.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html)
or with the associated sugar function
[`mlr3::msr()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_measures$get("clust.davies_bouldin")
    msr("clust.davies_bouldin")

## Meta Information

- Task type: “clust”

- Range: \\\[0, \infty)\\

- Minimize: TRUE

- Average: macro

- Required Prediction: “partition”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster)

## References

Davies, L D, Bouldin, W D (1979). “A cluster separation measure.” *IEEE
Transactions on Pattern Analysis and Machine Intelligence*,
**PAMI-1**(2), 224–227.
[doi:10.1109/TPAMI.1979.4766909](https://doi.org/10.1109/TPAMI.1979.4766909)
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
[`mlr_measures_clust.dunn`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn.md),
[`mlr_measures_clust.dunn2`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn2.md),
[`mlr_measures_clust.entropy`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.entropy.md),
[`mlr_measures_clust.pearsongamma`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.pearsongamma.md),
[`mlr_measures_clust.silhouette`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.silhouette.md),
[`mlr_measures_clust.wb_ratio`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wb_ratio.md),
[`mlr_measures_clust.wss`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wss.md)
