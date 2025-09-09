#' <%= sprintf("@examplesIf mlr3misc::require_namespaces(lrn(\"%s\")$packages, quietly = TRUE)", id) %>
#' # Define the Learner and set parameter values
#' <%= sprintf("learner = lrn(\"%s\")", id) %>
#' print(learner)
#'
#' # available parameters:
#' learner$param_set$ids()
