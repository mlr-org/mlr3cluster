# predicting errors informatively when trained with seeds = FALSE

    Code
      learner$predict(task)
    Condition
      Error:
      ! 
      x Predicting requires seed points, train with `seeds = TRUE`.
      > Class: Mlr3ErrorConfig

---

    Code
      learner$predict(task)
    Condition
      Error:
      ! 
      x Predicting is not supported for `scale = TRUE` since `fpc:::predict.dbscan()`
        ignores the scaling.
      > Class: Mlr3ErrorConfig

