# Convert to a Cluster Task

Convert object to a
[TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md)
or a list of
[TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md).
This is a S3 generic, specialized for at least the following objects:

1.  [TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md):
    returns the object as-is, possibly cloned.

2.  [`formula`](https://rdrr.io/r/stats/formula.html),
    [`data.frame()`](https://rdrr.io/r/base/data.frame.html),
    [`matrix()`](https://rdrr.io/r/base/matrix.html), and
    [mlr3::DataBackend](https://mlr3.mlr-org.com/reference/DataBackend.html):
    provides an alternative to the constructor of
    [TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md).

## Usage

``` r
as_task_clust(x, ...)

# S3 method for class 'TaskClust'
as_task_clust(x, clone = FALSE, ...)

# S3 method for class 'data.frame'
as_task_clust(x, id = deparse1(substitute(x)), label = NA_character_, ...)

# S3 method for class 'matrix'
as_task_clust(x, id = deparse1(substitute(x)), label = NA_character_, ...)

# S3 method for class 'DataBackend'
as_task_clust(x, id = deparse1(substitute(x)), label = NA_character_, ...)

# S3 method for class 'formula'
as_task_clust(
  x,
  data,
  id = deparse1(substitute(data)),
  label = NA_character_,
  ...
)

as_tasks_clust(x, ...)

# S3 method for class 'list'
as_tasks_clust(x, clone = FALSE, ...)

# S3 method for class 'TaskClust'
as_tasks_clust(x, clone = FALSE, ...)
```

## Arguments

- x:

  (any)  
  Object to convert.

- ...:

  (any)  
  Additional arguments.

- clone:

  (`logical(1)`)  
  If `TRUE`, ensures that the returned object is not the same as the
  input `x`.

- id:

  (`character(1)`)  
  Id for the new task. Defaults to the (deparsed and substituted) name
  of the data argument.

- label:

  (`character(1)`)  
  Label for the new instance.

- data:

  ([`data.frame()`](https://rdrr.io/r/base/data.frame.html))  
  Data frame containing all columns specified in formula `x`.

## Value

[TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md).

## Examples

``` r
as_task_clust(datasets::USArrests)
#> 
#> ── <TaskClust> (50x4) ──────────────────────────────────────────────────────────
#> • Target:
#> • Properties: -
#> • Features (4):
#>   • int (2): Assault, UrbanPop
#>   • dbl (2): Murder, Rape
```
