# Cluster Task

This task specializes
[mlr3::Task](https://mlr3.mlr-org.com/reference/Task.html) for cluster
problems. As an unsupervised task, this task has no target column. The
`task_type` is set to `"clust"`.

Predefined tasks are stored in the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_tasks](https://mlr3.mlr-org.com/reference/mlr_tasks.html).

## See also

Other Task:
[`mlr_tasks_ruspini`](https://mlr3cluster.mlr-org.com/reference/mlr_tasks_ruspini.md),
[`mlr_tasks_usarrests`](https://mlr3cluster.mlr-org.com/reference/mlr_tasks_usarrests.md)

## Super classes

[`mlr3::Task`](https://mlr3.mlr-org.com/reference/Task.html) -\>
[`mlr3::TaskUnsupervised`](https://mlr3.mlr-org.com/reference/TaskUnsupervised.html)
-\> `TaskClust`

## Methods

### Public methods

- [`TaskClust$new()`](#method-TaskClust-new)

- [`TaskClust$clone()`](#method-TaskClust-clone)

Inherited methods

- [`mlr3::Task$add_strata()`](https://mlr3.mlr-org.com/reference/Task.html#method-add_strata)
- [`mlr3::Task$cbind()`](https://mlr3.mlr-org.com/reference/Task.html#method-cbind)
- [`mlr3::Task$data()`](https://mlr3.mlr-org.com/reference/Task.html#method-data)
- [`mlr3::Task$divide()`](https://mlr3.mlr-org.com/reference/Task.html#method-divide)
- [`mlr3::Task$droplevels()`](https://mlr3.mlr-org.com/reference/Task.html#method-droplevels)
- [`mlr3::Task$filter()`](https://mlr3.mlr-org.com/reference/Task.html#method-filter)
- [`mlr3::Task$format()`](https://mlr3.mlr-org.com/reference/Task.html#method-format)
- [`mlr3::Task$formula()`](https://mlr3.mlr-org.com/reference/Task.html#method-formula)
- [`mlr3::Task$head()`](https://mlr3.mlr-org.com/reference/Task.html#method-head)
- [`mlr3::Task$help()`](https://mlr3.mlr-org.com/reference/Task.html#method-help)
- [`mlr3::Task$levels()`](https://mlr3.mlr-org.com/reference/Task.html#method-levels)
- [`mlr3::Task$materialize_view()`](https://mlr3.mlr-org.com/reference/Task.html#method-materialize_view)
- [`mlr3::Task$missings()`](https://mlr3.mlr-org.com/reference/Task.html#method-missings)
- [`mlr3::Task$print()`](https://mlr3.mlr-org.com/reference/Task.html#method-print)
- [`mlr3::Task$rbind()`](https://mlr3.mlr-org.com/reference/Task.html#method-rbind)
- [`mlr3::Task$rename()`](https://mlr3.mlr-org.com/reference/Task.html#method-rename)
- [`mlr3::Task$select()`](https://mlr3.mlr-org.com/reference/Task.html#method-select)
- [`mlr3::Task$set_col_roles()`](https://mlr3.mlr-org.com/reference/Task.html#method-set_col_roles)
- [`mlr3::Task$set_levels()`](https://mlr3.mlr-org.com/reference/Task.html#method-set_levels)
- [`mlr3::Task$set_row_roles()`](https://mlr3.mlr-org.com/reference/Task.html#method-set_row_roles)

------------------------------------------------------------------------

### Method `new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    TaskClust$new(id, backend, label = NA_character_)

#### Arguments

- `id`:

  (`character(1)`)  
  Identifier for the new instance.

- `backend`:

  ([mlr3::DataBackend](https://mlr3.mlr-org.com/reference/DataBackend.html))  
  Either a
  [mlr3::DataBackend](https://mlr3.mlr-org.com/reference/DataBackend.html),
  or any object which is convertible to a
  [mlr3::DataBackend](https://mlr3.mlr-org.com/reference/DataBackend.html)
  with
  [`as_data_backend()`](https://mlr3.mlr-org.com/reference/as_data_backend.html).
  E.g., a [`data.frame()`](https://rdrr.io/r/base/data.frame.html) will
  be converted to a
  [mlr3::DataBackendDataTable](https://mlr3.mlr-org.com/reference/DataBackendDataTable.html).

- `label`:

  (`character(1)`)  
  Label for the new instance.

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    TaskClust$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
library(mlr3)
library(mlr3cluster)
task = TaskClust$new("usarrests", backend = USArrests)
task$task_type
#> [1] "clust"

# possible properties:
mlr_reflections$task_properties$clust
#> [1] "strata"          "groups"          "offset"          "weights_learner"
#> [5] "weights_measure"
```
