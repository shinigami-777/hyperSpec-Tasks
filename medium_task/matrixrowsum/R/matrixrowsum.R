row_sum <- function(matrix) {
  if (!is.matrix(matrix) || !is.numeric(matrix)) {
    stop("Input must be a numeric matrix")
  }
  row_sums_rust(matrix)
}