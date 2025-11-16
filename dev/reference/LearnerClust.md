# Cluster Learner

This Learner specializes
[mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html) for
cluster problems:

- `task_type` is set to `"clust"`.

- Creates
  [mlr3::Prediction](https://mlr3.mlr-org.com/reference/Prediction.html)s
  of class
  [PredictionClust](https://mlr3cluster.mlr-org.com/dev/reference/PredictionClust.md).

- Possible values for `predict_types` are:

  - `"partition"`: Integer indicating the cluster membership.

  - `"prob"`: Probability for belonging to each cluster.

Predefined learners can be found in the
[mlr3misc::Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html).

## Super class

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
`LearnerClust`

## Public fields

- `assignments`:

  (`NULL` \| [`vector()`](https://rdrr.io/r/base/vector.html))  
  Cluster assignments from learned model.

- `save_assignments`:

  ([`logical()`](https://rdrr.io/r/base/logical.html))  
  Should assignments for 'train' data be saved in the learner? Default
  is `TRUE`.

## Methods

### Public methods

- [`LearnerClust$new()`](#method-LearnerClust-new)

- [`LearnerClust$reset()`](#method-LearnerClust-reset)

- [`LearnerClust$clone()`](#method-LearnerClust-clone)

Inherited methods

- [`mlr3::Learner$base_learner()`](https://mlr3.mlr-org.com/reference/Learner.html#method-base_learner)
- [`mlr3::Learner$configure()`](https://mlr3.mlr-org.com/reference/Learner.html#method-configure)
- [`mlr3::Learner$encapsulate()`](https://mlr3.mlr-org.com/reference/Learner.html#method-encapsulate)
- [`mlr3::Learner$format()`](https://mlr3.mlr-org.com/reference/Learner.html#method-format)
- [`mlr3::Learner$help()`](https://mlr3.mlr-org.com/reference/Learner.html#method-help)
- [`mlr3::Learner$predict()`](https://mlr3.mlr-org.com/reference/Learner.html#method-predict)
- [`mlr3::Learner$predict_newdata()`](https://mlr3.mlr-org.com/reference/Learner.html#method-predict_newdata)
- [`mlr3::Learner$print()`](https://mlr3.mlr-org.com/reference/Learner.html#method-print)
- [`mlr3::Learner$selected_features()`](https://mlr3.mlr-org.com/reference/Learner.html#method-selected_features)
- [`mlr3::Learner$train()`](https://mlr3.mlr-org.com/reference/Learner.html#method-train)

------------------------------------------------------------------------

### Method `new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    LearnerClust$new(
      id,
      param_set = ps(),
      predict_types = "partition",
      feature_types = character(),
      properties = character(),
      packages = character(),
      label = NA_character_,
      man = NA_character_
    )

#### Arguments

- `id`:

  (`character(1)`)  
  Identifier for the new instance.

- `param_set`:

  ([paradox::ParamSet](https://paradox.mlr-org.com/reference/ParamSet.html))  
  Set of hyperparameters.

- `predict_types`:

  ([`character()`](https://rdrr.io/r/base/character.html))  
  Supported predict types. Must be a subset of
  [`mlr_reflections$learner_predict_types`](https://mlr3.mlr-org.com/reference/mlr_reflections.html).

- `feature_types`:

  ([`character()`](https://rdrr.io/r/base/character.html))  
  Feature types the learner operates on. Must be a subset of
  [`mlr_reflections$task_feature_types`](https://mlr3.mlr-org.com/reference/mlr_reflections.html).

- `properties`:

  ([`character()`](https://rdrr.io/r/base/character.html))  
  Set of properties of the
  [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html). Must
  be a subset of
  [`mlr_reflections$learner_properties`](https://mlr3.mlr-org.com/reference/mlr_reflections.html).
  The following properties are currently standardized and understood by
  learners in [mlr3](https://CRAN.R-project.org/package=mlr3):

  - `"missings"`: The learner can handle missing values in the data.

  - `"weights"`: The learner supports observation weights.

  - `"importance"`: The learner supports extraction of importance
    scores, i.e. comes with an `$importance()` extractor function (see
    section on optional extractors in
    [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)).

  - `"selected_features"`: The learner supports extraction of the set of
    selected features, i.e. comes with a `$selected_features()`
    extractor function (see section on optional extractors in
    [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)).

  - `"oob_error"`: The learner supports extraction of estimated out of
    bag error, i.e. comes with a `oob_error()` extractor function (see
    section on optional extractors in
    [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)).

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

------------------------------------------------------------------------

### Method `reset()`

Reset `assignments` field before calling parent's `reset()`.

#### Usage

    LearnerClust$reset()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClust$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
library(mlr3)
library(mlr3cluster)
ids = mlr_learners$keys("^clust")
ids
#>  [1] "clust.MBatchKMeans" "clust.SimpleKMeans" "clust.agnes"       
#>  [4] "clust.ap"           "clust.bico"         "clust.birch"       
#>  [7] "clust.cmeans"       "clust.cobweb"       "clust.dbscan"      
#> [10] "clust.dbscan_fpc"   "clust.diana"        "clust.em"          
#> [13] "clust.fanny"        "clust.featureless"  "clust.ff"          
#> [16] "clust.hclust"       "clust.hdbscan"      "clust.kkmeans"     
#> [19] "clust.kmeans"       "clust.mclust"       "clust.meanshift"   
#> [22] "clust.optics"       "clust.pam"          "clust.xmeans"      

# get a specific learner from mlr_learners:
learner = lrn("clust.kmeans")
print(learner)
#> 
#> ── <LearnerClustKMeans> (clust.kmeans): K-Means ────────────────────────────────
#> • Model: -
#> • Parameters: centers=2
#> • Packages: mlr3, mlr3cluster, stats, and clue
#> • Predict Types: [partition]
#> • Feature Types: logical, integer, and numeric
#> • Encapsulation: none (fallback: -)
#> • Properties: complete, exclusive, and partitional
#> • Other settings: use_weights = 'error'
```
