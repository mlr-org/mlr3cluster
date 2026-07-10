# predicting errors informatively for unsupported training options

    Code
      learner$predict(task)
    Condition
      Error:
      ! 
      x Predicting is not supported for `metric = "jaccard"` since
        `clue::cl_predict()` cannot handle it.
      > Class: Mlr3ErrorConfig

---

    Code
      learner$predict(task)
    Condition
      Error:
      ! 
      x Predicting requires the medoids, train with `medoids.x = TRUE`.
      > Class: Mlr3ErrorConfig

