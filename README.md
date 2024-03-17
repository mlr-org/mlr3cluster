# mlr3cluster

Cluster analysis for mlr3

<!-- badges: start -->
[![r-cmd-check](https://github.com/mlr-org/mlr3cluster/actions/workflows/r-cmd-check.yml/badge.svg)](https://github.com/mlr-org/mlr3cluster/actions/workflows/r-cmd-check.yml)
[![CRAN status](https://www.r-pkg.org/badges/version/mlr3cluster)](https://CRAN.R-project.org/package=mlr3cluster)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-mlr3-orange.svg)](https://stackoverflow.com/questions/tagged/mlr3)
[![Mattermost](https://img.shields.io/badge/chat-mattermost-orange.svg)](https://lmmisld-lmu-stats-slds.srv.mwn.de/mlr_invite/)
<!-- badges: end -->

**mlr3cluster** is an extension package for cluster analysis within the **[mlr3](https://github.com/mlr-org/mlr3)** ecosystem. It is a successor of clustering capabilities of **[mlr2](https://github.com/mlr-org/mlr)**.

## Installation

Install the last release from CRAN:

``` r
install.packages("mlr3cluster")
```

Install the development version from GitHub:

``` r
devtools::install_github("mlr-org/mlr3cluster")
```

## Feature Overview

The current version of **mlr3cluster** contains:

  - A selection of 19 clustering learners that represent a wide variety of clusterers:
    partitional, hierarchical, fuzzy, etc.
  - A selection of 4 performance measures
  - Two built-in tasks to get started with clustering

Also, the package is integrated with **[mlr3viz](https://github.com/mlr-org/mlr3viz)** which enables you to create great visualizations with just one line of code!

## Cluster Analysis

### Cluster Learners

| ID | Learner | Package |
| :--| :------ | :------ |
| [clust.agnes](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.agnes.html) | Agglomerative Hierarchical Clustering |  [cluster](https://CRAN.R-project.org/package=cluster) |
| [clust.ap](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.ap.html) | Affinity Propagation Clustering |  [apcluster](https://CRAN.R-project.org/package=apcluster) |
| [clust.cmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cmeans.html) | Fuzzy C-Means Clustering |  [e1071](https://CRAN.R-project.org/package=e1071) |
| [clust.cobweb](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cobweb.html) | Cobweb Clustering Algorithm |  [RWeka](https://CRAN.R-project.org/package=RWeka) |
| [clust.dbscan](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan.html) | Density-based Clustering | [dbscan](https://CRAN.R-project.org/package=dbscan) |
| [clust.dbscan_fpc](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan_fpc.html) | Density-based Clustering with fpc | [fpc](https://CRAN.R-project.org/package=fpc) |
| [clust.diana](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.diana.html) | Divisive Hierarchical Clustering | [cluster](https://CRAN.R-project.org/package=cluster) |
| [clust.em](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.em.html) | Expectation-Maximization Clustering |  [RWeka](https://CRAN.R-project.org/package=RWeka) |
| [clust.fanny](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.fanny.html) | Fuzzy Clustering | [cluster](https://CRAN.R-project.org/package=cluster) |
| [clust.featureless](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.featureless.html) | Simple Featureless Clustering | [mlr3cluster](https://github.com/mlr-org/mlr3cluster) |
| [clust.ff](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.FF.html) | FarthestFirst Clustering Algorithm |  [RWeka](https://CRAN.R-project.org/package=RWeka) |
| [clust.hdbscan](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.hdbscan.html) | HDBSCAN Clustering | [dbscan](https://CRAN.R-project.org/package=dbscan) |
| [clust.hclust](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.hclust.html) | Agglomerative Hierarchical Clustering | [stats](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/stats-package.html) |
| [clust.kkmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kkmeans.html) | Kernel K-Means Clustering |  [kernlab](https://CRAN.R-project.org/package=kernlab) |
| [clust.kmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kmeans.html) | K-Means Clustering | [stats](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/stats-package.html) |
| [clust.mclust](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.mclust.html) | Gaussian Mixture Models-Based Clustering | [mclust](https://cran.r-project.org/package=mclust) |
| [clust.MBatchKMeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.MiniBatchKMeans.html) | Mini Batch K-Means Clustering | [ClusterR](https://CRAN.R-project.org/package=ClusterR) |
| [clust.meanshift](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.meanshift.html) | Mean Shift Clustering | [LPCM](https://CRAN.R-project.org/package=LPCM) |
| [clust.optics](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.optics.html) | OPTICS Clustering | [dbscan](https://CRAN.R-project.org/package=dbscan) |
| [clust.pam](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.pam.html) | Clustering Around Medoids | [cluster](https://CRAN.R-project.org/package=cluster) |
| [clust.SimpleKMeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.SimpleKMeans.html) | K-Means Clustering (WEKA) |  [RWeka](https://CRAN.R-project.org/package=RWeka) |
| [clust.xmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.xmeans.html) | K-Means with Automatic Determination of k | [RWeka](https://CRAN.R-project.org/package=RWeka) |

### Cluster Measures

| ID | Measure | Package |
| :--| :------ | :------ |
| [clust.dunn](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn.html) | Dunn index | [fpc](https://cran.r-project.org/package=fpc) |
| [clust.ch](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.ch.html) | Calinski Harabasz Pseudo F-Statistic | [fpc](https://cran.r-project.org/package=fpc) |
| [clust.silhouette](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.silhouette.html) | Rousseeuw's Silhouette Quality Index | [cluster](https://cran.r-project.org/package=cluster) |
| [clust.wss](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.wss.html) | Within Sum of Squares | [fpc](https://cran.r-project.org/package=fpc) |


## Example

```r
library(mlr3)
library(mlr3cluster)

task = tsk("usarrests")
learner = lrn("clust.kmeans")
learner$train(task)
preds = learner$predict(task = task)
```

## More Resources

Check out the **[blogpost](https://mlr-org.com/posts/2020-08-26-introducing-mlr3cluster-cluster-analysis-package/)** for a more detailed introduction to the package.
Also, **[mlr3book](https://mlr3book.mlr-org.com/special.html#cluster)** has a section on clustering.

## Future Plans

  - Add more learners and measures
  - Integrate the package with **[mlr3pipelines](https://github.com/mlr-org/mlr3pipelines)**
    (work in progress)

If you have any questions, feedback or ideas, feel free to open an issue [here](https://github.com/mlr-org/mlr3cluster/issues).
