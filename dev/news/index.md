# Changelog

## mlr3cluster (development version)

- feat: Add `cluster_selection_epsilon` parameter to HDBSCAN learner and
  initialize `minPts` to 5.
- docs: Better learner example section

## mlr3cluster 0.1.11

CRAN release: 2025-02-18

- fix: Mclust learner no longer sets the control default with a function
  not in import to stay compliant with {paradox} conventions

## mlr3cluster 0.1.10

CRAN release: 2024-10-03

- feat: Add BIRCH learner from ‘stream’ package
- feat: Add BICO learner from ‘stream’ package

## mlr3cluster 0.1.9

CRAN release: 2024-03-18

- feat: Add DBSCAN learner from ‘fpc’ package
- feat: Add HDBSCAN learner from ‘dbscan’ package
- feat: Add OPTICS learner from ‘dbscan’ package
- chore: Compatibility with upcoming ‘paradox’ release
- chore: Move to testthat3
- refactor: General code refactoring

## mlr3cluster 0.1.8

CRAN release: 2023-03-12

- feat: Add new task based on `ruspini` dataset

## mlr3cluster 0.1.7

CRAN release: 2023-03-10

- chore: Replace ‘clusterCrit’ measures with alternatives from ‘cluster’
  and ‘fpc’ packages
- fix: Remove broken unloading test

## mlr3cluster 0.1.6

CRAN release: 2022-12-22

- feat: Add states as row names to `usarrest` task
- fix: Remove dictionary items after unloading package

## mlr3cluster 0.1.5

CRAN release: 2022-11-01

- feat: Add Mclust learner
- fix: Fix error associated with new dbscan release

## mlr3cluster 0.1.4

CRAN release: 2022-08-14

- refactor: General code refactoring

## mlr3cluster 0.1.3

CRAN release: 2022-04-06

- refactor: General code refactoring
- fix: Small bug fixes
- feat: Add filter to PredictionClust

## mlr3cluster 0.1.2

CRAN release: 2021-09-02

- feat: Add Hclust learner
- docs: Add tests and documentation for Hclust
- feat: Add within sum of squares measure
- docs: Add documentation for WSS measure
- refactor: Code factor adaptations

## mlr3cluster 0.1.1

CRAN release: 2020-11-15

- feat: Add eight new learners
- feat: Add `assignments` and `save_assignments` fields to
  `LearnerClust` class

## mlr3cluster 0.1.0

CRAN release: 2020-10-01

- Initial upload to CRAN
