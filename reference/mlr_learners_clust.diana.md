# Divisive Analysis Clustering Learner

Divisive hierarchical clustering. Calls
[`cluster::diana()`](https://rdrr.io/pkg/cluster/man/diana.html) from
package [cluster](https://CRAN.R-project.org/package=cluster).

The predict method uses
[`stats::cutree()`](https://rdrr.io/r/stats/cutree.html) which cuts the
tree resulting from hierarchical clustering into specified number of
groups (see parameter `k`). The default value for `k` is 2.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.diana")
    lrn("clust.diana")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [cluster](https://CRAN.R-project.org/package=cluster)

## Parameters

|           |           |           |                      |                  |
|-----------|-----------|-----------|----------------------|------------------|
| Id        | Type      | Default   | Levels               | Range            |
| metric    | character | euclidean | euclidean, manhattan | \-               |
| stand     | logical   | FALSE     | TRUE, FALSE          | \-               |
| trace.lev | integer   | 0         |                      | \\\[0, \infty)\\ |
| k         | integer   | 2         |                      | \\\[1, \infty)\\ |

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
[`mlr_learners_clust.MBatchKMeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.MBatchKMeans.md),
[`mlr_learners_clust.SimpleKMeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.SimpleKMeans.md),
[`mlr_learners_clust.agnes`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.agnes.md),
[`mlr_learners_clust.ap`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.ap.md),
[`mlr_learners_clust.bico`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.bico.md),
[`mlr_learners_clust.birch`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.birch.md),
[`mlr_learners_clust.cmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cmeans.md),
[`mlr_learners_clust.cobweb`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cobweb.md),
[`mlr_learners_clust.dbscan`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan.md),
[`mlr_learners_clust.dbscan_fpc`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan_fpc.md),
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
-\> `LearnerClustDiana`

## Methods

### Public methods

- [`LearnerClustDiana$new()`](#method-LearnerClustDiana-new)

- [`LearnerClustDiana$clone()`](#method-LearnerClustDiana-clone)

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

    LearnerClustDiana$new()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustDiana$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.diana")
print(learner)
#> 
#> ── <LearnerClustDiana> (clust.diana): Divisive Analysis ────────────────────────
#> • Model: -
#> • Parameters: k=2
#> • Packages: mlr3, mlr3cluster, and cluster
#> • Predict Types: [partition]
#> • Feature Types: logical, integer, and numeric
#> • Encapsulation: none (fallback: -)
#> • Properties: complete, exclusive, and hierarchical
#> • Other settings: use_weights = 'error'

# Define a Task
task = tsk("usarrests")

# Train the learner on the task
learner$train(task)

# Print the model
print(learner$model)
#> Merge:
#>       [,1] [,2]
#>  [1,]  -15  -29
#>  [2,]  -17  -26
#>  [3,]  -14  -16
#>  [4,]  -13  -32
#>  [5,]  -35  -44
#>  [6,]  -46  -50
#>  [7,]   -7  -38
#>  [8,]  -19  -41
#>  [9,]  -36  -47
#> [10,]    1  -49
#> [11,]  -21  -30
#> [12,]   -4  -42
#> [13,]    8  -48
#> [14,]  -34  -45
#> [15,]  -22  -28
#> [16,]   -3  -31
#> [17,]   -6  -43
#> [18,]   -1  -18
#> [19,]  -37    6
#> [20,]    2  -27
#> [21,]    3   20
#> [22,]   16  -20
#> [23,]   18   -8
#> [24,]    7    5
#> [25,]   10  -23
#> [26,]  -12   21
#> [27,]    4   15
#> [28,]    9   19
#> [29,]   17  -10
#> [30,]   11  -39
#> [31,]   -2  -24
#> [32,]   24   26
#> [33,]  -25   28
#> [34,]   22   -5
#> [35,]   12   29
#> [36,]   30   33
#> [37,]   23   27
#> [38,]   -9  -33
#> [39,]   25   14
#> [40,]   34  -40
#> [41,]   37   31
#> [42,]  -11   39
#> [43,]   42   13
#> [44,]   32   36
#> [45,]   41   35
#> [46,]   40   38
#> [47,]   44   43
#> [48,]   45   46
#> [49,]   48   47
#> Order of objects:
#>  [1]  1 18  8 13 32 22 28  2 24  4 42  6 43 10  3 31 20  5 40  9 33  7 38 35 44
#> [26] 12 14 16 17 26 27 21 30 39 25 36 47 37 46 50 11 15 29 49 23 34 45 19 41 48
#> Height:
#>  [1]  15.454449  16.976749  37.430469   6.236986  22.366046  13.297368
#>  [7]  47.627933  28.635118  77.884530  12.614278  36.734861  14.501034
#> [13]  25.093027 150.045593  13.896043  15.890249  36.347352  47.061343
#> [19]  80.332123  38.527912 293.622751   8.027453  18.264994   6.637771
#> [25]  31.477135  19.904271   3.929377  15.766420   3.834058  15.766420
#> [31]  77.453083  11.456439  26.343880  36.847931  33.570821  10.305338
#> [37]  23.349518  15.630099   7.930952 137.516726  51.919264   2.291288
#> [43]  10.860018  19.437592  41.784447  13.044922  57.271022   8.537564
#> [49]  12.775367
#> Divisive coefficient:
#> [1] 0.9464692
#> 
#> Available components:
#> [1] "order"  "height" "dc"     "merge"  "diss"   "call"   "data"  

# Make predictions for the task
prediction = learner$predict(task)
#> Warning: 
#> ✖ Learner 'clust.diana' doesn't predict on new data and predictions may not
#>   make sense on new data.
#> → Class: Mlr3WarningInput

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#>  0.1033191 
```
