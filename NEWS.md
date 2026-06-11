# mlr3cluster 0.4.0

## New learners

* `clust.flexmix`: Finite mixture model clustering from the flexmix package.
* `clust.genie`: Genie hierarchical clustering from the genieclust package.
* `clust.kcca`: K-centroids cluster analysis from the flexclust package, supporting k-means, k-medians, spherical, Jaccard, and extended Jaccard families.
* `clust.movMF`: Von Mises-Fisher mixture clustering from the movMF package.
* `clust.skmeans`: Spherical k-means clustering from the skmeans package.
* `clust.som`: Self-organizing maps from the kohonen package.
* `clust.stdbscan`: ST-DBSCAN spatio-temporal clustering from the stdbscan package (#83).
* `clust.tclust`: Robust trimmed clustering from the tclust package.

## New measures

* `clust.avg_between`: Average between-cluster distance.
* `clust.avg_within`: Average within-cluster distance.
* `clust.davies_bouldin`: Davies-Bouldin index.
* `clust.dunn2`: Alternative Dunn index using average distances.
* `clust.entropy`: Cluster size distribution entropy.
* `clust.pearsongamma`: Pearson Gamma correlation between distances and cluster membership.
* `clust.wb_ratio`: Within/between distance ratio.

## Other improvements

* Learner properties now describe the clustering method itself rather than its outputs: each learner declares exactly one membership property, so `clust.em` drops `exclusive` and `clust.MBatchKMeans` drops `fuzzy`. Use the `prob` predict type to select learners with soft memberships.
* Learners no longer store the training data or dissimilarity matrix in the model by default: `clust.agnes`, `clust.diana`, `clust.fanny`, and `clust.pam` now expose `keep.diss` and `keep.data`, `clust.clara` and `clust.kproto` expose `keep.data`, and `clust.ap` exposes `includeSim`, all initialized to `FALSE`. Set the respective parameter to `TRUE` to restore the previous behavior.
* Clustering quality measures `clust.ch`, `clust.dunn`, and `clust.wss` are now computed natively instead of relying on `fpc::cluster.stats()`. The fpc package is no longer a hard dependency.
* `clust.cobweb`, `clust.em`, `clust.ff`, `clust.SimpleKMeans`, and `clust.xmeans` now declare the `missings` property, since Weka handles missing attribute values natively.
* `clust.diana` gains the `stop.at.k` parameter from `cluster::diana()`.

## Bug fixes

* `mlr3cluster` is now added to `mlr_reflections$loaded_packages` to fix errors when using the package in parallel.
* `as_prediction_clust.data.frame()` no longer errors with `unused argument (with = FALSE)` when given a plain `data.frame`.
* `clust.cmeans` now reports a proper error message when an invalid `weights` value is given instead of failing with a type error.
* `clust.cmeans`, `clust.kkmeans`, and `clust.kmeans` now accept a matrix of initial cluster centers for the `centers` parameter, matching the upstream functions.
* `clust.cobweb` now declares the `hierarchical` property instead of `partitional`, and `clust.meanshift` declares `density` instead of `partitional`.
* `clust.dbscan`, `clust.dbscan_fpc`, `clust.hdbscan`, and `clust.optics` now declare the `partial` property instead of `complete`, since these algorithms can leave observations unassigned (noise points labeled 0).
* `clust.featureless` now returns `prob` predictions whose most probable cluster matches the predicted `partition`, with cluster column names consistent with the other learners supporting the `prob` predict type.
* `clust.silhouette` now returns `NaN` instead of `0` when all observations belong to a single cluster, since the silhouette width is undefined for k < 2.

# mlr3cluster 0.3.0

* feat: Add CLARA clustering learner `clust.clara` from the cluster package.
* feat: Add k-prototypes clustering learner `clust.kproto` from the clustMixType package.
* feat: Add spectral clustering learner `clust.specc` from the kernlab package.
* fix: `LearnerClustDBSCANfpc` now correctly passes the `newdata` argument in the predict method.
* fix: `LearnerClustKKMeans` now correctly passes kernel parameters via the `kpar` list to `kernlab::kkmeans()`.
* fix: `clust.silhouette` measure now has the correct range of `[-1, 1]`.
* docs: Fix typos in measure documentation.

# mlr3cluster 0.2.0

* feat: `Mlr3Error` and `Mlr3Warning` classes for errors and warnings.
* feat: Add protoclust learner from the protoclust package.
* feat: EM learner now supports probabilistic assignments.
* fix: Update learner parameter sets to match upstream package changes.
* docs: Documentation improvements.
* chore: mlr3cluster now requires R 3.4.0. Following data.table's minimum R version.
* chore: mlr3cluster now requires mlr3 (>= 1.3.0) and mlr3misc (>= 0.19.0).

# mlr3cluster 0.1.12

* feat: Add `cluster_selection_epsilon` parameter to HDBSCAN learner and
  initialize `minPts` to 5.
* docs: Better learner example section.

# mlr3cluster 0.1.11

* fix: Mclust learner no longer sets the control default with a function not in
  import to stay compliant with paradox package conventions.

# mlr3cluster 0.1.10

* feat: Add BIRCH learner from the stream package.
* feat: Add BICO learner from the stream package.

# mlr3cluster 0.1.9

* feat: Add DBSCAN learner from the fpc package.
* feat: Add HDBSCAN learner from the dbscan package.
* feat: Add OPTICS learner from the dbscan package.
* chore: Compatibility with upcoming paradox release.
* chore: Move to testthat3.
* refactor: General code refactoring.

# mlr3cluster 0.1.8

* feat: Add new task based on `ruspini` dataset.

# mlr3cluster 0.1.7

* chore: Replace 'clusterCrit' measures with alternatives from cluster and fpc packages.
* fix: Remove broken unloading test.

# mlr3cluster 0.1.6

* feat: Add states as row names to `usarrests` task.
* fix: Remove dictionary items after unloading package.

# mlr3cluster 0.1.5

* feat: Add Mclust learner.
* fix: Fix error associated with new dbscan release.

# mlr3cluster 0.1.4

* refactor: General code refactoring.

# mlr3cluster 0.1.3

* feat: Add filter to `PredictionClust`.
* fix: Small bug fixes.
* refactor: General code refactoring.

# mlr3cluster 0.1.2

* feat: Add Hclust learner.
* feat: Add within sum of squares measure.
* docs: Add tests and documentation for Hclust.
* docs: Add documentation for WSS measure.
* refactor: Code factor adaptations.

# mlr3cluster 0.1.1

* feat: Add eight new learners.
* feat: Add `assignments` and `save_assignments` fields to `LearnerClust` class.

# mlr3cluster 0.1.0

* Initial upload to CRAN.
