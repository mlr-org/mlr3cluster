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
#>    Assault   Murder     Rape UrbanPop
#> 1 256.7319 11.64749 28.07181 68.53662
#> 2 105.4648  4.83287 15.99945 62.71959
#> 
#> Memberships:
#>                  1           2
#>  [1,] 0.9667330458 0.033266954
#>  [2,] 0.9724263619 0.027573638
#>  [3,] 0.9590263993 0.040973601
#>  [4,] 0.6006053983 0.399394602
#>  [5,] 0.9670360643 0.032963936
#>  [6,] 0.7774011162 0.222598884
#>  [7,] 0.0112943613 0.988705639
#>  [8,] 0.9699710448 0.030028955
#>  [9,] 0.8945923718 0.105407628
#> [10,] 0.8380682177 0.161931782
#> [11,] 0.0814470396 0.918552960
#> [12,] 0.0151734014 0.984826599
#> [13,] 0.9865811308 0.013418869
#> [14,] 0.0044441806 0.995555819
#> [15,] 0.0579256091 0.942074391
#> [16,] 0.0052642074 0.994735793
#> [17,] 0.0067519083 0.993248092
#> [18,] 0.9945025471 0.005497453
#> [19,] 0.0226027708 0.977397229
#> [20,] 0.9530366186 0.046963381
#> [21,] 0.1654190733 0.834580927
#> [22,] 0.9964134489 0.003586551
#> [23,] 0.0319914595 0.968008540
#> [24,] 0.9698619166 0.030138083
#> [25,] 0.4688884810 0.531111519
#> [26,] 0.0048557682 0.995144232
#> [27,] 0.0005398602 0.999460140
#> [28,] 0.9785279146 0.021472085
#> [29,] 0.0569231594 0.943076841
#> [30,] 0.2617085057 0.738291494
#> [31,] 0.9755277110 0.024472289
#> [32,] 0.9862712681 0.013728732
#> [33,] 0.8831680227 0.116831977
#> [34,] 0.0818362790 0.918163721
#> [35,] 0.0206965125 0.979303488
#> [36,] 0.1583547711 0.841645229
#> [37,] 0.2417636817 0.758236318
#> [38,] 0.0038991441 0.996100856
#> [39,] 0.4116229359 0.588377064
#> [40,] 0.9695669054 0.030433095
#> [41,] 0.0229352057 0.977064794
#> [42,] 0.5927842391 0.407215761
#> [43,] 0.7469240237 0.253075976
#> [44,] 0.0287483285 0.971251671
#> [45,] 0.0862873842 0.913712616
#> [46,] 0.2018067414 0.798193259
#> [47,] 0.1236780046 0.876321995
#> [48,] 0.0361867277 0.963813272
#> [49,] 0.0625513208 0.937448679
#> [50,] 0.2474076095 0.752592390
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
