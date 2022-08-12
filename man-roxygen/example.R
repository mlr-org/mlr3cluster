<%
lrn = mlr3::lrn(id)
pkgs = setdiff(lrn$packages, c("mlr3", "mlr3cluster"))
if (length(pkgs) == 0L) { pkgs = "mlr3" }
pkgs = paste0(sprintf('requireNamespace("%s")', pkgs), collapse = " && ")
%>
#' @examples
#' if (<%= pkgs %>) {
#'   learner = mlr3::lrn("<%= id %>")
#'   print(learner)
#'
#'   # available parameters:
#'   learner$param_set$ids()
#' }
