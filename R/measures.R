make_measure_info = function(
  fun,
  label,
  lower,
  upper,
  minimize,
  predict_type = "partition",
  input = "dist",
  requires_k2 = TRUE
) {
  list(
    fun = fun,
    label = label,
    lower = lower,
    upper = upper,
    minimize = minimize,
    predict_type = predict_type,
    input = input,
    requires_k2 = requires_k2
  )
}
measures = new.env(parent = emptyenv())
