# Moons Cluster Task Generator

A [TaskGenerator](https://mlr3.mlr-org.com/reference/TaskGenerator.html)
for two interleaving half circles ("moons"), in the spirit of
`sklearn.datasets.make_moons()`. The `n` observations are split evenly
between an upper half circle centered at the origin and a lower half
circle shifted to the right and down so that the two arcs interleave.
Each observation is perturbed with Gaussian noise of standard deviation
`sd`. The generated
[TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md)
only contains the numeric features `x1` and `x2`; the cluster membership
is not stored in the task. The parameter `sd` is initialized to `0.1`.

The clusters are not convex, which makes this generator a standard test
case for density-based and connectivity-based methods such as DBSCAN,
single linkage or spectral clustering, where centroid-based methods such
as k-means fail.

## Dictionary

This
[TaskGenerator](https://mlr3.mlr-org.com/reference/TaskGenerator.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr_task_generators](https://mlr3.mlr-org.com/reference/mlr_task_generators.html)
or with the associated sugar function
[tgen()](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_task_generators$get("moons")
    tgen("moons")

## Parameters

|     |         |         |                  |
|-----|---------|---------|------------------|
| Id  | Type    | Default | Range            |
| sd  | numeric | \-      | \\\[0, \infty)\\ |

## See also

- [Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
  of
  [TaskGenerators](https://mlr3.mlr-org.com/reference/TaskGenerator.html):
  [mlr3::mlr_task_generators](https://mlr3.mlr-org.com/reference/mlr_task_generators.html)

- `as.data.table(mlr_task_generators)` for a table of available
  [TaskGenerators](https://mlr3.mlr-org.com/reference/TaskGenerator.html)
  in the running session (depending on the loaded packages).

Other TaskGenerator:
[`mlr_task_generators_blobs`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_task_generators_blobs.md)

## Super class

[`mlr3::TaskGenerator`](https://mlr3.mlr-org.com/reference/TaskGenerator.html)
-\> `TaskGeneratorMoons`

## Methods

### Public methods

- [`TaskGeneratorMoons$new()`](#method-TaskGeneratorMoons-initialize)

- [`TaskGeneratorMoons$plot()`](#method-TaskGeneratorMoons-plot)

- [`TaskGeneratorMoons$clone()`](#method-TaskGeneratorMoons-clone)

Inherited methods

- [`mlr3::TaskGenerator$format()`](https://mlr3.mlr-org.com/reference/TaskGenerator.html#method-format)
- [`mlr3::TaskGenerator$generate()`](https://mlr3.mlr-org.com/reference/TaskGenerator.html#method-generate)
- [`mlr3::TaskGenerator$print()`](https://mlr3.mlr-org.com/reference/TaskGenerator.html#method-print)

------------------------------------------------------------------------

### `TaskGeneratorMoons$new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    TaskGeneratorMoons$new()

------------------------------------------------------------------------

### `TaskGeneratorMoons$plot()`

Creates a simple plot of generated data, colored by cluster membership.

#### Usage

    TaskGeneratorMoons$plot(n = 200L, pch = 19L, ...)

#### Arguments

- `n`:

  (`integer(1)`)  
  Number of samples to draw for the plot. Default is `200`.

- `pch`:

  (`integer(1)`)  
  Point char. Passed to
  [`graphics::plot()`](https://rdrr.io/r/graphics/plot.default.html).

- `...`:

  (any)  
  Additional arguments passed to
  [`graphics::plot()`](https://rdrr.io/r/graphics/plot.default.html).

------------------------------------------------------------------------

### `TaskGeneratorMoons$clone()`

The objects of this class are cloneable with this method.

#### Usage

    TaskGeneratorMoons$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
generator = tgen("moons")
plot(generator, n = 200)


task = generator$generate(200)
str(task$data())
#> Classes ‘data.table’ and 'data.frame':   200 obs. of  2 variables:
#>  $ x1: num  0.587 1.677 -0.422 1.701 -0.422 ...
#>  $ x2: num  0.748 -0.445 0.84 -0.156 0.936 ...
#>  - attr(*, ".internal.selfref")=<pointer: 0x557141b75a30> 
```
