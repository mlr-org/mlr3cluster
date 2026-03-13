#' @param average (`character(1)`)\cr
#'   How to average multiple [mlr3::Prediction]s from a [ResampleResult].
#'
#'   The default, `"macro"`, calculates the individual performances scores for each [mlr3::Prediction] and then uses the
#'   function defined in `$aggregator` to average them to a single number.
#'
#'   `"macro_weighted"` is similar to `"macro"`, but uses weighted averages.
#'   Weights are taken from the `weights_measure` column of the resampled [mlr3::Task] if present.
#'   Note that `"macro_weighted"` can differ from `"macro"` even if no weights are present or if `$use_weights` is set to `"ignore"`,
#'   since then aggregation is done using *uniform sample weights*, which result in non-uniform weights for [mlr3::Prediction]s if they contain different
#'   numbers of samples.
#'
#'   If set to `"micro"`, the individual [mlr3::Prediction] objects are first combined into a single new [mlr3::Prediction] object which is then used to assess the performance.
#'   The function in `$aggregator` is not used in this case.
