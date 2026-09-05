# Gaussian Blobs Cluster Task Generator

A [TaskGenerator](https://mlr3.mlr-org.com/reference/TaskGenerator.html)
for isotropic Gaussian blobs, in the spirit of
`sklearn.datasets.make_blobs()`. `k` cluster centers are drawn uniformly
from the hypercube `[-center_box, center_box]^d`, and the `n`
observations are assigned to the centers in a balanced fashion and
perturbed with Gaussian noise of standard deviation `sd` in each of the
`d` dimensions. The generated
[TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md)
only contains the numeric features `x1`, ..., `xd`; the cluster
membership is not stored in the task.

## Dictionary

This
[TaskGenerator](https://mlr3.mlr-org.com/reference/TaskGenerator.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr_task_generators](https://mlr3.mlr-org.com/reference/mlr_task_generators.html)
or with the associated sugar function
[tgen()](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_task_generators$get("blobs")
    tgen("blobs")

## Parameters

|            |         |         |                  |
|------------|---------|---------|------------------|
| Id         | Type    | Default | Range            |
| k          | integer | 3       | \\\[1, \infty)\\ |
| d          | integer | 2       | \\\[1, \infty)\\ |
| sd         | numeric | 1       | \\\[0, \infty)\\ |
| center_box | numeric | 10      | \\\[0, \infty)\\ |

## See also

- [Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
  of
  [TaskGenerators](https://mlr3.mlr-org.com/reference/TaskGenerator.html):
  [mlr3::mlr_task_generators](https://mlr3.mlr-org.com/reference/mlr_task_generators.html)

- `as.data.table(mlr_task_generators)` for a table of available
  [TaskGenerators](https://mlr3.mlr-org.com/reference/TaskGenerator.html)
  in the running session (depending on the loaded packages).

## Super class

[`mlr3::TaskGenerator`](https://mlr3.mlr-org.com/reference/TaskGenerator.html)
-\> `TaskGeneratorBlobs`

## Methods

### Public methods

- [`TaskGeneratorBlobs$new()`](#method-TaskGeneratorBlobs-initialize)

- [`TaskGeneratorBlobs$plot()`](#method-TaskGeneratorBlobs-plot)

- [`TaskGeneratorBlobs$clone()`](#method-TaskGeneratorBlobs-clone)

Inherited methods

- [`mlr3::TaskGenerator$format()`](https://mlr3.mlr-org.com/reference/TaskGenerator.html#method-format)
- [`mlr3::TaskGenerator$generate()`](https://mlr3.mlr-org.com/reference/TaskGenerator.html#method-generate)
- [`mlr3::TaskGenerator$print()`](https://mlr3.mlr-org.com/reference/TaskGenerator.html#method-print)

------------------------------------------------------------------------

### `TaskGeneratorBlobs$new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    TaskGeneratorBlobs$new()

------------------------------------------------------------------------

### `TaskGeneratorBlobs$plot()`

Creates a simple plot of the first two features of generated data,
colored by cluster membership.

#### Usage

    TaskGeneratorBlobs$plot(n = 200L, pch = 19L, ...)

#### Arguments

- `n`:

  (`integer(1)`)  
  Number of samples to draw for the plot. Default is 200.

- `pch`:

  (`integer(1)`)  
  Point char. Passed to
  [`graphics::plot()`](https://rdrr.io/r/graphics/plot.default.html).

- `...`:

  (any)  
  Additional arguments passed to
  [`graphics::plot()`](https://rdrr.io/r/graphics/plot.default.html).

------------------------------------------------------------------------

### `TaskGeneratorBlobs$clone()`

The objects of this class are cloneable with this method.

#### Usage

    TaskGeneratorBlobs$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
generator = tgen("blobs")
plot(generator, n = 200)


task = generator$generate(200)
str(task$data())
#> Classes ‘data.table’ and 'data.frame':   200 obs. of  2 variables:
#>  $ x1: num  -1.9 -11.38 -1.78 -3.96 -10.63 ...
#>  $ x2: num  2.824 1.495 -8.203 0.767 0.372 ...
#>  - attr(*, ".internal.selfref")=<pointer: 0x5651ec502a30> 

# 4 well separated clusters in 3 dimensions
generator = tgen("blobs", k = 4, d = 3, sd = 0.5)
task = generator$generate(500)
task
#> 
#> ── <TaskClust> (500x3) ─────────────────────────────────────────────────────────
#> • Target:
#> • Properties: -
#> • Features (3):
#>   • dbl (3): x1, x2, x3
```
