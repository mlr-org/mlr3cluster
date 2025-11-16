# Convert to a Cluster Task

Convert object to a
[TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md).
This is a S3 generic, specialized for at least the following objects:

1.  [TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md):
    ensure the identity.

2.  [`data.frame()`](https://rdrr.io/r/base/data.frame.html) and
    [mlr3::DataBackend](https://mlr3.mlr-org.com/reference/DataBackend.html):
    provides an alternative to calling constructor of
    [TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md).

## Usage

``` r
as_task_clust(x, ...)

# S3 method for class 'TaskClust'
as_task_clust(x, clone = FALSE, ...)

# S3 method for class 'data.frame'
as_task_clust(x, id = deparse1(substitute(x)), ...)

# S3 method for class 'DataBackend'
as_task_clust(x, id = deparse1(substitute(x)), ...)

# S3 method for class 'formula'
as_task_clust(x, data, id = deparse1(substitute(data)), ...)
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
