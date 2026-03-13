# Dunn Index

The score function calls
[`fpc::cluster.stats()`](https://rdrr.io/pkg/fpc/man/cluster.stats.html)
from package [fpc](https://CRAN.R-project.org/package=fpc).

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
  [fpc](https://CRAN.R-project.org/package=fpc)

## See also

[Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html) of
[Measures](https://mlr3.mlr-org.com/reference/Measure.html):
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html)

`as.data.table(mlr_measures)` for a complete table of all (also
dynamically created)
[mlr3::Measure](https://mlr3.mlr-org.com/reference/Measure.html)
implementations.

Other cluster measures:
[`mlr_measures_clust.ch`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.ch.md),
[`mlr_measures_clust.silhouette`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.silhouette.md),
[`mlr_measures_clust.wss`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_measures_clust.wss.md)
