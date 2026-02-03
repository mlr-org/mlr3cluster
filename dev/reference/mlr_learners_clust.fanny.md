# Fuzzy Analysis Clustering Learner

Fuzzy Analysis (FANNY) clustering. Calls
[`cluster::fanny()`](https://rdrr.io/pkg/cluster/man/fanny.html) from
package [cluster](https://CRAN.R-project.org/package=cluster).

The `k` parameter is set to 2 by default since
[`cluster::fanny()`](https://rdrr.io/pkg/cluster/man/fanny.html) doesn't
have a default value for the number of clusters. The predict method
copies cluster assignments and memberships generated for train data. The
predict does not work for new data.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.fanny")
    lrn("clust.fanny")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”, “prob”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [cluster](https://CRAN.R-project.org/package=cluster)

## Parameters

|           |           |           |                                   |                  |
|-----------|-----------|-----------|-----------------------------------|------------------|
| Id        | Type      | Default   | Levels                            | Range            |
| k         | integer   | \-        |                                   | \\\[1, \infty)\\ |
| memb.exp  | numeric   | 2         |                                   | \\\[1, \infty)\\ |
| metric    | character | euclidean | euclidean, manhattan, SqEuclidean | \-               |
| stand     | logical   | FALSE     | TRUE, FALSE                       | \-               |
| iniMem.p  | untyped   | NULL      |                                   | \-               |
| maxit     | integer   | 500       |                                   | \\\[0, \infty)\\ |
| tol       | numeric   | 1e-15     |                                   | \\\[0, \infty)\\ |
| trace.lev | integer   | 0         |                                   | \\\[0, \infty)\\ |

## References

Kaufman, Leonard, Rousseeuw, J P (2009). *Finding groups in data: an
introduction to cluster analysis*. John Wiley & Sons.

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
[`mlr_learners_clust.cobweb`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.cobweb.md),
[`mlr_learners_clust.dbscan`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.dbscan.md),
[`mlr_learners_clust.dbscan_fpc`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.dbscan_fpc.md),
[`mlr_learners_clust.diana`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.diana.md),
[`mlr_learners_clust.em`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.em.md),
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
-\> `LearnerClustFanny`

## Methods

### Public methods

- [`LearnerClustFanny$new()`](#method-LearnerClustFanny-new)

- [`LearnerClustFanny$clone()`](#method-LearnerClustFanny-clone)

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

    LearnerClustFanny$new()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustFanny$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.fanny")
print(learner)
#> 
#> ── <LearnerClustFanny> (clust.fanny): Fuzzy Analysis ───────────────────────────
#> • Model: -
#> • Parameters: k=2
#> • Packages: mlr3, mlr3cluster, and cluster
#> • Predict Types: [partition] and prob
#> • Feature Types: logical, integer, and numeric
#> • Encapsulation: none (fallback: -)
#> • Properties: complete, fuzzy, and partitional
#> • Other settings: use_weights = 'error'

# Define a Task
task = tsk("usarrests")

# Train the learner on the task
learner$train(task)

# Print the model
print(learner$model)
#> Fuzzy Clustering object of class 'fanny' :                      
#> m.ship.expon.        2
#> objective     1022.444
#> tolerance        1e-15
#> iterations          14
#> converged            1
#> maxit              500
#> n                   50
#> Membership coefficients (in %, rounded):
#>       [,1] [,2]
#>  [1,]   86   14
#>  [2,]   86   14
#>  [3,]   85   15
#>  [4,]   59   41
#>  [5,]   86   14
#>  [6,]   70   30
#>  [7,]   11   89
#>  [8,]   87   13
#>  [9,]   77   23
#> [10,]   75   25
#> [11,]   21   79
#> [12,]   12   88
#> [13,]   89   11
#> [14,]    9   91
#> [15,]   16   84
#> [16,]   10   90
#> [17,]   10   90
#> [18,]   90   10
#> [19,]   12   88
#> [20,]   84   16
#> [21,]   29   71
#> [22,]   91    9
#> [23,]   13   87
#> [24,]   86   14
#> [25,]   51   49
#> [26,]   10   90
#> [27,]    9   91
#> [28,]   88   12
#> [29,]   16   84
#> [30,]   37   63
#> [31,]   88   12
#> [32,]   89   11
#> [33,]   76   24
#> [34,]   20   80
#> [35,]   13   87
#> [36,]   28   72
#> [37,]   35   65
#> [38,]    9   91
#> [39,]   47   53
#> [40,]   86   14
#> [41,]   12   88
#> [42,]   59   41
#> [43,]   68   32
#> [44,]   14   86
#> [45,]   21   79
#> [46,]   32   68
#> [47,]   25   75
#> [48,]   14   86
#> [49,]   17   83
#> [50,]   36   64
#> Fuzzyness coefficients:
#> dunn_coeff normalized 
#>  0.7078300  0.4156599 
#> Closest hard clustering:
#>  [1] 1 1 1 1 1 1 2 1 1 1 2 2 1 2 2 2 2 1 2 1 2 1 2 1 1 2 2 1 2 2 1 1 1 2 2 2 2 2
#> [39] 2 1 2 1 1 2 2 2 2 2 2 2
#> 
#> Available components:
#>  [1] "membership"  "coeff"       "memb.exp"    "clustering"  "k.crisp"    
#>  [6] "objective"   "convergence" "diss"        "call"        "silinfo"    
#> [11] "data"       

# Make predictions for the task
prediction = learner$predict(task)
#> Warning: 
#> ✖ Learner 'clust.fanny' doesn't predict on new data and predictions may not
#>   make sense on new data.
#> → Class: Mlr3WarningInput

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#>  0.1220028 
```
