# Robust Trimmed Clustering Learner

Robust trimmed clustering. Each cluster is modeled by a multivariate
Gaussian; the most outlying `alpha` fraction of observations is trimmed
and assigned to cluster `0`. Calls
[`tclust::tclust()`](https://rdrr.io/pkg/tclust/man/tclust.html) from
package [tclust](https://CRAN.R-project.org/package=tclust).

The `k` parameter is set to 2 by default since
[`tclust::tclust()`](https://rdrr.io/pkg/tclust/man/tclust.html) doesn't
have a default value for the number of clusters. There is no predict
method for
[`tclust::tclust()`](https://rdrr.io/pkg/tclust/man/tclust.html), so the
method returns cluster labels for the training data.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.tclust")
    lrn("clust.tclust")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [tclust](https://CRAN.R-project.org/package=tclust)

## Parameters

|                  |           |         |              |                       |
|------------------|-----------|---------|--------------|-----------------------|
| Id               | Type      | Default | Levels       | Range                 |
| k                | integer   | \-      |              | \\\[1, \infty)\\      |
| alpha            | numeric   | 0.05    |              | \\\[0, 0.5\]\\        |
| nstart           | integer   | 500     |              | \\\[1, \infty)\\      |
| niter1           | integer   | 3       |              | \\\[1, \infty)\\      |
| niter2           | integer   | 20      |              | \\\[1, \infty)\\      |
| nkeep            | integer   | 5       |              | \\\[1, \infty)\\      |
| iter.max         | integer   | \-      |              | \\\[1, \infty)\\      |
| equal.weights    | logical   | FALSE   | TRUE, FALSE  | \-                    |
| restr            | character | eigen   | eigen, deter | \-                    |
| restr.fact       | numeric   | 12      |              | \\\[1, \infty)\\      |
| cshape           | numeric   | 1e+10   |              | \\\[1, \infty)\\      |
| opt              | character | HARD    | HARD, MIXT   | \-                    |
| center           | logical   | FALSE   | TRUE, FALSE  | \-                    |
| scale            | logical   | FALSE   | TRUE, FALSE  | \-                    |
| parallel         | logical   | FALSE   | TRUE, FALSE  | \-                    |
| n.cores          | integer   | -1      |              | \\(-\infty, \infty)\\ |
| zero_tol         | numeric   | 1e-16   |              | \\\[0, \infty)\\      |
| drop.empty.clust | logical   | TRUE    | TRUE, FALSE  | \-                    |
| trace            | integer   | 0       |              | \\\[0, \infty)\\      |

## References

García-Escudero, A L, Gordaliza, Alfonso, Matrán, Carlos, Mayo-Iscar,
Agustín (2008). “A general trimming approach to robust cluster
analysis.” *The Annals of Statistics*, **36**(3), 1324–1345.
[doi:10.1214/07-AOS515](https://doi.org/10.1214/07-AOS515) .

Fritz, Heinrich, García-Escudero, A L, Mayo-Iscar, Agustín (2012).
“tclust: An R package for a trimming approach to cluster analysis.”
*Journal of Statistical Software*, **47**(12), 1–26.
[doi:10.18637/jss.v047.i12](https://doi.org/10.18637/jss.v047.i12) .

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
[`mlr_learners_clust.skmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.skmeans.md),
[`mlr_learners_clust.som`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.som.md),
[`mlr_learners_clust.specc`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.specc.md),
[`mlr_learners_clust.stdbscan`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.stdbscan.md),
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`LearnerClust`](https://mlr3cluster.mlr-org.com/dev/reference/LearnerClust.md)
-\> `LearnerClustTclust`

## Methods

### Public methods

- [`LearnerClustTclust$new()`](#method-LearnerClustTclust-initialize)

- [`LearnerClustTclust$clone()`](#method-LearnerClustTclust-clone)

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

### `LearnerClustTclust$new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    LearnerClustTclust$new()

------------------------------------------------------------------------

### `LearnerClustTclust$clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustTclust$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.tclust")
print(learner)
#> 
#> ── <LearnerClustTclust> (clust.tclust): Robust Trimmed Clustering ──────────────
#> • Model: -
#> • Parameters: k=2
#> • Packages: mlr3, mlr3cluster, and tclust
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
#> * Results for TCLUST algorithm: *
#> opt=HARD, trim = 0.05, k = 2
#> Restriction on: eigenvalues
#> 
#> Classification (trimmed points are indicated by 0 ):
#>  [1] 2 2 2 2 2 2 1 2 0 2 0 1 2 1 1 1 1 2 1 2 1 2 1 2 2 1 1 2 1 1 2 2 0 1 1 1 1 1
#> [39] 1 2 1 2 2 1 1 1 1 1 1 1
#> Means:
#>                C 1    C 2
#> Assault  109.59259 243.05
#> Murder     4.67037  11.48
#> Rape      15.65926  28.53
#> UrbanPop  63.11111  68.25
#> 
#> Trimmed objective function:  -752.9647 
#> Selected restriction factor: 12 

# Make predictions for the task
prediction = learner$predict(task)
#> Warning: 
#> ✖ Learner 'clust.tclust' doesn't predict on new data and predictions may not
#>   make sense on new data.
#> → Class: Mlr3WarningInput

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#> 0.06709199 
```
