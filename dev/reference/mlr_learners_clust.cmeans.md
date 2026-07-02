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
-\> `LearnerClustCMeans`

## Methods

### Public methods

- [`LearnerClustCMeans$new()`](#method-LearnerClustCMeans-initialize)

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
- [`LearnerClust$reset()`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.html#method-reset)

------------------------------------------------------------------------

### `LearnerClustCMeans$new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    LearnerClustCMeans$new()

------------------------------------------------------------------------

### `LearnerClustCMeans$clone()`

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
#> • Other settings: use_weights = 'error', predict_raw = 'FALSE'

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
#> 1 256.7300 11.647440 28.07171 68.53665
#> 2 105.4632  4.832808 15.99931 62.71935
#> 
#> Memberships:
#>                  1           2
#>  [1,] 0.9667380980 0.033261902
#>  [2,] 0.9724258595 0.027574140
#>  [3,] 0.9590234854 0.040976515
#>  [4,] 0.6006262497 0.399373750
#>  [5,] 0.9670343776 0.032965622
#>  [6,] 0.7774177857 0.222582214
#>  [7,] 0.0112955002 0.988704500
#>  [8,] 0.9699756568 0.030024343
#>  [9,] 0.8945892347 0.105410765
#> [10,] 0.8380827337 0.161917266
#> [11,] 0.0814450853 0.918554915
#> [12,] 0.0151758412 0.984824159
#> [13,] 0.9865828320 0.013417168
#> [14,] 0.0044455530 0.995554447
#> [15,] 0.0579231799 0.942076820
#> [16,] 0.0052659093 0.994734091
#> [17,] 0.0067523701 0.993247630
#> [18,] 0.9945040869 0.005495913
#> [19,] 0.0226008290 0.977399171
#> [20,] 0.9530334541 0.046966546
#> [21,] 0.1654321787 0.834567821
#> [22,] 0.9964137511 0.003586249
#> [23,] 0.0319892774 0.968010723
#> [24,] 0.9698621859 0.030137814
#> [25,] 0.4689109665 0.531089034
#> [26,] 0.0048561862 0.995143814
#> [27,] 0.0005394172 0.999460583
#> [28,] 0.9785289659 0.021471034
#> [29,] 0.0569207290 0.943079271
#> [30,] 0.2617253617 0.738274638
#> [31,] 0.9755250008 0.024474999
#> [32,] 0.9862720430 0.013727957
#> [33,] 0.8831650439 0.116834956
#> [34,] 0.0818339193 0.918166081
#> [35,] 0.0206997695 0.979300230
#> [36,] 0.1583686472 0.841631353
#> [37,] 0.2417810352 0.758218965
#> [38,] 0.0038994967 0.996100503
#> [39,] 0.4116430350 0.588356965
#> [40,] 0.9695648410 0.030435159
#> [41,] 0.0229334592 0.977066541
#> [42,] 0.5928060923 0.407193908
#> [43,] 0.7469423869 0.253057613
#> [44,] 0.0287518441 0.971248156
#> [45,] 0.0862851590 0.913714841
#> [46,] 0.2018226269 0.798177373
#> [47,] 0.1236896318 0.876310368
#> [48,] 0.0361848698 0.963815130
#> [49,] 0.0625489696 0.937451030
#> [50,] 0.2474251023 0.752574898
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
