# Data measures error on factor features

    Code
      msr("clust.ch")$score(prediction = p, task = task)
    Condition
      Error:
      ! 
      x Measure 'clust.ch' requires numeric features, but task 'mixed' has factor or
        ordered features.
      > Class: Mlr3ErrorInput

---

    Code
      msr("clust.wss")$score(prediction = p, task = task)
    Condition
      Error:
      ! 
      x Measure 'clust.wss' requires numeric features, but task 'mixed' has factor or
        ordered features.
      > Class: Mlr3ErrorInput

---

    Code
      msr("clust.davies_bouldin")$score(prediction = p, task = task)
    Condition
      Error:
      ! 
      x Measure 'clust.davies_bouldin' requires numeric features, but task 'mixed'
        has factor or ordered features.
      > Class: Mlr3ErrorInput

