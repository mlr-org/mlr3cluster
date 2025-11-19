# US Arrests Cluster Task

A cluster task for the
[datasets::USArrests](https://rdrr.io/r/datasets/USArrests.html) data
set. Rownames are stored as variable `"states"` with column role
`"name"`.

## Format

[R6::R6Class](https://r6.r-lib.org/reference/R6Class.html) inheriting
from
[TaskClust](https://mlr3cluster.mlr-org.com/reference/TaskClust.md).

## Dictionary

This [mlr3::Task](https://mlr3.mlr-org.com/reference/Task.html) can be
instantiated via the
[dictionary](https://mlr3misc.mlr-org.com/reference/Dictionary.html)
[mlr3::mlr_tasks](https://mlr3.mlr-org.com/reference/mlr_tasks.html) or
with the associated sugar function
[`mlr3::tsk()`](https://mlr3.mlr-org.com/reference/mlr_sugar.html):

    mlr_tasks$get("usarrests")
    tsk("usarrests")

## Meta Information

- Task type: “clust”

- Dimensions: 50x4

- Properties: -

- Has Missings: `FALSE`

- Target: -

- Features: “Assault”, “Murder”, “Rape”, “UrbanPop”

## References

Berry, Brian J (1979). “Interactive Data Analysis: A Practical Primer.”
*Journal of the Royal Statistical Society: Series C (Applied
Statistics)*, **28**, 181.

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
[`TaskClust`](https://mlr3cluster.mlr-org.com/reference/TaskClust.md),
[`mlr_tasks_ruspini`](https://mlr3cluster.mlr-org.com/reference/mlr_tasks_ruspini.md)
