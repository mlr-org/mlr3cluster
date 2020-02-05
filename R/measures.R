# we store the information about the measures in an environment.
# this way, we can (a) construct them easily and (b) generate documentation.
make_measure_info = function(crit, lower, upper, minimize, predict_type = "partition") {
  list(crit = crit, lower = lower, upper = upper, minimize = minimize, predict_type = predict_type)
}
measures = new.env(parent = emptyenv())
