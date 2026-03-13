make_measure_info = function(fun, lower, upper, minimize, predict_type = "partition", input = "dist") {
  list(fun = fun, lower = lower, upper = upper, minimize = minimize, predict_type = predict_type, input = input)
}
measures = new.env(parent = emptyenv())
