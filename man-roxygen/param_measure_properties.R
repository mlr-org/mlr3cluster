#' @param properties (`character()`)\cr
#'   Properties of the measure.
#'   Must be a subset of [mlr_reflections$measure_properties][mlr3::mlr_reflections].
#'   Supported by `mlr3`:
#'   * `"requires_task"` (requires the complete [mlr3::Task]),
#'   * `"requires_learner"` (requires the trained [mlr3::Learner]),
#'   * `"requires_model"` (requires the trained [mlr3::Learner], including the fitted model),
#'   * `"requires_train_set"` (requires the training indices from the [mlr3::Resampling]),
#'   * `"na_score"` (the measure is expected to occasionally return `NA` or `NaN`),
#'   * `"weights"` (support weighted scoring using sample weights from task, column role `weights_measure`),
#'   * `"primary_iters"` (the measure explicitly handles resamplings
#'   that only use a subset of their iterations for the point estimate), and
#'   * `"requires_no_prediction"` (No prediction is required;
#'   This usually means that the measure extracts some information from the learner state.).
