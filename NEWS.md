# mlr3cluster (development version)

* fix: Mclust learner no longer sets the control default with a function not in
  import to stay compliant with {paradox} conventions

# mlr3cluster 0.1.10

* Add BIRCH learner from 'stream' package
* Add BICO learner from 'stream' package

# mlr3cluster 0.1.9

* Add DBSCAN learner from 'fpc' package
* Add HDBSCAN learner from 'dbscan' package
* Add OPTICS learner from 'dbscan' package
* Compatibility with upcoming 'paradox' release
* Move to testthat3
* Refactoring

# mlr3cluster 0.1.8

* Add new task based on `ruspini` dataset

# mlr3cluster 0.1.7

* Replace 'clusterCrit' measures with alternatives from 'cluster' and 'fpc' packages
* Remove broken unloading test

# mlr3cluster 0.1.6

* Add states as row names to `usarrest` task.
* Remove dictionary items after unloading package.

# mlr3cluster 0.1.5

* Added Mclust learner
* Fix error associated with new dbscan release

# mlr3cluster 0.1.4

* code refactoring

# mlr3cluster 0.1.3

* code refactoring
* small fixes
* add filter to PredictionClust

# mlr3cluster 0.1.2

* Add Hclust
* test and doc hclust
* Add within sum of squares measure
* add doc wss
* code factor adaptions

# mlr3cluster 0.1.1

*	Eight new learners
*	Added `assignments` and `save_assignments` fields to `LearnerClust` class

# mlr3cluster 0.1.0

*	Initial upload to CRAN
