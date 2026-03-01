# Fuzzy C-Means Clustering Learner

Fuzzy c-means clustering. Calls
[`e1071::cmeans()`](https://rdrr.io/pkg/e1071/man/cmeans.html) from
package [e1071](https://CRAN.R-project.org/package=e1071).

The `centers` parameter is set to 2 by default since
[`e1071::cmeans()`](https://rdrr.io/pkg/e1071/man/cmeans.html) doesn't
have a default value for the number of clusters. The predict method uses
[`clue::cl_predict()`](https://rdrr.io/pkg/clue/man/cl_predict.html) to
compute the cluster memberships for new data.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.cmeans")
    lrn("clust.cmeans")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”, “prob”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [e1071](https://CRAN.R-project.org/package=e1071),
  [clue](https://CRAN.R-project.org/package=clue)

## Parameters

|          |           |           |                      |                  |
|----------|-----------|-----------|----------------------|------------------|
| Id       | Type      | Default   | Levels               | Range            |
| centers  | untyped   | \-        |                      | \-               |
| iter.max | integer   | 100       |                      | \\\[1, \infty)\\ |
| verbose  | logical   | FALSE     | TRUE, FALSE          | \-               |
| dist     | character | euclidean | euclidean, manhattan | \-               |
| method   | character | cmeans    | cmeans, ufcl         | \-               |
| m        | numeric   | 2         |                      | \\\[1, \infty)\\ |
| rate.par | numeric   | \-        |                      | \\\[0, 1\]\\     |
| weights  | untyped   | 1L        |                      | \-               |
| control  | untyped   | \-        |                      | \-               |

## References

Dimitriadou, Evgenia, Hornik, Kurt, Leisch, Friedrich, Meyer, David,
Weingessel, Andreas (2008). “Misc functions of the Department of
Statistics (e1071), TU Wien.” *R package*, **1**, 5–24.

Bezdek, C J (2013). *Pattern recognition with fuzzy objective function
algorithms*. Springer Science & Business Media.

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
[`mlr_learners_clust.clara`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.clara.md),
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
[`mlr_learners_clust.kproto`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kproto.md),
[`mlr_learners_clust.mclust`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.mclust.md),
[`mlr_learners_clust.meanshift`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.meanshift.md),
[`mlr_learners_clust.optics`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.optics.md),
[`mlr_learners_clust.pam`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.pam.md),
[`mlr_learners_clust.protoclust`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.protoclust.md),
[`mlr_learners_clust.specc`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.specc.md),
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`mlr3cluster::LearnerClust`](https://mlr3cluster.mlr-org.com/reference/LearnerClust.md)
-\> `LearnerClustCMeans`

## Methods

### Public methods

- [`LearnerClustCMeans$new()`](#method-LearnerClustCMeans-new)

- [`LearnerClustCMeans$clone()`](#method-LearnerClustCMeans-clone)

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

    LearnerClustCMeans$new()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustCMeans$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.cmeans")
print(learner)
#> 
#> ── <LearnerClustCMeans> (clust.cmeans): Fuzzy C-Means ──────────────────────────
#> • Model: -
#> • Parameters: centers=2
#> • Packages: mlr3, mlr3cluster, e1071, and clue
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
#> Fuzzy c-means clustering with 2 clusters
#> 
#> Cluster centers:
#>    Assault    Murder     Rape UrbanPop
#> 1 256.7369 11.647605 28.07208 68.53657
#> 2 105.4689  4.833035 15.99985 62.72022
#> 
#> Memberships:
#>                  1           2
#>  [1,] 0.9667196532 0.033280347
#>  [2,] 0.9724276916 0.027572308
#>  [3,] 0.9590341205 0.040965880
#>  [4,] 0.6005501286 0.399449871
#>  [5,] 0.9670405328 0.032959467
#>  [6,] 0.7773569306 0.222643069
#>  [7,] 0.0112913433 0.988708657
#>  [8,] 0.9699588189 0.030041181
#>  [9,] 0.8946006839 0.105399316
#> [10,] 0.8380297405 0.161970259
#> [11,] 0.0814522229 0.918547777
#> [12,] 0.0151669346 0.984833065
#> [13,] 0.9865766200 0.013423380
#> [14,] 0.0044405434 0.995559457
#> [15,] 0.0579320510 0.942067949
#> [16,] 0.0052596968 0.994740303
#> [17,] 0.0067506852 0.993249315
#> [18,] 0.9944984642 0.005501536
#> [19,] 0.0226079200 0.977392080
#> [20,] 0.9530450037 0.046954996
#> [21,] 0.1653843355 0.834615665
#> [22,] 0.9964126463 0.003587354
#> [23,] 0.0319972461 0.968002754
#> [24,] 0.9698612008 0.030138799
#> [25,] 0.4688288801 0.531171120
#> [26,] 0.0048546611 0.995145339
#> [27,] 0.0005410356 0.999458964
#> [28,] 0.9785251264 0.021474874
#> [29,] 0.0569296046 0.943070395
#> [30,] 0.2616638263 0.738336174
#> [31,] 0.9755348920 0.024465108
#> [32,] 0.9862692125 0.013730787
#> [33,] 0.8831759151 0.116824085
#> [34,] 0.0818425370 0.918157463
#> [35,] 0.0206878795 0.979312121
#> [36,] 0.1583179904 0.841682010
#> [37,] 0.2417176835 0.758282317
#> [38,] 0.0038982106 0.996101789
#> [39,] 0.4115696602 0.588430340
#> [40,] 0.9695723749 0.030427625
#> [41,] 0.0229398372 0.977060163
#> [42,] 0.5927263139 0.407273686
#> [43,] 0.7468753489 0.253124651
#> [44,] 0.0287390105 0.971260990
#> [45,] 0.0862932857 0.913706714
#> [46,] 0.2017646347 0.798235365
#> [47,] 0.1236471848 0.876352815
#> [48,] 0.0361916547 0.963808345
#> [49,] 0.0625575558 0.937442444
#> [50,] 0.2473612426 0.752638757
#> 
#> Closest hard clustering:
#>  [1] 1 1 1 1 1 1 2 1 1 1 2 2 1 2 2 2 2 1 2 1 2 1 2 1 2 2 2 1 2 2 1 1 1 2 2 2 2 2
#> [39] 2 1 2 1 1 2 2 2 2 2 2 2
#> 
#> Available components:
#> [1] "centers"     "size"        "cluster"     "membership"  "iter"       
#> [6] "withinerror" "call"       

# Make predictions for the task
prediction = learner$predict(task)

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#>  0.1033191 
```
