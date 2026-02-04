# Hierarchical Clustering Learner

Agglomerative hierarchical clustering. Calls
[`stats::hclust()`](https://rdrr.io/r/stats/hclust.html) from package
stats.

Distance calculation is done by
[`stats::dist()`](https://rdrr.io/r/stats/dist.html).

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.hclust")
    lrn("clust.hclust")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster), 'stats'

## Parameters

|            |           |           |                                                                        |                       |
|------------|-----------|-----------|------------------------------------------------------------------------|-----------------------|
| Id         | Type      | Default   | Levels                                                                 | Range                 |
| method     | character | complete  | ward.D, ward.D2, single, complete, average, mcquitty, median, centroid | \-                    |
| members    | untyped   | NULL      |                                                                        | \-                    |
| distmethod | character | euclidean | euclidean, maximum, manhattan, canberra, binary, minkowski             | \-                    |
| diag       | logical   | FALSE     | TRUE, FALSE                                                            | \-                    |
| upper      | logical   | FALSE     | TRUE, FALSE                                                            | \-                    |
| p          | numeric   | 2         |                                                                        | \\(-\infty, \infty)\\ |
| k          | integer   | NULL      |                                                                        | \\\[1, \infty)\\      |

## References

Becker, A R, Chambers, M J, Wilks, R A (1988). *The New S Language*.
Wadsworth & Brooks/Cole.

Everitt, S B (1974). *Cluster Analysis*. Heinemann Educational Books.

Hartigan, A J (1975). *Clustering Algorithms*. John Wiley & Sons.

Sneath, HA P, Sokal, R R (1973). *Numerical Taxonomy*. Freeman.

Anderberg, R M (1973). *Cluster Analysis for Applications*. Academic
Press.

Gordon, David A (1999). *Classification*, 2 edition. Chapman and Hall /
CRC.

Murtagh, Fionn (1985). “Multidimensional Clustering Algorithms.” In
*COMPSTAT Lectures 4*. Physica-Verlag.

McQuitty, L L (1966). “Similarity Analysis by Reciprocal Pairs for
Discrete and Continuous Data.” *Educational and Psychological
Measurement*, **26**(4), 825–831.
[doi:10.1177/001316446602600402](https://doi.org/10.1177/001316446602600402)
.

Legendre, Pierre, Legendre, Louis (2012). *Numerical Ecology*, 3
edition. Elsevier Science BV.

Murtagh, Fionn, Legendre, Pierre (2014). “Ward's Hierarchical
Agglomerative Clustering Method: Which Algorithms Implement Ward's
Criterion?” *Journal of Classification*, **31**, 274–295.
[doi:10.1007/s00357-014-9161-z](https://doi.org/10.1007/s00357-014-9161-z)
.

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
[`mlr_learners_clust.diana`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.diana.md),
[`mlr_learners_clust.em`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.em.md),
[`mlr_learners_clust.fanny`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.fanny.md),
[`mlr_learners_clust.featureless`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.featureless.md),
[`mlr_learners_clust.ff`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.ff.md),
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
-\> `LearnerClustHclust`

## Methods

### Public methods

- [`LearnerClustHclust$new()`](#method-LearnerClustHclust-new)

- [`LearnerClustHclust$clone()`](#method-LearnerClustHclust-clone)

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

    LearnerClustHclust$new()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustHclust$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.hclust")
print(learner)
#> 
#> ── <LearnerClustHclust> (clust.hclust): Hierarchical Clustering ────────────────
#> • Model: -
#> • Parameters: k=2
#> • Packages: mlr3, mlr3cluster, and stats
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
#> 
#> Call:
#> stats::hclust(d = dist)
#> 
#> Cluster method   : complete 
#> Distance         : euclidean 
#> Number of objects: 50 
#> 

# Make predictions for the task
prediction = learner$predict(task)
#> Warning: 
#> ✖ Learner 'clust.hclust' doesn't predict on new data and predictions may not
#>   make sense on new data.
#> → Class: Mlr3WarningInput

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#>  0.1532626 
```
