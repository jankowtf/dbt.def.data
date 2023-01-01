#' Path to package file
#'
#' Path to package file.
#'
#' @param path [character] Path to directory or file
#'
#' @return [character] Full path to directory of file
#' @examples
#' pkg_file("DESCRIPTION")
pkg_file <- function(path) {
    pkgload:::shim_system.file(path, package = pkgload::pkg_name())
}

#' Title
#'
#' @param path
#'
#' @return
#' @export
#'
#' @examples
# io_read_xlsx <- function(path = "datalake/layer_00/lab_001/telco_train.xlsx",
#                          ...) {
#     readxl::read_excel(path, sheet = 1, ...)
# }

#' Get training data
#'
#' FUNCTION_DESCRIPTION
#'
#' @param path DESCRIPTION.
#'
#' @return RETURN_DESCRIPTION
#' @examples
#' # ADD_EXAMPLES_HERE
#' @export
# data_train <- function(path = pkg_file("app/data_train.rds")) {
#     path %>% readRDS()
# }
