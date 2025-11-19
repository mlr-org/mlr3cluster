# Calinski Harabasz Pseudo F-Statistic

The score function calls
[`fpc::cluster.stats()`](https://rdrr.io/pkg/fpc/man/cluster.stats.html)
from package [fpc](https://CRAN.R-project.org/package=fpc). "ch" is used
subset output of the function call.

## Format

[`R6::R6Class()`](https://r6.r-lib.org/reference/R6Class.html)
inheriting from
[MeasureClust](https://mlr3cluster.mlr-org.com/reference/MeasureClust.md).

## Construction

This measures can be retrieved from the dictionary
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html):

    mlr_measures$get("clust.ch")
    msr("clust.ch")

## Meta Information

- Range: \\\[0, \infty)\\

- Minimize: `FALSE`

- Required predict type: `partition`

## See also

[Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html) of
[Measures](https://mlr3.mlr-org.com/reference/Measure.html):
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html)

`as.data.table(mlr_measures)` for a complete table of all (also
dynamically created)
[mlr3::Measure](https://mlr3.mlr-org.com/reference/Measure.html)
implementations.

Other cluster measures:
[`mlr_measures_clust.dunn`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn.md),
[`mlr_measures_clust.silhouette`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.silhouette.md),
[`mlr_measures_clust.wss`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wss.md)
