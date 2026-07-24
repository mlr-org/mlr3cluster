# Prototype Hierarchical Clustering Learner

Hierarchical clustering using minimax linkage with prototypes. Calls
[`protoclust::protoclust()`](https://rdrr.io/pkg/protoclust/man/protoclust.html)
from package
[protoclust](https://CRAN.R-project.org/package=protoclust).

The predict method cuts the tree at the current `k` via
[`protoclust::protocut()`](https://rdrr.io/pkg/protoclust/man/protocut.html)
and assigns each new observation to the cluster of its nearest
prototype, using the same distance method as during training. The model
is therefore a list containing the fitted
[`protoclust::protoclust()`](https://rdrr.io/pkg/protoclust/man/protoclust.html)
object along with the training data.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.protoclust")
    lrn("clust.protoclust")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [protoclust](https://CRAN.R-project.org/package=protoclust)

## Parameters

|  |  |  |  |  |
|----|----|----|----|----|
| Id | Type | Default | Levels | Range |
| method | character | euclidean | euclidean, maximum, manhattan, canberra, binary, minkowski | \- |
| diag | logical | FALSE | TRUE, FALSE | \- |
| upper | logical | FALSE | TRUE, FALSE | \- |
| p | numeric | 2 |  | \\(-\infty, \infty)\\ |
| verb | logical | FALSE | TRUE, FALSE | \- |
| k | integer | \- |  | \\\[1, \infty)\\ |

## References

Bien, Jacob, Tibshirani, Robert (2011). “Hierarchical Clustering with
Prototypes via Minimax Linkage.” *Journal of the American Statistical
Association*, **106**(495), 1075–1084.

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
[`mlr_learners_clust.kmodes`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kmodes.md),
[`mlr_learners_clust.kproto`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kproto.md),
[`mlr_learners_clust.mclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.mclust.md),
[`mlr_learners_clust.meanshift`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.meanshift.md),
[`mlr_learners_clust.movMF`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.movMF.md),
[`mlr_learners_clust.optics`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.optics.md),
[`mlr_learners_clust.pam`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.pam.md),
[`mlr_learners_clust.skmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.skmeans.md),
[`mlr_learners_clust.som`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.som.md),
[`mlr_learners_clust.specc`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.specc.md),
[`mlr_learners_clust.stdbscan`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.stdbscan.md),
[`mlr_learners_clust.tclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.tclust.md),
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`LearnerClust`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.md)
-\> `LearnerClustProtoclust`

## Active bindings

- `native_model`:

  (any)  
  The fitted model.

## Methods

### Public methods

- [`LearnerClustProtoclust$new()`](#method-LearnerClustProtoclust-initialize)

- [`LearnerClustProtoclust$clone()`](#method-LearnerClustProtoclust-clone)

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

### `LearnerClustProtoclust$new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    LearnerClustProtoclust$new()

------------------------------------------------------------------------

### `LearnerClustProtoclust$clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustProtoclust$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.protoclust")
print(learner)
#> 
#> ── <LearnerClustProtoclust> (clust.protoclust): Prototype Hierarchical Clusterin
#> • Model: -
#> • Parameters: k=2
#> • Packages: mlr3, mlr3cluster, and protoclust
#> • Predict Types: [partition]
#> • Feature Types: logical, integer, and numeric
#> • Encapsulation: none (fallback: -)
#> • Properties: complete, exclusive, and hierarchical
#> • Other settings: use_weights = 'error', predict_raw = 'FALSE'

# Define a Task
task = tsk("usarrests")

# Train the learner on the task
learner$train(task)

# Print the model
print(learner$model)
#> $model
#> 
#> Call:
#> protoclust::protoclust(d = d)
#> 
#> Cluster method   : minimax 
#> Distance         : euclidean 
#> Number of objects: 50 
#> 
#> 
#> $data
#>       Assault Murder Rape UrbanPop
#>  [1,]     236   13.2 21.2       58
#>  [2,]     263   10.0 44.5       48
#>  [3,]     294    8.1 31.0       80
#>  [4,]     190    8.8 19.5       50
#>  [5,]     276    9.0 40.6       91
#>  [6,]     204    7.9 38.7       78
#>  [7,]     110    3.3 11.1       77
#>  [8,]     238    5.9 15.8       72
#>  [9,]     335   15.4 31.9       80
#> [10,]     211   17.4 25.8       60
#> [11,]      46    5.3 20.2       83
#> [12,]     120    2.6 14.2       54
#> [13,]     249   10.4 24.0       83
#> [14,]     113    7.2 21.0       65
#> [15,]      56    2.2 11.3       57
#> [16,]     115    6.0 18.0       66
#> [17,]     109    9.7 16.3       52
#> [18,]     249   15.4 22.2       66
#> [19,]      83    2.1  7.8       51
#> [20,]     300   11.3 27.8       67
#> [21,]     149    4.4 16.3       85
#> [22,]     255   12.1 35.1       74
#> [23,]      72    2.7 14.9       66
#> [24,]     259   16.1 17.1       44
#> [25,]     178    9.0 28.2       70
#> [26,]     109    6.0 16.4       53
#> [27,]     102    4.3 16.5       62
#> [28,]     252   12.2 46.0       81
#> [29,]      57    2.1  9.5       56
#> [30,]     159    7.4 18.8       89
#> [31,]     285   11.4 32.1       70
#> [32,]     254   11.1 26.1       86
#> [33,]     337   13.0 16.1       45
#> [34,]      45    0.8  7.3       44
#> [35,]     120    7.3 21.4       75
#> [36,]     151    6.6 20.0       68
#> [37,]     159    4.9 29.3       67
#> [38,]     106    6.3 14.9       72
#> [39,]     174    3.4  8.3       87
#> [40,]     279   14.4 22.5       48
#> [41,]      86    3.8 12.8       45
#> [42,]     188   13.2 26.9       59
#> [43,]     201   12.7 25.5       80
#> [44,]     120    3.2 22.9       80
#> [45,]      48    2.2 11.2       32
#> [46,]     156    8.5 20.7       63
#> [47,]     145    4.0 26.2       73
#> [48,]      81    5.7  9.3       39
#> [49,]      53    2.6 10.8       66
#> [50,]     161    6.8 15.6       60
#> 

# Make predictions for the task
prediction = learner$predict(task)

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#> 0.08975081 
```
