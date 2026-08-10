# G-Means Clustering Learner

G-means clustering. Calls
[`gmeans::gmeans()`](https://m-muecke.github.io/gmeans/reference/gmeans.html)
from package [gmeans](https://CRAN.R-project.org/package=gmeans).

G-means extends k-means by automatically determining the number of
clusters: starting from `k_init` centers, each cluster is repeatedly
split in two unless an Anderson-Darling test suggests its points already
follow a Gaussian distribution, until no more centers are added or
`k_max` is reached. The predict method assigns new observations to the
nearest cluster center.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.gmeans")
    lrn("clust.gmeans")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [gmeans](https://CRAN.R-project.org/package=gmeans)

## Parameters

|  |  |  |  |  |
|----|----|----|----|----|
| Id | Type | Default | Levels | Range |
| k_init | integer | 2 |  | \\\[1, \infty)\\ |
| k_max | integer | 10 |  | \\\[1, \infty)\\ |
| level | numeric | 0.05 |  | \\\[0, 1\]\\ |
| iter.max | integer | 10 |  | \\\[1, \infty)\\ |
| algorithm | character | Hartigan-Wong | Hartigan-Wong, Lloyd, Forgy, MacQueen | \- |
| trace | logical | FALSE | TRUE, FALSE | \- |
| method | character | euclidean | euclidean, manhattan, minkowski | \- |
| p | numeric | 2 |  | \\\[0, \infty)\\ |

## References

Hamerly, Greg, Elkan, Charles (2003). “Learning the k in k-means.” In
*Advances in Neural Information Processing Systems*, volume 16.

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

- Package [mlr3viz](https://CRAN.R-project.org/package=mlr3viz) for some
  generic visualizations.

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
[`mlr_learners_clust.clara`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.clara.md),
[`mlr_learners_clust.cmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.cmeans.md),
[`mlr_learners_clust.cobweb`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.cobweb.md),
[`mlr_learners_clust.dbscan`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.dbscan.md),
[`mlr_learners_clust.dbscan_fpc`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.dbscan_fpc.md),
[`mlr_learners_clust.diana`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.diana.md),
[`mlr_learners_clust.em`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.em.md),
[`mlr_learners_clust.fanny`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.fanny.md),
[`mlr_learners_clust.featureless`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.featureless.md),
[`mlr_learners_clust.ff`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.ff.md),
[`mlr_learners_clust.flexmix`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.flexmix.md),
[`mlr_learners_clust.genie`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.genie.md),
[`mlr_learners_clust.hclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.hclust.md),
[`mlr_learners_clust.hdbscan`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.hdbscan.md),
[`mlr_learners_clust.kcca`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kcca.md),
[`mlr_learners_clust.kkmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kkmeans.md),
[`mlr_learners_clust.kmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kmeans.md),
[`mlr_learners_clust.kmeans_rcpp`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kmeans_rcpp.md),
[`mlr_learners_clust.kmodes`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kmodes.md),
[`mlr_learners_clust.kproto`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kproto.md),
[`mlr_learners_clust.mclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.mclust.md),
[`mlr_learners_clust.meanshift`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.meanshift.md),
[`mlr_learners_clust.movMF`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.movMF.md),
[`mlr_learners_clust.optics`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.optics.md),
[`mlr_learners_clust.pam`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.pam.md),
[`mlr_learners_clust.protoclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.protoclust.md),
[`mlr_learners_clust.skmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.skmeans.md),
[`mlr_learners_clust.som`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.som.md),
[`mlr_learners_clust.specc`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.specc.md),
[`mlr_learners_clust.stdbscan`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.stdbscan.md),
[`mlr_learners_clust.tclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.tclust.md),
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`LearnerClust`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.md)
-\> `LearnerClustGMeans`

## Methods

### Public methods

- [`LearnerClustGMeans$new()`](#method-LearnerClustGMeans-initialize)

- [`LearnerClustGMeans$clone()`](#method-LearnerClustGMeans-clone)

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
- [`LearnerClust$reset()`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.html#method-reset)

------------------------------------------------------------------------

### `LearnerClustGMeans$new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    LearnerClustGMeans$new()

------------------------------------------------------------------------

### `LearnerClustGMeans$clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustGMeans$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.gmeans")
print(learner)
#> 
#> ── <LearnerClustGMeans> (clust.gmeans): G-Means ────────────────────────────────
#> • Model: -
#> • Parameters: list()
#> • Packages: mlr3, mlr3cluster, and gmeans
#> • Predict Types: [partition]
#> • Feature Types: logical, integer, and numeric
#> • Encapsulation: none (fallback: -)
#> • Properties: complete, exclusive, and partitional
#> • Other settings: use_weights = 'error', predict_raw = 'FALSE'

# Define a Task
task = tsk("usarrests")

# Train the learner on the task
learner$train(task)

# Print the model
print(learner$model)
#> K-means clustering with 2 clusters of sizes 29, 21
#> 
#> Cluster means:
#>    Assault    Murder     Rape UrbanPop
#> 1 109.7586  4.841379 16.24828 64.03448
#> 2 255.0000 11.857143 28.11429 67.61905
#> 
#> Clustering vector:
#>  [1] 2 2 2 2 2 2 1 2 2 2 1 1 2 1 1 1 1 2 1 2 1 2 1 2 1 1 1 2 1 1 2 2 2 1 1 1 1 1
#> [39] 1 2 1 2 2 1 1 1 1 1 1 1
#> 
#> Within cluster sum of squares by cluster:
#> [1] 54762.30 41636.73
#>  (between_SS / total_SS =  72.9 %)
#> 
#> Available components:
#> 
#> [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss"
#> [6] "betweenss"    "size"         "iter"         "ifault"      

# Make predictions for the task
prediction = learner$predict(task)

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#>  0.1033191 
```
