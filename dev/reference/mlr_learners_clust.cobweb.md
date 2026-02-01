# Cobweb Clustering Learner

Cobweb clustering. Calls
[`RWeka::Cobweb()`](https://rdrr.io/pkg/RWeka/man/Weka_clusterers.html)
from package [RWeka](https://CRAN.R-project.org/package=RWeka).

The predict method uses
[`RWeka::predict.Weka_clusterer()`](https://rdrr.io/pkg/RWeka/man/predict_Weka_clusterer.html)
to compute the cluster memberships for new data.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.cobweb")
    lrn("clust.cobweb")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [RWeka](https://CRAN.R-project.org/package=RWeka)

## Parameters

|     |         |         |                  |
|-----|---------|---------|------------------|
| Id  | Type    | Default | Range            |
| A   | numeric | 1       | \\\[0, \infty)\\ |
| C   | numeric | 0.002   | \\\[0, \infty)\\ |
| S   | integer | 42      | \\\[1, \infty)\\ |

## References

Witten, H I, Frank, Eibe (2002). “Data mining: practical machine
learning tools and techniques with Java implementations.” *Acm Sigmod
Record*, **31**(1), 76–77.

Fisher, H D (1987). “Knowledge acquisition via incremental conceptual
clustering.” *Machine learning*, **2**, 139–172.

Gennari, H J, Langley, Pat, Fisher, Doug (1989). “Models of incremental
concept formation.” *Artificial intelligence*, **40**(1-3), 11–61.

## See also

- Chapter in the [mlr3book](https://mlr3book.mlr-org.com/):
  <https://mlr3book.mlr-org.com/chapters/chapter2/data_and_basic_modeling.html#sec-learners>

- Package
  [mlr3extralearners](https://github.com/mlr-org/mlr3extralearners) for
  more learners.

- [Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
  of [Learners](https://mlr3.mlr-org.com/reference/Learner.html):
  [mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)

- `as.data.table(mlr_learners)` for a table of available
  [Learners](https://mlr3.mlr-org.com/reference/Learner.html) in the
  running session (depending on the loaded packages).

- [mlr3pipelines](https://CRAN.R-project.org/package=mlr3pipelines) to
  combine learners with pre- and postprocessing steps.

- Extension packages for additional task types:

  - [mlr3proba](https://CRAN.R-project.org/package=mlr3proba) for
    probabilistic supervised regression and survival analysis.

  - [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster) for
    unsupervised clustering.

- [mlr3tuning](https://CRAN.R-project.org/package=mlr3tuning) for tuning
  of hyperparameters,
  [mlr3tuningspaces](https://CRAN.R-project.org/package=mlr3tuningspaces)
  for established default tuning spaces.

Other Learner:
[`mlr_learners_clust.MBatchKMeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.MBatchKMeans.md),
[`mlr_learners_clust.SimpleKMeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.SimpleKMeans.md),
[`mlr_learners_clust.agnes`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.agnes.md),
[`mlr_learners_clust.ap`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.ap.md),
[`mlr_learners_clust.bico`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.bico.md),
[`mlr_learners_clust.birch`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.birch.md),
[`mlr_learners_clust.cmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.cmeans.md),
[`mlr_learners_clust.dbscan`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.dbscan.md),
[`mlr_learners_clust.dbscan_fpc`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.dbscan_fpc.md),
[`mlr_learners_clust.diana`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.diana.md),
[`mlr_learners_clust.em`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.em.md),
[`mlr_learners_clust.fanny`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.fanny.md),
[`mlr_learners_clust.featureless`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.featureless.md),
[`mlr_learners_clust.ff`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.ff.md),
[`mlr_learners_clust.hclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.hclust.md),
[`mlr_learners_clust.hdbscan`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.hdbscan.md),
[`mlr_learners_clust.kkmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kkmeans.md),
[`mlr_learners_clust.kmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kmeans.md),
[`mlr_learners_clust.mclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.mclust.md),
[`mlr_learners_clust.meanshift`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.meanshift.md),
[`mlr_learners_clust.optics`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.optics.md),
[`mlr_learners_clust.pam`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.pam.md),
[`mlr_learners_clust.protoclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.protoclust.md),
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`mlr3cluster::LearnerClust`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.md)
-\> `LearnerClustCobweb`

## Methods

### Public methods

- [`LearnerClustCobweb$new()`](#method-LearnerClustCobweb-new)

- [`LearnerClustCobweb$clone()`](#method-LearnerClustCobweb-clone)

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
- [`mlr3cluster::LearnerClust$reset()`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.html#method-reset)

------------------------------------------------------------------------

### Method `new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    LearnerClustCobweb$new()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustCobweb$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.cobweb")
print(learner)
#> 
#> ── <LearnerClustCobweb> (clust.cobweb): Cobweb ─────────────────────────────────
#> • Model: -
#> • Parameters: list()
#> • Packages: mlr3, mlr3cluster, and RWeka
#> • Predict Types: [partition]
#> • Feature Types: logical, integer, and numeric
#> • Encapsulation: none (fallback: -)
#> • Properties: complete, exclusive, and partitional
#> • Other settings: use_weights = 'error'

# Define a Task
task = tsk("usarrests")

# Train the learner on the task
learner$train(task)

# Print the model
print(learner$model)
#> Number of merges: 14
#> Number of splits: 10
#> Number of clusters: 65
#> 
#> node 0 [50]
#> |   node 1 [8]
#> |   |   leaf 2 [1]
#> |   node 1 [8]
#> |   |   leaf 3 [1]
#> |   node 1 [8]
#> |   |   leaf 4 [1]
#> |   node 1 [8]
#> |   |   leaf 5 [1]
#> |   node 1 [8]
#> |   |   leaf 6 [1]
#> |   node 1 [8]
#> |   |   node 7 [2]
#> |   |   |   leaf 8 [1]
#> |   |   node 7 [2]
#> |   |   |   leaf 9 [1]
#> |   node 1 [8]
#> |   |   leaf 10 [1]
#> node 0 [50]
#> |   node 11 [25]
#> |   |   leaf 12 [1]
#> |   node 11 [25]
#> |   |   leaf 13 [1]
#> |   node 11 [25]
#> |   |   leaf 14 [1]
#> |   node 11 [25]
#> |   |   node 15 [2]
#> |   |   |   leaf 16 [1]
#> |   |   node 15 [2]
#> |   |   |   leaf 17 [1]
#> |   node 11 [25]
#> |   |   leaf 18 [1]
#> |   node 11 [25]
#> |   |   leaf 19 [1]
#> |   node 11 [25]
#> |   |   leaf 20 [1]
#> |   node 11 [25]
#> |   |   leaf 21 [1]
#> |   node 11 [25]
#> |   |   leaf 22 [1]
#> |   node 11 [25]
#> |   |   leaf 23 [1]
#> |   node 11 [25]
#> |   |   node 24 [2]
#> |   |   |   leaf 25 [1]
#> |   |   node 24 [2]
#> |   |   |   leaf 26 [1]
#> |   node 11 [25]
#> |   |   node 27 [2]
#> |   |   |   leaf 28 [1]
#> |   |   node 27 [2]
#> |   |   |   leaf 29 [1]
#> |   node 11 [25]
#> |   |   node 30 [2]
#> |   |   |   leaf 31 [1]
#> |   |   node 30 [2]
#> |   |   |   leaf 32 [1]
#> |   node 11 [25]
#> |   |   node 33 [2]
#> |   |   |   leaf 34 [1]
#> |   |   node 33 [2]
#> |   |   |   leaf 35 [1]
#> |   node 11 [25]
#> |   |   leaf 36 [1]
#> |   node 11 [25]
#> |   |   node 37 [3]
#> |   |   |   leaf 38 [1]
#> |   |   node 37 [3]
#> |   |   |   leaf 39 [1]
#> |   |   node 37 [3]
#> |   |   |   leaf 40 [1]
#> |   node 11 [25]
#> |   |   leaf 41 [1]
#> |   node 11 [25]
#> |   |   leaf 42 [1]
#> node 0 [50]
#> |   node 43 [17]
#> |   |   leaf 44 [1]
#> |   node 43 [17]
#> |   |   leaf 45 [1]
#> |   node 43 [17]
#> |   |   leaf 46 [1]
#> |   node 43 [17]
#> |   |   leaf 47 [1]
#> |   node 43 [17]
#> |   |   node 48 [2]
#> |   |   |   leaf 49 [1]
#> |   |   node 48 [2]
#> |   |   |   leaf 50 [1]
#> |   node 43 [17]
#> |   |   leaf 51 [1]
#> |   node 43 [17]
#> |   |   node 52 [5]
#> |   |   |   leaf 53 [1]
#> |   |   node 52 [5]
#> |   |   |   leaf 54 [1]
#> |   |   node 52 [5]
#> |   |   |   leaf 55 [1]
#> |   |   node 52 [5]
#> |   |   |   leaf 56 [1]
#> |   |   node 52 [5]
#> |   |   |   leaf 57 [1]
#> |   node 43 [17]
#> |   |   node 58 [5]
#> |   |   |   leaf 59 [1]
#> |   |   node 58 [5]
#> |   |   |   node 60 [3]
#> |   |   |   |   leaf 61 [1]
#> |   |   |   node 60 [3]
#> |   |   |   |   leaf 62 [1]
#> |   |   |   node 60 [3]
#> |   |   |   |   leaf 63 [1]
#> |   |   node 58 [5]
#> |   |   |   leaf 64 [1]
#> 
#> 

# Make predictions for the task
prediction = learner$predict(task)

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#>          0 
```
