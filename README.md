# mlr3cluster

Cluster analysis for mlr3

<!-- badges: start -->
[![tic](https://github.com/mlr-org/mlr3cluster/workflows/tic/badge.svg?branch=master)](https://github.com/mlr-org/mlr3cluster/actions)
[![CRAN status](https://www.r-pkg.org/badges/version/mlr3cluster)](https://CRAN.R-project.org/package=mlr3cluster)
[![codecov](https://codecov.io/gh/mlr-org/mlr3cluster/branch/master/graph/badge.svg)](https://codecov.io/gh/mlr-org/mlr3cluster)
[![StackOverflow](https://img.shields.io/badge/stackoverflow-mlr3-orange.svg)](https://stackoverflow.com/questions/tagged/mlr3)
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

  - A selection of 9 clustering learners that represent a wide variety of clusterers: 
    partitional, hierarchical, fuzzy, etc. 
  - A selection of 4 performance measures
  - One built-in task to get started with clustering

Also, the package is integrated with **[mlr3viz](https://github.com/mlr-org/mlr3viz)** which enables you to create great visualizations with just one line of code!

## Cluster Analysis

### Cluster Learners

| ID | Learner | Package |
| :--| :------ | :------ |
| [clust.agnes](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.agnes.html) | Agglomerative Hierarchical Clustering |  [cluster](https://CRAN.R-project.org/package=cluster) |
| [clust.cmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.cmeans.html) | Fuzzy C-Means Clustering |  [e1071](https://CRAN.R-project.org/package=e1071) |
| [clust.dbscan](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.dbscan.html) | Density-based Clustering | [dbscan](https://CRAN.R-project.org/package=dbscan) |
| [clust.diana](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.diana.html) | Divisive Hierarchical Clustering | [cluster](https://CRAN.R-project.org/package=cluster) |
| [clust.fanny](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.fanny.html) | Fuzzy Clustering | [cluster](https://CRAN.R-project.org/package=cluster) |
| [clust.featureless](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.featureless.html) | Simple Featureless Clustering | [mlr3cluster](https://github.com/mlr-org/mlr3cluster) |
| [clust.kmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.kmeans.html) | K-Means Clustering | [stats](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/stats-package.html) | 
| [clust.pam](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.pam.html) | Clustering Around Medoids | [cluster](https://CRAN.R-project.org/package=cluster) |
| [clust.xmeans](https://mlr3cluster.mlr-org.com/reference/mlr_learners_clust.xmeans.html) | K-Means with Automatic Determination of k | [RWeka](https://CRAN.R-project.org/package=RWeka) |

### Cluster Measures

| ID | Measure | Package |
| :--| :------ | :------ |
| [clust.db](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.db.html) | Davies-Bouldin Cluster Separation | [clusterCrit](https://CRAN.R-project.org/package=clusterCrit) |
| [clust.dunn](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.dunn.html) | Dunn index | [clusterCrit](https://CRAN.R-project.org/package=clusterCrit) |
| [clust.ch](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.ch.html) | Calinski Harabasz Pseudo F-Statistic | [clusterCrit](https://CRAN.R-project.org/package=clusterCrit) |
| [clust.silhouette](https://mlr3cluster.mlr-org.com/reference/mlr_measures_clust.silhouette.html) | Rousseeuw's Silhouette Quality Index | [clusterCrit](https://CRAN.R-project.org/package=clusterCrit) |


## Example

```{r}
library(mlr3)
library(mlr3cluster)

task = mlr_tasks$get("usarrests")
learner = mlr_learners$get("clust.kmeans")
learner$train(task)
preds = learner$predict(task = task)
```

## More Resources

Check out the **[blogpost](https://deploy-preview-24--mlr-web.netlify.app/docs/introducing-mlr3cluster-cluster-analysis-package/)** for a more detailed introduction to the package. 
Also, **[mlr3book](https://mlr3book.mlr-org.com/)** section on clustering is coming soon! 

## Future Plans

  - Add more learners and measures
  - Integrate the package with **[mlr3pipelines](https://github.com/mlr-org/mlr3pipelines)**
    (work in progress)
    
If you have any questions, feedback or ideas, feel free to open an issue [here](https://github.com/mlr-org/mlr3cluster/issues). 
