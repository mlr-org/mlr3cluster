# predicting errors informatively for unsupported training options

    Code
      learner$predict(task)
    Condition
      Error:
      ! 
      x Predicting is not supported for `stand = TRUE` since `clue::cl_predict()`
        ignores the standardization.
      > Class: Mlr3ErrorConfig

