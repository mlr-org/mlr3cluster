# Ruspini Cluster Task

A cluster task for the
[cluster::ruspini](https://rdrr.io/pkg/cluster/man/ruspini.html) data
set.

## Format

[R6::R6Class](https://r6.r-lib.org/reference/R6Class.html) inheriting
from
[TaskClust](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md).

## Dictionary

This [mlr3::Task](https://mlr3.mlr-org.com/reference/Task.html) can be
instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_tasks](https://mlr3.mlr-org.com/reference/mlr_tasks.html) or
with the associated sugar function
[`mlr3::tsk()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_tasks$get("ruspini")
    tsk("ruspini")

## Meta Information

- Task type: “clust”

- Dimensions: 75x2

- Properties: -

- Has Missings: `FALSE`

- Target: -

- Features: “x”, “y”

## References

Ruspini EH (1970). “Numerical methods for fuzzy clustering.”
*Information Sciences*, **2**(3), 319-350.
[doi:10.1016/S0020-0255(70)80056-1](https://doi.org/10.1016/S0020-0255%2870%2980056-1)
.

## See also

- Chapter in the [mlr3book](https://mlr3book.mlr-org.com/):
  <https://mlr3book.mlr-org.com/chapters/chapter2/data_and_basic_modeling.html>

- Package [mlr3data](https://CRAN.R-project.org/package=mlr3data) for
  more toy tasks.

- Package [mlr3oml](https://CRAN.R-project.org/package=mlr3oml) for
  downloading tasks from <https://www.openml.org>.

- Package [mlr3viz](https://CRAN.R-project.org/package=mlr3viz) for some
  generic visualizations.

- [Dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
  of [Tasks](https://mlr3.mlr-org.com/reference/Task.html):
  [mlr3::mlr_tasks](https://mlr3.mlr-org.com/reference/mlr_tasks.html)

- `as.data.table(mlr_tasks)` for a table of available
  [Tasks](https://mlr3.mlr-org.com/reference/Task.html) in the running
  session (depending on the loaded packages).

- [mlr3fselect](https://CRAN.R-project.org/package=mlr3fselect) and
  [mlr3filters](https://CRAN.R-project.org/package=mlr3filters) for
  feature selection and feature filtering.

- Extension packages for additional task types:

  - Unsupervised clustering:
    [mlr3cluster](https://CRAN.R-project.org/package=mlr3cluster)

  - Probabilistic supervised regression and survival analysis:
    <https://mlr3proba.mlr-org.com/>.

Other Task:
[`TaskClust`](https://mlr3cluster.mlr-org.com/dev/reference/TaskClust.md),
[`mlr_tasks_usarrests`](https://mlr3cluster.mlr-org.com/dev/reference/mlr_tasks_usarrests.md)
