# Spherical K-Means Clustering Learner

Spherical k-means clustering for data on the unit hypersphere. Calls
[`skmeans::skmeans()`](https://rdrr.io/pkg/skmeans/man/skmeans.html)
from package [skmeans](https://CRAN.R-project.org/package=skmeans).

The `k` parameter is set to 2 by default since
[`skmeans::skmeans()`](https://rdrr.io/pkg/skmeans/man/skmeans.html)
doesn't have a default value for the number of clusters. Observations
are partitioned by maximising cosine similarity to cluster prototypes.
Predictions on new data assign each observation to the prototype with
the highest cosine similarity. Rows with zero norm are not allowed by
[`skmeans::skmeans()`](https://rdrr.io/pkg/skmeans/man/skmeans.html).

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.skmeans")
    lrn("clust.skmeans")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [skmeans](https://CRAN.R-project.org/package=skmeans)

## Parameters

|  |  |  |  |  |
|----|----|----|----|----|
| Id | Type | Default | Levels | Range |
| k | integer | \- |  | \\\[1, \infty)\\ |
| method | character | \- | genetic, pclust, CLUTO, gmeans, kmndirs, LIH, LIHC | \- |
| m | numeric | 1 |  | \\\[1, \infty)\\ |
| weights | untyped | 1 |  | \- |
| maxiter | integer | \- |  | \\\[1, \infty)\\ |
| nruns | integer | \- |  | \\\[1, \infty)\\ |
| popsize | integer | \- |  | \\\[1, \infty)\\ |
| mutations | numeric | \- |  | \\\[0, 1\]\\ |
| reltol | numeric | \- |  | \\\[0, \infty)\\ |
| verbose | logical | \- | TRUE, FALSE | \- |

## References

Dhillon, S I, Modha, S D (2001). “Concept decompositions for large
sparse text data using clustering.” *Machine Learning*, **42**(1),
143–175.
[doi:10.1023/A:1007612920971](https://doi.org/10.1023/A%3A1007612920971)
.

Hornik, Kurt, Feinerer, Ingo, Kober, Martin, Buchta, Christian (2012).
“Spherical k-Means Clustering.” *Journal of Statistical Software*,
**50**(10), 1–22.
[doi:10.18637/jss.v050.i10](https://doi.org/10.18637/jss.v050.i10) .

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
[`mlr_learners_clust.kproto`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.kproto.md),
[`mlr_learners_clust.mclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.mclust.md),
[`mlr_learners_clust.meanshift`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.meanshift.md),
[`mlr_learners_clust.movMF`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.movMF.md),
[`mlr_learners_clust.optics`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.optics.md),
[`mlr_learners_clust.pam`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.pam.md),
[`mlr_learners_clust.protoclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.protoclust.md),
[`mlr_learners_clust.som`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.som.md),
[`mlr_learners_clust.specc`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.specc.md),
[`mlr_learners_clust.stdbscan`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.stdbscan.md),
[`mlr_learners_clust.tclust`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.tclust.md),
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`LearnerClust`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.md)
-\> `LearnerClustSKMeans`

## Methods

### Public methods

- [`LearnerClustSKMeans$new()`](#method-LearnerClustSKMeans-initialize)

- [`LearnerClustSKMeans$clone()`](#method-LearnerClustSKMeans-clone)

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

### `LearnerClustSKMeans$new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    LearnerClustSKMeans$new()

------------------------------------------------------------------------

### `LearnerClustSKMeans$clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustSKMeans$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.skmeans")
print(learner)
#> 
#> ── <LearnerClustSKMeans> (clust.skmeans): Spherical K-Means ────────────────────
#> • Model: -
#> • Parameters: k=2
#> • Packages: mlr3, mlr3cluster, and skmeans
#> • Predict Types: [partition]
#> • Feature Types: logical, integer, and numeric
#> • Encapsulation: none (fallback: -)
#> • Properties: complete, exclusive, and partitional
#> • Other settings: use_weights = 'error', predict_raw = 'FALSE'

# Define a Task
task = tsk("usarrests")

# Train the learner on the task
learner$train(task)

# Print the model
print(learner$model)
#> A hard spherical k-means partition of 50 objects into 2 classes.
#> Class sizes: 33, 17
#> Call: skmeans::skmeans(x = as.matrix(task$data()), k = 2L, control = structure(list(), names = character(0)))

# Make predictions for the task
prediction = learner$predict(task)

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#> 0.03303237 
```
