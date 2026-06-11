# K-Centroids Cluster Analysis Learner

K-Centroids Cluster Analysis - a unified framework for partitional
clustering with selectable distance / centroid families: standard
k-means, k-medians, spherical k-means (`"angle"`), Jaccard, and extended
Jaccard. Calls
[`flexclust::kcca()`](https://rdrr.io/pkg/flexclust/man/kcca.html) from
package [flexclust](https://CRAN.R-project.org/package=flexclust).

The `k` parameter is set to 2 by default since
[`flexclust::kcca()`](https://rdrr.io/pkg/flexclust/man/kcca.html) has
no default value for the number of clusters. Predictions dispatch to
flexclust's S4 `predict` method via
`methods::getMethod("predict", "kccasimple")` rather than calling
[`predict()`](https://rdrr.io/r/stats/predict.html) directly, since both
flexclust and kernlab define an S4 class named `"kcca"` and the
resulting class-cache collision can break S4 dispatch when both packages
are loaded.

## Dictionary

This [mlr3::Learner](https://mlr3.mlr-org.com/reference/Learner.html)
can be instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_learners](https://mlr3.mlr-org.com/reference/mlr_learners.html)
or with the associated sugar function
[`mlr3::lrn()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_learners$get("clust.kcca")
    lrn("clust.kcca")

## Meta Information

- Task type: “clust”

- Predict Types: “partition”

- Feature Types: “logical”, “integer”, “numeric”

- Required Packages: [mlr3](https://CRAN.R-project.org/package=mlr3),
  [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster),
  [flexclust](https://CRAN.R-project.org/package=flexclust)

## Parameters

|  |  |  |  |  |
|----|----|----|----|----|
| Id | Type | Default | Levels | Range |
| k | integer | \- |  | \\\[1, \infty)\\ |
| family | character | kmeans | kmeans, kmedians, angle, jaccard, ejaccard | \- |
| weights | untyped | \- |  | \- |
| group | untyped | \- |  | \- |
| simple | logical | FALSE | TRUE, FALSE | \- |
| save.data | logical | FALSE | TRUE, FALSE | \- |
| iter.max | integer | 200 |  | \\\[1, \infty)\\ |
| tolerance | numeric | 1e-06 |  | \\\[0, \infty)\\ |
| verbose | integer | 0 |  | \\\[0, \infty)\\ |
| classify | character | auto | auto, weighted, hard | \- |
| initcent | untyped | \- |  | \- |
| gamma | numeric | 1 |  | \\\[0, \infty)\\ |
| ntry | integer | 5 |  | \\\[1, \infty)\\ |
| min.size | integer | 2 |  | \\\[1, \infty)\\ |

## References

Leisch, Friedrich (2006). “A Toolbox for K-Centroids Cluster Analysis.”
*Computational Statistics & Data Analysis*, **51**(2), 526–544.
[doi:10.1016/j.csda.2005.10.006](https://doi.org/10.1016/j.csda.2005.10.006)
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
[`mlr_learners_clust.MBatchKMeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.MBatchKMeans.md),
[`mlr_learners_clust.SimpleKMeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.SimpleKMeans.md),
[`mlr_learners_clust.agnes`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.agnes.md),
[`mlr_learners_clust.ap`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.ap.md),
[`mlr_learners_clust.bico`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.bico.md),
[`mlr_learners_clust.birch`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.birch.md),
[`mlr_learners_clust.clara`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.clara.md),
[`mlr_learners_clust.cmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cmeans.md),
[`mlr_learners_clust.cobweb`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cobweb.md),
[`mlr_learners_clust.dbscan`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan.md),
[`mlr_learners_clust.dbscan_fpc`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan_fpc.md),
[`mlr_learners_clust.diana`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.diana.md),
[`mlr_learners_clust.em`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.em.md),
[`mlr_learners_clust.fanny`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.fanny.md),
[`mlr_learners_clust.featureless`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.featureless.md),
[`mlr_learners_clust.ff`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.ff.md),
[`mlr_learners_clust.flexmix`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.flexmix.md),
[`mlr_learners_clust.genie`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.genie.md),
[`mlr_learners_clust.hclust`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.hclust.md),
[`mlr_learners_clust.hdbscan`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.hdbscan.md),
[`mlr_learners_clust.kkmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kkmeans.md),
[`mlr_learners_clust.kmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kmeans.md),
[`mlr_learners_clust.kproto`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kproto.md),
[`mlr_learners_clust.mclust`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.mclust.md),
[`mlr_learners_clust.meanshift`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.meanshift.md),
[`mlr_learners_clust.movMF`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.movMF.md),
[`mlr_learners_clust.optics`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.optics.md),
[`mlr_learners_clust.pam`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.pam.md),
[`mlr_learners_clust.protoclust`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.protoclust.md),
[`mlr_learners_clust.skmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.skmeans.md),
[`mlr_learners_clust.som`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.som.md),
[`mlr_learners_clust.specc`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.specc.md),
[`mlr_learners_clust.stdbscan`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.stdbscan.md),
[`mlr_learners_clust.tclust`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.tclust.md),
[`mlr_learners_clust.xmeans`](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.xmeans.md)

## Super classes

[`mlr3::Learner`](https://mlr3.mlr-org.com/reference/Learner.html) -\>
[`LearnerClust`](https://mlr3cluster.mlr-org.com/reference/LearnerClust.md)
-\> `LearnerClustKCCA`

## Methods

### Public methods

- [`LearnerClustKCCA$new()`](#method-LearnerClustKCCA-initialize)

- [`LearnerClustKCCA$clone()`](#method-LearnerClustKCCA-clone)

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
- [`LearnerClust$reset()`](https://mlr3cluster.mlr-org.com/reference/LearnerClust.html#method-reset)

------------------------------------------------------------------------

### `LearnerClustKCCA$new()`

Creates a new instance of this
[R6](https://r6.r-lib.org/reference/R6Class.html) class.

#### Usage

    LearnerClustKCCA$new()

------------------------------------------------------------------------

### `LearnerClustKCCA$clone()`

The objects of this class are cloneable with this method.

#### Usage

    LearnerClustKCCA$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# Define the Learner and set parameter values
learner = lrn("clust.kcca")
print(learner)
#> 
#> ── <LearnerClustKCCA> (clust.kcca): K-Centroids Cluster Analysis ───────────────
#> • Model: -
#> • Parameters: k=2
#> • Packages: mlr3, mlr3cluster, and flexclust
#> • Predict Types: [partition]
#> • Feature Types: logical, integer, and numeric
#> • Encapsulation: none (fallback: -)
#> • Properties: complete, exclusive, and partitional
#> • Other settings: use_weights = 'error', predict_raw = 'FALSE'

# Define a Task
task = tsk("usarrests")

# Train the learner on the task
learner$train(task)
#> Found more than one class "kcca" in cache; using the first, from namespace 'kernlab'
#> Also defined by ‘flexclust’
#> Found more than one class "kcca" in cache; using the first, from namespace 'kernlab'
#> Also defined by ‘flexclust’

# Print the model
print(learner$model)
#> kcca object of family ‘kmeans’ 
#> 
#> call:
#> flexclust::kcca(x = as.matrix(task$data()), k = 2L, family = new("kccaFamily", 
#>     name = "kmeans", dist = function (x, centers) 
#>     {
#>         if (ncol(x) != ncol(centers)) 
#>             stop(sQuote("x"), " and ", sQuote("centers"), " must have the same number of columns")
#>         z <- matrix(0, nrow = nrow(x), ncol = nrow(centers))
#>         for (k in 1:nrow(centers)) {
#>             z[, k] <- sqrt(colSums((t(x) - centers[k, ])^2))
#>         }
#>         z
#>     }, cent = function (x) 
#>     colMeans(x), allcent = function (x, cluster, k = max(cluster, 
#>         na.rm = TRUE)) 
#>     {
#>         centers <- matrix(NA, nrow = k, ncol = ncol(x))
#>         for (n in 1:k) {
#>             if (sum(cluster == n, na.rm = TRUE) > 0) {
#>                 centers[n, ] <- z@cent(x[cluster == n, , drop = FALSE])
#>             }
#>         }
#>         centers
#>     }, wcent = function (x, weights) 
#>     colMeans(x * normWeights(weights)), weighted = TRUE, cluster = function (x, 
#>         centers, n = 1, distmat = NULL) 
#>     {
#>         if (is.null(distmat)) 
#>             distmat <- z@dist(x, centers)
#>         if (n == 1) {
#>             return(max.col(-distmat))
#>         }
#>         else {
#>             r <- t(matrix(apply(distmat, 1, rank, ties.method = "random"), 
#>                 nrow = ncol(distmat)))
#>             z <- list()
#>             for (k in 1:n) z[[k]] <- apply(r, 1, function(x) which(x == 
#>                 k))
#>         }
#>         return(z)
#>     }, preproc = function (x) 
#>     x, groupFun = function (cluster, group, distmat) 
#>     {
#>         G <- levels(group)
#>         x <- matrix(0, ncol = ncol(distmat), nrow = length(G))
#>         for (n in 1:length(G)) {
#>             x[n, ] <- colSums(distmat[group == G[n], , drop = FALSE])
#>         }
#>         m <- max.col(-x)
#>         names(m) <- G
#>         z <- m[group]
#>         names(z) <- NULL
#>         if (is.list(cluster)) {
#>             x[cbind(1:nrow(x), m)] <- Inf
#>             m <- max.col(-x)
#>             names(m) <- G
#>             z1 <- m[group]
#>             names(z1) <- NULL
#>             z <- list(z, z1)
#>         }
#>         z
#>     }, genDist = function () 
#>     NULL))
#> 
#> cluster sizes:
#> 
#>  1  2 
#> 21 29 
#> 

# Make predictions for the task
prediction = learner$predict(task)

# Score the predictions
prediction$score(task = task)
#> clust.dunn 
#>  0.1033191 
```
