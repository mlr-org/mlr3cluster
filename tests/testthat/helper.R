library(mlr3)
library(mlr3cluster)
library(checkmate)
library(testthat)

lapply(list.files(system.file("testthat", package = "mlr3cluster"), pattern = "^helper.*\\.[rR]", full.names = TRUE), source)
