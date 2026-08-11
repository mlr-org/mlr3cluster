# minPts below 2 is rejected

    Code
      lrn("clust.hdbscan", minPts = 1L)
    Condition
      Error in `self$assert()`:
      ! Assertion on 'xs' failed: minPts: Element 1 is not >= 1.5.

