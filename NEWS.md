# mlr3cluster (development version)

## New learners

* `clust.gmeans`: G-means clustering from the gmeans package, which extends k-means by automatically determining the number of clusters.
* `clust.kmeans_rcpp`: K-means clustering via `ClusterR::KMeans_rcpp()` from the ClusterR package.
* `clust.kmodes`: K-modes clustering for categorical data from the klaR package.

## New measures

* `clust.sse_ratio`: Ratio of the within-cluster sum of squares to the total sum of squares, the standard quantity for elbow plots.

## Other improvements

* `clust.ap` now breaks similarity ties deterministically when predicting, matching the assignment rule of the apcluster package.
* `clust.bico` and `clust.kcca` now require `k >= 2`, which both already needed but advertised as `k >= 1`, so setting `k = 1` errors when set instead of failing during training.
* `clust.cobweb` now exposes the `output_debug_info` parameter, which the other RWeka-based learners already had.
* `clust.hclust` and `clust.protoclust` now bound the Minkowski power `p` below at 0, which was previously unbounded even though `stats::dist()` rejects non-positive values.
* `clust.kkmeans` now breaks distance ties when predicting with `"first"` instead of `"random"`, so predictions are reproducible without setting a seed.
* `clust.meanshift` now predicts on new data by running the mean-shift iteration from each observation with the trained bandwidth and assigning it to the mode it converges to, instead of warning and returning the training partition.
* `clust.protoclust` now predicts on new data by assigning each observation to the cluster of the nearest prototype, instead of warning and returning the training partition. The model is now a list with the fitted object and the training data.

# mlr3cluster 0.4.1

## Bug fixes

* `clust.agnes`, `clust.diana`, `clust.genie`, `clust.hclust`, and `clust.protoclust` now cut the tree at the current `k` when predicting, so changing `k` between training and prediction takes effect.
* `clust.ap` no longer errors when affinity propagation finds a single cluster.
* `clust.bico` now reclusters the BICO coreset with k-means via `stream::DSC_TwoStage()`, so `k` determines the number of predicted clusters instead of returning the raw micro-clusters. Training warns when the coreset is too small to produce `k` clusters.
* `clust.clara` now errors informatively when predicting with `metric = "jaccard"` or `medoids.x = FALSE` instead of failing with an obscure upstream error.
* `clust.dbscan_fpc` now errors informatively when predicting after training with `seeds = FALSE` instead of failing with an obscure upstream error.
* `clust.flexmix` now trains via `flexmix::stepFlexmix()`, so `nrep` actually runs repeated EM initializations and keeps the best fit instead of being silently ignored. Setting `nrep` together with `cluster` now errors.
* `clust.genie`, `clust.kkmeans`, and `clust.kproto` now error informatively during training when the task has fewer than 2 features, which the upstream implementations cannot handle.
* `clust.kkmeans` now predicts by assigning observations to the nearest cluster centroid in the kernel-induced feature space, since input-space distances produced wrong assignments for nonlinear kernels. The model is now a list with the fitted object, training data, and per-cluster kernel statistics.
* `clust.movMF` now derives the stored `$assignments` from the predict method, so predicting on the training data yields the training assignments.
* `clust.som` now predicts and derives the stored `$assignments` via `kohonen::map()`, so models trained with `keep.data = FALSE` no longer fail at predict or store empty assignments.
* `clust.stdbscan` now errors during training when the task does not have exactly 3 features (two spatial coordinates and one temporal coordinate) instead of silently using the wrong columns.
* `clust.tclust` no longer exposes the `iter.max` parameter, which is deprecated in tclust 2.0 in favor of `niter1`, `niter2`, and `nkeep`.
* `clust.wss` and `clust.entropy` now return `NaN` instead of 0 for empty predictions, which for `clust.wss` silently skewed aggregated resampling scores.
* `PredictionClust`: combined and empty prediction data now retain the `PredictionData` class, so `resample()` no longer errors on resampling iterations with an empty test set.
* `PredictionClust`: when the partition is derived from a probability matrix, it now uses the cluster labels from the column names instead of the column positions.
* `PredictionClust`: empty prob predictions now combine with non-empty ones without error and no longer serialize a spurious `prob.V1` column via `as.data.table()`.
* `PredictionClust`: `as.data.table()` no longer drops the partition column for prob-only predictions constructed with `check = FALSE`, returning `NA` partitions instead.

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

* Learners no longer store the training data or dissimilarity matrix in the model by default: `clust.agnes`, `clust.diana`, `clust.fanny`, and `clust.pam` now expose `keep.diss` and `keep.data`, `clust.clara` and `clust.kproto` expose `keep.data`, and `clust.ap` exposes `includeSim`, all initialized to `FALSE`. Set the respective parameter to `TRUE` to restore the previous behavior.
* Clustering quality measures `clust.ch`, `clust.dunn`, and `clust.wss` are now computed natively instead of relying on `fpc::cluster.stats()`. The fpc package is no longer a hard dependency.
* `clust.cobweb`, `clust.em`, `clust.ff`, `clust.SimpleKMeans`, and `clust.xmeans` now declare the `missings` property, since Weka handles missing attribute values natively.
* `clust.diana` gains the `stop.at.k` parameter from `cluster::diana()`.
* `clust.em` drops the `exclusive` property and `clust.MBatchKMeans` drops `fuzzy`. Use the `prob` predict type to select learners with soft memberships.

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
