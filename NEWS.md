# mlr3cluster (development version)

* feat: Add `clust.avg_between` measure for average between-cluster distance.
* feat: Add `clust.avg_within` measure for average within-cluster distance.
* feat: Add `clust.davies_bouldin` measure for the Davies-Bouldin index.
* feat: Add `clust.dunn2` measure for the alternative Dunn index using average distances.
* feat: Add `clust.entropy` measure for cluster size distribution entropy.
* feat: Add finite mixture model clustering learner `clust.flexmix` from the flexmix package.
* feat: Add Genie hierarchical clustering learner `clust.genie` from the genieclust package.
* feat: Add k-centroids cluster analysis learner `clust.kcca` from the flexclust package, supporting k-means, k-medians, spherical, Jaccard, and extended Jaccard families.
* feat: Add von Mises-Fisher mixture clustering learner `clust.movMF` from the movMF package.
* feat: Add `clust.pearsongamma` measure for the Pearson Gamma correlation between distances and cluster membership.
* feat: Add spherical k-means clustering learner `clust.skmeans` from the skmeans package.
* feat: Add self-organizing maps clustering learner `clust.som` from the kohonen package.
* feat: Add ST-DBSCAN clustering learner `clust.stdbscan` from the stdbscan package.
* feat: Add robust trimmed clustering learner `clust.tclust` from the tclust package.
* feat: Add `clust.wb_ratio` measure for the within/between distance ratio.
* feat: `LearnerClustDiana` gains the `stop.at.k` parameter from `cluster::diana()`.
* fix: Add `mlr3cluster` to `mlr_reflections$loaded_packages` to fix errors when using `mlr3cluster` in parallel.
* fix: `as_prediction_clust.data.frame()` no longer errors with `unused argument (with = FALSE)` when given a plain `data.frame`.
* fix: `clust.silhouette` now returns `NaN` instead of `0` when all observations belong to a single cluster, since the silhouette width is undefined for k < 2.
* fix: `LearnerClustCMeans` now reports a proper error message when an invalid `weights` value is given instead of failing with a type error.
* fix: `LearnerClustCMeans`, `LearnerClustFanny`, and `LearnerClustMclust` now declare the `exclusive` property, consistent with the other learners supporting the `prob` predict type.
* fix: `LearnerClustCMeans`, `LearnerClustKKMeans`, and `LearnerClustKMeans` now accept a matrix of initial cluster centers for the `centers` parameter, matching the upstream functions.
* fix: `LearnerClustCobweb` now declares the `hierarchical` property instead of `partitional`.
* fix: `LearnerClustDBSCAN`, `LearnerClustDBSCANfpc`, `LearnerClustHDBSCAN`, `LearnerClustOPTICS`, `LearnerClustSTDBSCAN`, and `LearnerClustTclust` now declare the `partial` property instead of `complete`, since these algorithms can leave observations unassigned (noise or trimmed points labeled 0).
* fix: `LearnerClustFeatureless` now declares the `fuzzy` property, since it supports the `prob` predict type.
* fix: `LearnerClustFeatureless` now returns `prob` predictions whose most probable cluster matches the predicted `partition`.
* fix: `LearnerClustMeanShift` now declares the `density` property instead of `partitional`.
* perf: `LearnerClustAgnes` now exposes `keep.diss` and `keep.data` from `cluster::agnes()`, both initialized to `FALSE` to avoid storing the dissimilarity matrix and training data in the model.
* perf: `LearnerClustAP` now defaults `includeSim` to `FALSE` to avoid storing the n x n similarity matrix in the model. Set `includeSim = TRUE` to restore the previous behavior.
* perf: `LearnerClustCLARA` now defaults `keep.data` to `FALSE` to avoid storing the training data in the model. Set `keep.data = TRUE` to restore the previous behavior.
* perf: `LearnerClustDiana` now exposes `keep.diss` and `keep.data` from `cluster::diana()`, both initialized to `FALSE` to avoid storing the dissimilarity matrix and training data in the model.
* perf: `LearnerClustFanny` now exposes `keep.diss` and `keep.data` from `cluster::fanny()`, both initialized to `FALSE` to avoid storing the dissimilarity matrix and training data in the model.
* perf: `LearnerClustKProto` now exposes `keep.data` from `clustMixType::kproto()`, initialized to `FALSE` to avoid storing the training data in the model.
* perf: `LearnerClustPAM` now exposes `keep.diss` and `keep.data` from `cluster::pam()`, both initialized to `FALSE` to avoid storing the dissimilarity matrix and training data in the model.
* perf: `LearnerClustTclust` now exposes `store_x` from `tclust::tclust()`, initialized to `FALSE` to avoid storing the training data in the model.
* refactor: Clustering quality measures (`clust.ch`, `clust.dunn`, `clust.wss`) are now computed natively instead of relying on `fpc::cluster.stats()`. The `fpc` package is no longer a hard dependency.

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
