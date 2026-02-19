# Mini Batch K-Means Clustering Learner

Mini-batch k-means clustering. Calls
[`ClusterR::MiniBatchKmeans()`](https://mlampros.github.io/ClusterR/reference/MiniBatchKmeans.html)
from package [ClusterR](https://CRAN.R-project.org/package=ClusterR).

The `clusters` parameter is set to 2 by default since
[`ClusterR::MiniBatchKmeans()`](https://mlampros.github.io/ClusterR/reference/MiniBatchKmeans.html)
doesn't have a default value for the number of clusters. The predict
method uses
[`ClusterR::predict_MBatchKMeans()`](https://mlampros.github.io/ClusterR/reference/predict_MBatchKMeans.html)
to compute the cluster memberships for new data. The learner supports
both partitional and fuzzy clustering.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.MBatchKMeans")
    lrn("clust.MBatchKMeans")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”, “prob”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [ClusterR](https://CRAN.R-project.org/package=ClusterR)

## Parameters

|                  |           |          |                                               |                       |
|------------------|-----------|----------|-----------------------------------------------|-----------------------|
| Id               | Type      | Default  | Levels                                        | Range                 |
| clusters         | integer   | 2        |                                               | \\\[1, \infty)\\      |
| batch_size       | integer   | 10       |                                               | \\\[1, \infty)\\      |
| num_init         | integer   | 1        |                                               | \\\[1, \infty)\\      |
| max_iters        | integer   | 100      |                                               | \\\[1, \infty)\\      |
| init_fraction    | numeric   | 1        |                                               | \\\[0, 1\]\\          |
| initializer      | character | kmeans++ | optimal_init, quantile_init, kmeans++, random | \-                    |
| early_stop_iter  | integer   | 10       |                                               | \\\[1, \infty)\\      |
| verbose          | logical   | FALSE    | TRUE, FALSE                                   | \-                    |
| CENTROIDS        | untyped   | NULL     |                                               | \-                    |
| tol              | numeric   | 1e-04    |                                               | \\\[0, \infty)\\      |
| tol_optimal_init | numeric   | 0.3      |                                               | \\\[0, \infty)\\      |
| seed             | integer   | 1        |                                               | \\(-\infty, \infty)\\ |

## References

Sculley, David (2010). “Web-scale k-means clustering.” In *Proceedings
of the 19th international conference on World wide web*, 1177–1178.

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
[`mlr_learners_clust.SimpleKMeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.SimpleKMeans.md),
[`mlr_learners_clust.agnes`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.agnes.md),
[`mlr_learners_clust.ap`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.ap.md),
[`mlr_learners_clust.bico`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.bico.md),
[`mlr_learners_clust.birch`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.birch.md),
[`mlr_learners_clust.cmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.cmeans.md),
[`mlr_learners_clust.cobweb`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.cobweb.md),
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
[`mlr_learners_clust.specc`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.specc.md),
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`mlr3cluster::LearnerClust`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.md)
-\> `LearnerClustMiniBatchKMeans`

## Methods

### Public methods

- [`LearnerClustMiniBatchKMeans$new()`](#method-LearnerClustMiniBatchKMeans-new)

- [`LearnerClustMiniBatchKMeans$clone()`](#method-LearnerClustMiniBatchKMeans-clone)

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

    LearnerClustMiniBatchKMeans$new()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustMiniBatchKMeans$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.MBatchKMeans")
print(learner)
#> 
#> ── <LearnerClustMiniBatchKMeans> (clust.MBatchKMeans): Mini Batch K-Means ──────
#> • Model: -
#> • Parameters: clusters=2
#> • Packages: mlr3, mlr3cluster, and ClusterR
#> • Predict Types: [partition] and prob
#> • Feature Types: logical, integer, and numeric
#> • Encapsulation: none (fallback: -)
#> • Properties: complete, exclusive, fuzzy, and partitional
#> • Other settings: use_weights = 'error'

# Define a Task
task = tsk("usarrests")

# Train the learner on the task
learner$train(task)
#> Warning: `predict_MBatchKMeans()` was deprecated in ClusterR 1.3.0.
#> ℹ Beginning from version 1.4.0, if the fuzzy parameter is TRUE the function
#>   'predict_MBatchKMeans' will return only the probabilities, whereas currently
#>   it also returns the hard clusters
#> ℹ The deprecated feature was likely used in the ClusterR package.
#>   Please report the issue at <https://github.com/mlampros/ClusterR/issues>.

# Print the model
print(learner$model)
#> $centroids
#>        [,1]     [,2]     [,3]     [,4]
#> [1,] 235.50 12.08333 26.23333 71.16667
#> [2,]  86.25  4.07500 14.22500 48.00000
#> 
#> $WCSS_per_cluster
#>          [,1]     [,2]
#> [1,] 7889.297 4086.948
#> 
#> $best_initialization
#> [1] 1
#> 
#> $iters_per_initialization
#>      [,1]
#> [1,]   26
#> 
#> attr(,"class")
#> [1] "MBatchKMeans"       "k-means clustering"

# Make predictions for the task
prediction = learner$predict(task)

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#> 0.06244552 
```
