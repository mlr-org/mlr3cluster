# Cluster Measure

This measure specializes
[mlr3::Measure](https://mlr3.mlr-org.com/reference/Measure.html) for
cluster analysis:

- `task_type` is set to `"clust"`.

- Possible values for `predict_type` are `"partition"` and `"prob"`.

Predefined measures can be found in the
[mlr3misc::Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_measures](https://mlr3.mlr-org.com/reference/mlr_measures.html).

## See also

Example cluster measures:
[`clust.dunn`](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn.md)

## Super class

[`mlr3::Measure`](https://mlr3.mlr-org.com/reference/Measure.html) -\>
`MeasureClust`

## Methods

### Public methods

- [`MeasureClust$new()`](#method-MeasureClust-new)

Inherited methods

- [`mlr3::Measure$aggregate()`](https://mlr3.mlr-org.com/reference/Measure.html#method-aggregate)
- [`mlr3::Measure$format()`](https://mlr3.mlr-org.com/reference/Measure.html#method-format)
- [`mlr3::Measure$help()`](https://mlr3.mlr-org.com/reference/Measure.html#method-help)
- [`mlr3::Measure$print()`](https://mlr3.mlr-org.com/reference/Measure.html#method-print)
- [`mlr3::Measure$score()`](https://mlr3.mlr-org.com/reference/Measure.html#method-score)

------------------------------------------------------------------------

### Method `new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    MeasureClust$new(
      id,
      range,
      minimize = NA,
      aggregator = NULL,
      properties = character(),
      predict_type = "partition",
      task_properties = character(),
      packages = character(),
      label = NA_character_,
      man = NA_character_
    )

#### Arguments

- `id`:

  (`character(1)`)  
  Identifier for the new instance.

- `range`:

  (`numeric(2)`)  
  Feasible range for this measure as `c(lower_bound, upper_bound)`. Both
  bounds may be infinite.

- `minimize`:

  (`logical(1)`)  
  Set to `TRUE` if good predictions correspond to small values, and to
  `FALSE` if good predictions correspond to large values. If set to `NA`
  (default), tuning this measure is not possible.

- `aggregator`:

  (`function(x)`)  
  Function to aggregate individual performance scores `x` where `x` is a
  numeric vector. If `NULL`, defaults to
  [`mean()`](https://rdrr.io/r/base/mean.html).

- `properties`:

  ([`character()`](https://rdrr.io/r/base/character.html))  
  Properties of the measure. Must be a subset of
  [mlr_reflections\$measure_properties](https://mlr3.mlr-org.com/reference/mlr_reflections.html).
  Supported by `mlr3`:

  - `"requires_task"` (requires the complete
    [mlr3::Task](https://mlr3.mlr-org.com/reference/Task.html)),

  - `"requires_learner"` (requires the trained
    [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)),

  - `"requires_train_set"` (requires the training indices from the
    [mlr3::Resampling](https://mlr3.mlr-org.com/reference/Resampling.html)),
    and

  - `"na_score"` (the measure is expected to occasionally return `NA` or
    `NaN`).

- `predict_type`:

  (`character(1)`)  
  Required predict type of the
  [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html).
  Possible values are stored in
  [mlr_reflections\$learner_predict_types](https://mlr3.mlr-org.com/reference/mlr_reflections.html).

- `task_properties`:

  ([`character()`](https://rdrr.io/r/base/character.html))  
  Required task properties, see
  [mlr3::Task](https://mlr3.mlr-org.com/reference/Task.html).

- `packages`:

  ([`character()`](https://rdrr.io/r/base/character.html))  
  Set of required packages. A warning is signaled by the constructor if
  at least one of the packages is not installed, but loaded (not
  attached) later on-demand via
  [`requireNamespace()`](https://rdrr.io/r/base/ns-load.html).

- `label`:

  (`character(1)`)  
  Label for the new instance.

- `man`:

  (`character(1)`)  
  String in the format `[pkg]::[topic]` pointing to a manual page for
  this object. The referenced help package can be opened via method
  `$help()`.
