# invalid modes error informatively

    Code
      lrn("clust.kmodes", modes = data.frame(x = factor("a")))$train(task)
    Condition
      Error:
      ! 
      x `modes` must have one column per task feature.
      > Class: Mlr3ErrorInput

---

    Code
      lrn("clust.kmodes", modes = data.frame(a = factor("a"), b = factor("a")))$train(
        task)
    Condition
      Error:
      ! 
      x `modes` column names must match the task features.
      > Class: Mlr3ErrorInput

