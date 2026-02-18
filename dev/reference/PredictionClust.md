# Prediction Object for Cluster Analysis

This object wraps the predictions returned by a learner of class
[LearnerClust](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.md),
i.e. the predicted partition and cluster probability.

## Super class

[`mlr3::Prediction`](https://mlr3.mlr-org.com/reference/Prediction.html)
-\> `PredictionClust`

## Active bindings

- `partition`:

  ([`integer()`](https://rdrr.io/r/base/integer.html))  
  Access the stored partition.

- `prob`:

  ([`matrix()`](https://rdrr.io/r/base/matrix.html) \| `NULL`)  
  Access to the stored probabilities.

## Methods

### Public methods

- [`PredictionClust$new()`](#method-PredictionClust-new)

- [`PredictionClust$clone()`](#method-PredictionClust-clone)

Inherited methods

- [`mlr3::Prediction$filter()`](https://mlr3.mlr-org.com/reference/Prediction.html#method-filter)
- [`mlr3::Prediction$format()`](https://mlr3.mlr-org.com/reference/Prediction.html#method-format)
- [`mlr3::Prediction$help()`](https://mlr3.mlr-org.com/reference/Prediction.html#method-help)
- [`mlr3::Prediction$obs_loss()`](https://mlr3.mlr-org.com/reference/Prediction.html#method-obs_loss)
- [`mlr3::Prediction$print()`](https://mlr3.mlr-org.com/reference/Prediction.html#method-print)
- [`mlr3::Prediction$score()`](https://mlr3.mlr-org.com/reference/Prediction.html#method-score)

------------------------------------------------------------------------

### Method `new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    PredictionClust$new(
      task = NULL,
      row_ids = task$row_ids,
      partition = NULL,
      prob = NULL,
      check = TRUE
    )

#### Arguments

- `task`:

  ([TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md)
  \| `NULL`)  
  Task, used to extract defaults for `row_ids`.

- `row_ids`:

  ([`integer()`](https://rdrr.io/r/base/integer.html))  
  Row ids of the predicted observations, i.e. the row ids of the test
  set.

- `partition`:

  ([`integer()`](https://rdrr.io/r/base/integer.html) \| `NULL`)  
  Vector of cluster partitions.

- `prob`:

  ([`matrix()`](https://rdrr.io/r/base/matrix.html) \| `NULL`)  
  Numeric matrix of cluster membership probabilities with one column for
  each cluster and one row for each observation. Columns must be named
  with cluster numbers, row names are automatically removed. If `prob`
  is provided, but `partition` is not, the cluster memberships are
  calculated from the probabilities using
  [`max.col()`](https://rdrr.io/r/base/maxCol.html) with `ties.method`
  set to `"first"`.

- `check`:

  (`logical(1)`)  
  If `TRUE`, performs some argument checks and predict type conversions.

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    PredictionClust$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
library(mlr3)
library(mlr3cluster)
task = tsk("usarrests")
learner = lrn("clust.kmeans")
p = learner$train(task)$predict(task)
p$predict_types
#> [1] "partition"
head(as.data.table(p))
#>    row_ids partition
#>      <int>     <int>
#> 1:       1         1
#> 2:       2         1
#> 3:       3         1
#> 4:       4         1
#> 5:       5         1
#> 6:       6         1
```
