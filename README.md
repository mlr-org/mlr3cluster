
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mlr3cluster

Package website: [release](https://mlr3cluster.mlr-org.com/) \|
[dev](https://mlr3cluster.mlr-org.com/dev/)

Cluster analysis for **[mlr3](https://github.com/mlr-org/mlr3/)**.

<!-- badges: start -->

[![r-cmd-check](https://github.com/mlr-org/mlr3cluster/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/mlr-org/mlr3cluster/actions/workflows/r-cmd-check.yml)
[![CRAN
status](https://www.r-pkg.org/badges/version/mlr3cluster)](https://CRAN.R-project.org/package=mlr3cluster)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-mlr3-orange.svg)](https://stackoverflow.com/questions/tagged/mlr3)
[![Mattermost](https://img.shields.io/badge/chat-mattermost-orange.svg)](https://lmmisld-lmu-stats-slds.srv.mwn.de/mlr_invite/)
<!-- badges: end -->

**mlr3cluster** is an extension package for cluster analysis within the
**[mlr3](https://github.com/mlr-org/mlr3)** ecosystem. It is a successor
of clustering capabilities of
**[mlr2](https://github.com/mlr-org/mlr)**.

## Installation

Install the last release from CRAN:

``` r
install.packages("mlr3cluster")
```

Install the development version from GitHub:

``` r
# install.packages("pak")
pak::pak("mlr-org/mlr3cluster")
```

## Feature Overview

The current version of **mlr3cluster** contains:

- A selection of 24 clustering learners that represent a wide variety of
  clusterers: partitional, hierarchical, fuzzy, etc.
- A selection of 4 performance measures
- Two built-in tasks to get started with clustering

Also, the package is integrated with
**[mlr3viz](https://github.com/mlr-org/mlr3viz)** which enables you to
create great visualizations with just one line of code!

## Cluster Analysis

### Cluster Learners

| Key | Label | Packages |
|:---|:---|:---|
| [clust.MBatchKMeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.MBatchKMeans) | Mini Batch K-Means | [ClusterR](https://cran.r-project.org/package=ClusterR) |
| [clust.SimpleKMeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.SimpleKMeans) | K-Means (Weka) | [RWeka](https://cran.r-project.org/package=RWeka) |
| [clust.agnes](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.agnes) | Agglomerative Hierarchical Clustering | [cluster](https://cran.r-project.org/package=cluster) |
| [clust.ap](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.ap) | Affinity Propagation Clustering | [apcluster](https://cran.r-project.org/package=apcluster) |
| [clust.bico](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.bico) | BICO Clustering | [stream](https://cran.r-project.org/package=stream) |
| [clust.birch](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.birch) | BIRCH Clustering | [stream](https://cran.r-project.org/package=stream) |
| [clust.cmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cmeans) | Fuzzy C-Means Clustering Learner | [e1071](https://cran.r-project.org/package=e1071) |
| [clust.cobweb](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cobweb) | Cobweb Clustering | [RWeka](https://cran.r-project.org/package=RWeka) |
| [clust.dbscan](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan) | Density-Based Clustering | [dbscan](https://cran.r-project.org/package=dbscan) |
| [clust.dbscan_fpc](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan_fpc) | Density-Based Clustering with fpc | [fpc](https://cran.r-project.org/package=fpc) |
| [clust.diana](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.diana) | Divisive Hierarchical Clustering | [cluster](https://cran.r-project.org/package=cluster) |
| [clust.em](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.em) | Expectation-Maximization Clustering | [RWeka](https://cran.r-project.org/package=RWeka) |
| [clust.fanny](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.fanny) | Fuzzy Analysis Clustering | [cluster](https://cran.r-project.org/package=cluster) |
| [clust.featureless](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.featureless) | Featureless Clustering |  |
| [clust.ff](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.ff) | Farthest First Clustering | [RWeka](https://cran.r-project.org/package=RWeka) |
| [clust.hclust](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.hclust) | Agglomerative Hierarchical Clustering | stats |
| [clust.hdbscan](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.hdbscan) | HDBSCAN Clustering | [dbscan](https://cran.r-project.org/package=dbscan) |
| [clust.kkmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kkmeans) | Kernel K-Means | [kernlab](https://cran.r-project.org/package=kernlab) |
| [clust.kmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kmeans) | K-Means | stats, [clue](https://cran.r-project.org/package=clue) |
| [clust.mclust](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.mclust) | Gaussian Mixture Models Clustering | [mclust](https://cran.r-project.org/package=mclust) |
| [clust.meanshift](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.meanshift) | Mean Shift Clustering | [LPCM](https://cran.r-project.org/package=LPCM) |
| [clust.optics](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.optics) | OPTICS Clustering | [dbscan](https://cran.r-project.org/package=dbscan) |
| [clust.pam](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.pam) | Partitioning Around Medoids | [cluster](https://cran.r-project.org/package=cluster) |
| [clust.xmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.xmeans) | X-means | [RWeka](https://cran.r-project.org/package=RWeka) |

### Cluster Measures

| Key | Label | Packages |
|:---|:---|:---|
| [clust.ch](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.ch) | Calinski Harabasz | [fpc](https://cran.r-project.org/package=fpc) |
| [clust.dunn](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn) | Dunn | [fpc](https://cran.r-project.org/package=fpc) |
| [clust.silhouette](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.silhouette) | Silhouette | [cluster](https://cran.r-project.org/package=cluster) |
| [clust.wss](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wss) | Within Sum of Squares | [fpc](https://cran.r-project.org/package=fpc) |

## Example

``` r
library(mlr3)
library(mlr3cluster)

task = tsk("usarrests")
task
#> 
#> ── <TaskClust> (50x4): US Arrests ──────────────────────────────────────────────
#> • Target:
#> • Properties: -
#> • Features (4):
#>   • int (2): Assault, UrbanPop
#>   • dbl (2): Murder, Rape

learner = lrn("clust.kmeans")
prediction = learner$train(task)$predict(task)
measures = msrs(c("clust.wss", "clust.silhouette"))
prediction$score(measures, task)
#>        clust.wss clust.silhouette 
#>     9.639903e+04     5.926554e-01
```

## More Resources

Check out the
**[blogpost](https://www.r-bloggers.com/2020/10/introducing-mlr3cluster-cluster-analysis-package/)**
for a more detailed introduction to the package. Also,
**[mlr3book](https://mlr3book.mlr-org.com/chapters/chapter13/beyond_regression_and_classification.html#sec-cluster)**
has a section on clustering.

## Future Plans

- Add more learners and measures
- Integrate the package with
  **[mlr3pipelines](https://github.com/mlr-org/mlr3pipelines)** (work in
  progress)

If you have any questions, feedback or ideas, feel free to open an issue
[here](https://github.com/mlr-org/mlr3cluster/issues).
