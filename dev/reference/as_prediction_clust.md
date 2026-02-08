# Convert to a Cluster Prediction

Convert object to a
[PredictionClust](https://mlr3cluster.mlr-org.com/dev/reference/PredictionClust.md).

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

[PredictionClust](https://mlr3cluster.mlr-org.com/dev/reference/PredictionClust.md).

## Examples

``` r
# create a prediction object
task = tsk("usarrests")
learner = lrn("clust.cmeans", predict_type = "prob")
learner$train(task)
p = learner$predict(task)

# convert to a data.table
tab = as.data.table(p)

# convert back to a Prediction
as_prediction_clust(tab)
#> 
#> ── <PredictionClust> for 50 observations: ──────────────────────────────────────
#>  row_ids partition     prob.1     prob.2
#>        1         2 0.03327956 0.96672044
#>        2         2 0.02757239 0.97242761
#>        3         2 0.04096633 0.95903367
#>      ---       ---        ---        ---
#>       48         1 0.96380863 0.03619137
#>       49         1 0.93744281 0.06255719
#>       50         1 0.75263604 0.24736396

# split data.table into a 3 data.tables based on UrbanPop
f = cut(task$data(rows = tab$row_ids)$UrbanPop, 3)
tabs = split(tab, f)

# convert back to list of predictions
preds = lapply(tabs, as_prediction_clust)

# calculate performance in each group
sapply(preds, function(p) p$score(task = task))
#> (31.9,51.7].clust.dunn (51.7,71.3].clust.dunn (71.3,91.1].clust.dunn 
#>              0.7096902              0.1226172              0.2538652 
```
