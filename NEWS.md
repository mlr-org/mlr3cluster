# mlr3cluster (development version)

* feat: `Mlr3Error` and `Mlr3Warning` classes for errors and warnings.
* {mlr3cluster} now requires R 3.4.0. Following {data.table} minimum R version.

# mlr3cluster 0.1.12

* feat: Add `cluster_selection_epsilon` parameter to HDBSCAN learner and
  initialize `minPts` to 5.
* docs: Better learner example section

# mlr3cluster 0.1.11

* fix: Mclust learner no longer sets the control default with a function not in
  import to stay compliant with {paradox} conventions

# mlr3cluster 0.1.10

* feat: Add BIRCH learner from 'stream' package
* feat: Add BICO learner from 'stream' package

# mlr3cluster 0.1.9

* feat: Add DBSCAN learner from 'fpc' package
* feat: Add HDBSCAN learner from 'dbscan' package
* feat: Add OPTICS learner from 'dbscan' package
* chore: Compatibility with upcoming 'paradox' release
* chore: Move to testthat3
* refactor: General code refactoring

# mlr3cluster 0.1.8

* feat: Add new task based on `ruspini` dataset

# mlr3cluster 0.1.7

* chore: Replace 'clusterCrit' measures with alternatives from 'cluster' and 'fpc' packages
* fix: Remove broken unloading test

# mlr3cluster 0.1.6

* feat: Add states as row names to `usarrest` task
* fix: Remove dictionary items after unloading package

# mlr3cluster 0.1.5

* feat: Add Mclust learner
* fix: Fix error associated with new dbscan release

# mlr3cluster 0.1.4

* refactor: General code refactoring

# mlr3cluster 0.1.3

* refactor: General code refactoring
* fix: Small bug fixes
* feat: Add filter to PredictionClust

# mlr3cluster 0.1.2

* feat: Add Hclust learner
* docs: Add tests and documentation for Hclust
* feat: Add within sum of squares measure
* docs: Add documentation for WSS measure
* refactor: Code factor adaptations

# mlr3cluster 0.1.1

* feat: Add eight new learners
* feat: Add `assignments` and `save_assignments` fields to `LearnerClust` class

# mlr3cluster 0.1.0

* Initial upload to CRAN
