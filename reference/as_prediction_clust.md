# Convert to a Cluster Prediction

Convert object to a
[PredictionClust](https://mlr3cluster.mlr-org.com/reference/PredictionClust.md).

## Usage

``` r
as_prediction_clust(x, ...)

# S3 method for class 'PredictionClust'
as_prediction_clust(x, ...)

# S3 method for class 'data.frame'
as_prediction_clust(x, ...)
```

## Arguments

- x:

  (any)  
  Object to convert.

- ...:

  (any)  
  Additional arguments.

## Value

[PredictionClust](https://mlr3cluster.mlr-org.com/reference/PredictionClust.md).

## Examples

``` r
if (requireNamespace("e1071")) {
  # create a prediction object
  task = tsk("usarrests")
  learner = lrn("clust.kmeans")
  learner = lrn("clust.cmeans", predict_type = "prob")
  learner$train(task)
  p = learner$predict(task)

  # convert to a data.table
  tab = as.data.table(p)

  # convert back to a Prediction
  as_prediction_clust(tab)

  # split data.table into a 3 data.tables based on UrbanPop
  f = cut(task$data(rows = tab$row_ids)$UrbanPop, 3)
  tabs = split(tab, f)

  # convert back to list of predictions
  preds = lapply(tabs, as_prediction_clust)

  # calculate performance in each group
  sapply(preds, function(p) p$score(task = task))
}
#> Loading required namespace: e1071
#> (31.9,51.7].clust.dunn (51.7,71.3].clust.dunn (71.3,91.1].clust.dunn 
#>              0.7096902              0.1226172              0.2538652 
```
