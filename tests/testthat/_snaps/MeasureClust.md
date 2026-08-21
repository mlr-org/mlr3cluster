# Data measures error on non-numeric features

    Code
      msr("clust.ch")$score(prediction = p, task = task)
    Condition
      Error:
      ! 
      x Measure 'clust.ch' requires numeric features, but task 'mixed' has character,
        factor, or ordered features.
      > Class: Mlr3ErrorInput

---

    Code
      msr("clust.wss")$score(prediction = p, task = task)
    Condition
      Error:
      ! 
      x Measure 'clust.wss' requires numeric features, but task 'mixed' has
        character, factor, or ordered features.
      > Class: Mlr3ErrorInput

---

    Code
      msr("clust.sse_ratio")$score(prediction = p, task = task)
    Condition
      Error:
      ! 
      x Measure 'clust.sse_ratio' requires numeric features, but task 'mixed' has
        character, factor, or ordered features.
      > Class: Mlr3ErrorInput

---

    Code
      msr("clust.davies_bouldin")$score(prediction = p, task = task)
    Condition
      Error:
      ! 
      x Measure 'clust.davies_bouldin' requires numeric features, but task 'mixed'
        has character, factor, or ordered features.
      > Class: Mlr3ErrorInput

