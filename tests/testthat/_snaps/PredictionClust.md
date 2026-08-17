# partition labels must appear among the prob column labels

    Code
      PredictionClust$new(row_ids = 1:2, partition = c(1L, 2L), prob = prob)
    Condition
      Error in `check_prediction_data.PredictionDataClust()`:
      ! Assertion on 'partition' failed: Must be a subset of {'3','7'}, but has additional elements {'1','2'}.

# partition check falls back to positions for non-integer prob labels

    Code
      PredictionClust$new(row_ids = 1:2, partition = c(2L, 3L), prob = prob)
    Condition
      Error in `check_prediction_data.PredictionDataClust()`:
      ! Assertion on 'partition' failed: Must be a subset of {'1','2'}, but has additional elements {'3'}.

# as_prediction_clust() rejects a non-integral partition

    Code
      as_prediction_clust(data.frame(row_ids = 1:3, partition = c(1.5, 2, 3)))
    Condition
      Error in `check_prediction_data.PredictionDataClust()`:
      ! Assertion on 'pdata$partition' failed: Must be of type 'integerish', but element 1 is not close to an integer.

# combining empty prob predictions with conflicting clusters errors

    Code
      c(p3, p4)
    Condition
      Error:
      ! number of columns of matrices must match (see arg 2)

# combining weighted and unweighted predictions errors

    Code
      c(a, b)
    Condition
      Error:
      ! 
      x Cannot combine predictions: Some predictions have weights, others do not.
      > Class: Mlr3ErrorInput

