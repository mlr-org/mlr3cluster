#' @export
default_fallback.LearnerClust = function(learner, ...) {
  fallback = lrn("clust.featureless")
  if (learner$predict_type %nin% fallback$predict_types) {
    error_config("Fallback learner '%s' does not support predict type '%s'.", fallback$id, learner$predict_type)
  }
  fallback$predict_type = learner$predict_type
  fallback
}
