weka_control = function(pv) {
  names(pv) = chartr("_", "-", names(pv))
  invoke(RWeka::Weka_control, .args = pv)
}

#' @export
marshal_model.Weka_clusterer = function(model, inplace = FALSE, ...) {
  rJava::.jcache(model$clusterer)
  set_class(
    list(marshaled = model, packages = c("mlr3", "mlr3cluster", "RWeka")),
    c("Weka_clusterer_marshaled", "marshaled")
  )
}

#' @export
unmarshal_model.Weka_clusterer_marshaled = function(model, inplace = FALSE, ...) {
  model$marshaled
}
