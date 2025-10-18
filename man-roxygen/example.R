#' <%= sprintf("@examplesIf mlr3misc::require_namespaces(lrn(\"%s\")$packages, quietly = TRUE)", id) %>
#' # Define the Learner and set parameter values
#' <%= sprintf("learner = lrn(\"%s\")", id) %>
#' print(learner)
#'
#' # Define a Task
#' task = tsk("usarrests")
#'
#' # Train the learner on the task
#' learner$train(task)
#'
#' # Print the model
#' print(learner$model)
#'
#' # Make predictions for the task
#' prediction = learner$predict(task)
#'
#' # Score the predictions
#' prediction$score(task = task)
