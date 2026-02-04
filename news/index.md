# Changelog

## mlr3cluster 0.2.0

CRAN release: 2026-02-04

- feat: `Mlr3Error` and `Mlr3Warning` classes for errors and warnings.
- feat: Add protoclust learner from the protoclust package.
- feat: EM learner now supports probabilistic assignments.
- fix: Update learner parameter sets to match upstream package changes.
- docs: Documentation improvements.
- chore: mlr3cluster now requires R 3.4.0. Following data.table’s
  minimum R version.
- chore: mlr3cluster now requires mlr3 (\>= 1.3.0) and mlr3misc (\>=
  0.19.0).

## mlr3cluster 0.1.12

CRAN release: 2025-11-19

- feat: Add `cluster_selection_epsilon` parameter to HDBSCAN learner and
  initialize `minPts` to 5.
- docs: Better learner example section.

## mlr3cluster 0.1.11

CRAN release: 2025-02-18

- fix: Mclust learner no longer sets the control default with a function
  not in import to stay compliant with paradox package conventions.

## mlr3cluster 0.1.10

CRAN release: 2024-10-03

- feat: Add BIRCH learner from the stream package.
- feat: Add BICO learner from the stream package.

## mlr3cluster 0.1.9

CRAN release: 2024-03-18

- feat: Add DBSCAN learner from the fpc package.
- feat: Add HDBSCAN learner from the dbscan package.
- feat: Add OPTICS learner from the dbscan package.
- chore: Compatibility with upcoming paradox release.
- chore: Move to testthat3.
- refactor: General code refactoring.

## mlr3cluster 0.1.8

CRAN release: 2023-03-12

- feat: Add new task based on `ruspini` dataset.

## mlr3cluster 0.1.7

CRAN release: 2023-03-10

- chore: Replace ‘clusterCrit’ measures with alternatives from cluster
  and fpc packages.
- fix: Remove broken unloading test.

## mlr3cluster 0.1.6

CRAN release: 2022-12-22

- feat: Add states as row names to `usarrest` task.
- fix: Remove dictionary items after unloading package.

## mlr3cluster 0.1.5

CRAN release: 2022-11-01

- feat: Add Mclust learner.
- fix: Fix error associated with new dbscan release.

## mlr3cluster 0.1.4

CRAN release: 2022-08-14

- refactor: General code refactoring.

## mlr3cluster 0.1.3

CRAN release: 2022-04-06

- feat: Add filter to `PredictionClust`.
- fix: Small bug fixes.
- refactor: General code refactoring.

## mlr3cluster 0.1.2

CRAN release: 2021-09-02

- feat: Add Hclust learner.
- feat: Add within sum of squares measure.
- docs: Add tests and documentation for Hclust.
- docs: Add documentation for WSS measure.
- refactor: Code factor adaptations.

## mlr3cluster 0.1.1

CRAN release: 2020-11-15

- feat: Add eight new learners.
- feat: Add `assignments` and `save_assignments` fields to
  `LearnerClust` class.

## mlr3cluster 0.1.0

CRAN release: 2020-10-01

- Initial upload to CRAN.
