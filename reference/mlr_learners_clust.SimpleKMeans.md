# K-Means Clustering Learner (Weka)

K-means clustering (Weka). Calls
[`RWeka::SimpleKMeans()`](https://rdrr.io/pkg/RWeka/man/Weka_clusterers.html)
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

    mlr_learners$get("clust.SimpleKMeans")
    lrn("clust.SimpleKMeans")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [RWeka](https://CRAN.R-project.org/package=RWeka)

## Parameters

|                   |         |                               |             |                       |
|-------------------|---------|-------------------------------|-------------|-----------------------|
| Id                | Type    | Default                       | Levels      | Range                 |
| A                 | untyped | "weka.core.EuclideanDistance" |             | \-                    |
| C                 | logical | FALSE                         | TRUE, FALSE | \-                    |
| fast              | logical | FALSE                         | TRUE, FALSE | \-                    |
| I                 | integer | 100                           |             | \\\[1, \infty)\\      |
| init              | integer | 0                             |             | \\\[0, 3\]\\          |
| M                 | logical | FALSE                         | TRUE, FALSE | \-                    |
| max_candidates    | integer | 100                           |             | \\\[1, \infty)\\      |
| min_density       | integer | 2                             |             | \\\[1, \infty)\\      |
| N                 | integer | 2                             |             | \\\[1, \infty)\\      |
| num_slots         | integer | 1                             |             | \\\[1, \infty)\\      |
| O                 | logical | FALSE                         | TRUE, FALSE | \-                    |
| periodic_pruning  | integer | 10000                         |             | \\\[1, \infty)\\      |
| S                 | integer | 10                            |             | \\\[0, \infty)\\      |
| t2                | numeric | -1                            |             | \\(-\infty, \infty)\\ |
| t1                | numeric | -1.5                          |             | \\(-\infty, \infty)\\ |
| V                 | logical | FALSE                         | TRUE, FALSE | \-                    |
| output_debug_info | logical | FALSE                         | TRUE, FALSE | \-                    |

## References

Witten, H I, Frank, Eibe (2002). “Data mining: practical machine
learning tools and techniques with Java implementations.” *Acm Sigmod
Record*, **31**(1), 76–77.

Forgy, W E (1965). “Cluster analysis of multivariate data: efficiency
versus interpretability of classifications.” *Biometrics*, **21**,
768–769.

Lloyd, P S (1982). “Least squares quantization in PCM.” *IEEE
Transactions on Information Theory*, **28**(2), 129–137.

MacQueen, James (1967). “Some methods for classification and analysis of
multivariate observations.” In *Proceedings of the Fifth Berkeley
Symposium on Mathematical Statistics and Probability*, volume 1,
281–297.

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
[`mlr_learners_clust.MBatchKMeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.MBatchKMeans.md),
[`mlr_learners_clust.agnes`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.agnes.md),
[`mlr_learners_clust.ap`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.ap.md),
[`mlr_learners_clust.bico`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.bico.md),
[`mlr_learners_clust.birch`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.birch.md),
[`mlr_learners_clust.cmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cmeans.md),
[`mlr_learners_clust.cobweb`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cobweb.md),
[`mlr_learners_clust.dbscan`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan.md),
[`mlr_learners_clust.dbscan_fpc`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan_fpc.md),
[`mlr_learners_clust.diana`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.diana.md),
[`mlr_learners_clust.em`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.em.md),
[`mlr_learners_clust.fanny`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.fanny.md),
[`mlr_learners_clust.featureless`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.featureless.md),
[`mlr_learners_clust.ff`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.ff.md),
[`mlr_learners_clust.hclust`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.hclust.md),
[`mlr_learners_clust.hdbscan`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.hdbscan.md),
[`mlr_learners_clust.kkmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kkmeans.md),
[`mlr_learners_clust.kmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kmeans.md),
[`mlr_learners_clust.mclust`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.mclust.md),
[`mlr_learners_clust.meanshift`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.meanshift.md),
[`mlr_learners_clust.optics`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.optics.md),
[`mlr_learners_clust.pam`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.pam.md),
[`mlr_learners_clust.protoclust`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.protoclust.md),
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`mlr3cluster::LearnerClust`](https://mlr3cluster.mlr-org.com/reference/LearnerClust.md)
-\> `LearnerClustSimpleKMeans`

## Methods

### Public methods

- [`LearnerClustSimpleKMeans$new()`](#method-LearnerClustSimpleKMeans-new)

- [`LearnerClustSimpleKMeans$clone()`](#method-LearnerClustSimpleKMeans-clone)

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
- [`mlr3cluster::LearnerClust$reset()`](https://mlr3cluster.mlr-org.com/reference/LearnerClust.html#method-reset)

------------------------------------------------------------------------

### Method `new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    LearnerClustSimpleKMeans$new()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustSimpleKMeans$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.SimpleKMeans")
print(learner)
#> 
#> ── <LearnerClustSimpleKMeans> (clust.SimpleKMeans): K-Means (Weka) ─────────────
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
#> 
#> kMeans
#> ======
#> 
#> Number of iterations: 4
#> Within cluster sum of squared errors: 6.596893867946197
#> 
#> Initial starting points (random):
#> 
#> Cluster 0: 113,7.2,21,65
#> Cluster 1: 159,4.9,29.3,67
#> 
#> Missing values globally replaced with mean/mode
#> 
#> Final cluster centroids:
#>                          Cluster#
#> Attribute    Full Data          0          1
#>                 (50.0)     (30.0)     (20.0)
#> ============================================
#> Assault         170.76   114.4333     255.25
#> Murder           7.788       4.87     12.165
#> Rape            21.232    15.9433     29.165
#> UrbanPop         65.54    63.6333       68.4
#> 
#> 
#> 

# Make predictions for the task
prediction = learner$predict(task)

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#> 0.06459841 
```
