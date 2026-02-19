# Spectral Clustering Learner

Spectral clustering. Calls
[`kernlab::specc()`](https://rdrr.io/pkg/kernlab/man/specc.html) from
package [kernlab](https://CRAN.R-project.org/package=kernlab).

The `centers` parameter is set to 2 by default since
[`kernlab::specc()`](https://rdrr.io/pkg/kernlab/man/specc.html) doesn't
have a default value for the number of clusters. Kernel parameters have
to be passed directly and not by using the `kpar` list in
[`kernlab::specc()`](https://rdrr.io/pkg/kernlab/man/specc.html).

There is no predict method for
[`kernlab::specc()`](https://rdrr.io/pkg/kernlab/man/specc.html), so the
method returns cluster labels for the training data.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.specc")
    lrn("clust.specc")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [kernlab](https://CRAN.R-project.org/package=kernlab)

## Parameters

|                |           |         |                                                                                  |                       |
|----------------|-----------|---------|----------------------------------------------------------------------------------|-----------------------|
| Id             | Type      | Default | Levels                                                                           | Range                 |
| centers        | integer   | \-      |                                                                                  | \\\[1, \infty)\\      |
| kernel         | character | rbfdot  | rbfdot, polydot, vanilladot, tanhdot, laplacedot, besseldot, anovadot, splinedot | \-                    |
| sigma          | numeric   | \-      |                                                                                  | \\\[0, \infty)\\      |
| degree         | integer   | 3       |                                                                                  | \\\[1, \infty)\\      |
| scale          | numeric   | 1       |                                                                                  | \\\[0, \infty)\\      |
| offset         | numeric   | 1       |                                                                                  | \\(-\infty, \infty)\\ |
| order          | integer   | 1       |                                                                                  | \\(-\infty, \infty)\\ |
| nystrom.red    | logical   | FALSE   | TRUE, FALSE                                                                      | \-                    |
| nystrom.sample | integer   | \-      |                                                                                  | \\\[1, \infty)\\      |
| iterations     | integer   | 200     |                                                                                  | \\\[1, \infty)\\      |
| mod.sample     | numeric   | 0.75    |                                                                                  | \\\[0, 1\]\\          |

## References

Karatzoglou, Alexandros, Smola, Alexandros, Hornik, Kurt, Zeileis, Achim
(2004). “kernlab-an S4 package for kernel methods in R.” *Journal of
statistical software*, **11**, 1–20.

Ng, Y A, Jordan, I M, Weiss, Yair (2001). “On Spectral Clustering:
Analysis and an Algorithm.” In *Advances in Neural Information
Processing Systems*, volume 14.

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
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`mlr3cluster::LearnerClust`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.md)
-\> `LearnerClustSpectral`

## Methods

### Public methods

- [`LearnerClustSpectral$new()`](#method-LearnerClustSpectral-new)

- [`LearnerClustSpectral$clone()`](#method-LearnerClustSpectral-clone)

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

    LearnerClustSpectral$new()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustSpectral$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.specc")
print(learner)
#> 
#> ── <LearnerClustSpectral> (clust.specc): Spectral Clustering ───────────────────
#> • Model: -
#> • Parameters: centers=2
#> • Packages: mlr3, mlr3cluster, and kernlab
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
#> Spectral Clustering object of class "specc" 
#> 
#>  Cluster memberships: 
#>  
#> 2 2 2 2 2 2 1 2 2 2 1 1 2 1 1 1 1 2 1 2 2 2 1 2 2 1 1 2 1 2 2 2 2 1 1 2 2 1 2 2 1 2 2 1 1 2 2 1 1 2 
#>  
#> Gaussian Radial Basis kernel function. 
#>  Hyperparameter : sigma =  0.0119047619047598 
#> 
#> Centers:  
#>          [,1]     [,2]     [,3]  [,4]
#> [1,]  87.5500  4.27000 14.39000 59.75
#> [2,] 226.2333 10.13333 25.79333 69.40
#> 
#> Cluster size:  
#> [1] 20 30
#> 
#> Within-cluster sum of squares:  
#> [1]  213075.9 1799973.6
#> 

# Make predictions for the task
prediction = learner$predict(task)
#> Warning: 
#> ✖ Learner 'clust.specc' doesn't predict on new data and predictions may not
#>   make sense on new data.
#> → Class: Mlr3WarningInput

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#>  0.1323762 
```
