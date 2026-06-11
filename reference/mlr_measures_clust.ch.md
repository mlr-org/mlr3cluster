# Calinski Harabasz Pseudo F-Statistic

The Calinski-Harabasz index (also known as the Variance Ratio Criterion)
is the ratio of between-cluster variance to within-cluster variance,
adjusted for the number of clusters and observations. It is defined as
\\CH = \frac{\mathrm{tr}(B) / (k - 1)}{\mathrm{tr}(W) / (n - k)}\\ where
\\B\\ is the between-cluster scatter matrix, \\W\\ is the within-cluster
scatter matrix, \\k\\ is the number of clusters, and \\n\\ is the number
of observations. Higher values indicate better-defined clusters.

## Dictionary

This [mlr3::Measure](https://mlr3.mlr-org.com/reference/Measure.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html)
or with the associated sugar function
[`mlr3::msr()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_measures$get("clust.ch")
    msr("clust.ch")

## Meta Information

- Task type: “clust”

- Range: \\\[0, \infty)\\

- Minimize: FALSE

- Average: macro

- Required Prediction: “partition”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster)

## References

Caliński, Tadeusz, Harabasz, Jerzy (1974). “A dendrite method for
cluster analysis.” *Communications in Statistics*, **3**(1), 1–27.
[doi:10.1080/03610927408827101](https://doi.org/10.1080/03610927408827101)
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
[`mlr_measures_clust.davies_bouldin`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.davies_bouldin.md),
[`mlr_measures_clust.dunn`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn.md),
[`mlr_measures_clust.dunn2`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn2.md),
[`mlr_measures_clust.entropy`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.entropy.md),
[`mlr_measures_clust.pearsongamma`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.pearsongamma.md),
[`mlr_measures_clust.silhouette`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.silhouette.md),
[`mlr_measures_clust.wb_ratio`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wb_ratio.md),
[`mlr_measures_clust.wss`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wss.md)
