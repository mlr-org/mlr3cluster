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
[`mlr_learners_clust.MBatchKMeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.MBatchKMeans.md),
[`mlr_learners_clust.SimpleKMeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.SimpleKMeans.md),
[`mlr_learners_clust.agnes`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.agnes.md),
[`mlr_learners_clust.ap`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.ap.md),
[`mlr_learners_clust.bico`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.bico.md),
[`mlr_learners_clust.birch`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.birch.md),
[`mlr_learners_clust.clara`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.clara.md),
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
[`mlr_learners_clust.kproto`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kproto.md),
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
- [`mlr3cluster::LearnerClust$reset()`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.html#method-reset)

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
#> 1 105.4636  4.832825 15.99935 62.71942
#> 2 256.7305 11.647452 28.07174 68.53664
#> 
#> Memberships:
#>                 1            2
#>  [1,] 0.033263257 0.9667367429
#>  [2,] 0.027574006 0.9724259944
#>  [3,] 0.040975733 0.9590242673
#>  [4,] 0.399379342 0.6006206579
#>  [5,] 0.032965170 0.9670348302
#>  [6,] 0.222586685 0.7774133151
#>  [7,] 0.988704805 0.0112951949
#>  [8,] 0.030025580 0.9699744198
#>  [9,] 0.105409923 0.8945900766
#> [10,] 0.161921160 0.8380788405
#> [11,] 0.918554391 0.0814456089
#> [12,] 0.984824813 0.0151751871
#> [13,] 0.013417624 0.9865823758
#> [14,] 0.995554815 0.0044451851
#> [15,] 0.942076169 0.0579238307
#> [16,] 0.994734547 0.0052654531
#> [17,] 0.993247754 0.0067522463
#> [18,] 0.005496326 0.9945036739
#> [19,] 0.977398651 0.0226013494
#> [20,] 0.046965697 0.9530343032
#> [21,] 0.834571335 0.1654286649
#> [22,] 0.003586330 0.9964136700
#> [23,] 0.968010138 0.0319898621
#> [24,] 0.030137886 0.9698621138
#> [25,] 0.531095063 0.4689049368
#> [26,] 0.995143926 0.0048560741
#> [27,] 0.999460464 0.0005395359
#> [28,] 0.021471316 0.9785286840
#> [29,] 0.943078620 0.0569213802
#> [30,] 0.738279158 0.2617208420
#> [31,] 0.024474272 0.9755257280
#> [32,] 0.013728165 0.9862718352
#> [33,] 0.116834157 0.8831658434
#> [34,] 0.918165449 0.0818345514
#> [35,] 0.979301104 0.0206988964
#> [36,] 0.841635073 0.1583649267
#> [37,] 0.758223618 0.2417763822
#> [38,] 0.996100598 0.0038994021
#> [39,] 0.588362355 0.4116376454
#> [40,] 0.030434605 0.9695653949
#> [41,] 0.977066073 0.0229339272
#> [42,] 0.407199768 0.5928002318
#> [43,] 0.253062538 0.7469374621
#> [44,] 0.971249098 0.0287509016
#> [45,] 0.913714245 0.0862857551
#> [46,] 0.798181632 0.2018183676
#> [47,] 0.876313486 0.1236865144
#> [48,] 0.963814632 0.0361853676
#> [49,] 0.937450400 0.0625495995
#> [50,] 0.752579588 0.2474204119
#> 
#> Closest hard clustering:
#>  [1] 2 2 2 2 2 2 1 2 2 2 1 1 2 1 1 1 1 2 1 2 1 2 1 2 1 1 1 2 1 1 2 2 2 1 1 1 1 1
#> [39] 1 2 1 2 2 1 1 1 1 1 1 1
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
