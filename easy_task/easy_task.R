library(hyperSpec)
library(spatstat.sparse)
data(flu)
print(flu)

create_adjacency <- function(nrow, ncol) {
  N <- nrow * ncol
  A <- matrix(0, N, N)
  index <- function(r, c) {
    (r - 1) * ncol + c
  }
  for (r in 1:nrow) {
    for (c in 1:ncol) {
      current <- index(r, c)
      
      if (r > 1)
        A[current, index(r - 1, c)] <- 1
      
      if (r < nrow)
        A[current, index(r + 1, c)] <- 1
      
      if (c > 1)
        A[current, index(r, c - 1)] <- 1
      
      if (c < ncol)
        A[current, index(r, c + 1)] <- 1
    }
  }
  return(A)
}

compute_laplacian <- function(A) {
  degree <- rowSums(A)
  D <- diag(degree)
  L <- D - A
  return(L)
}

A <- create_adjacency(3, 3)
# doing the same using the func from spatstat.sparse
B <- gridadjacencymatrix(dims = c(3, 3),
                                  down = TRUE,
                                  across = TRUE,
                                  diagonal = FALSE)

print(A)
print(B)

L <- compute_laplacian(A)
print(L)
image(L[nrow(L):1, ],
      main="Graph Laplacian (3x3 Grid)",
      xlab="Pixel Index",
      ylab="Pixel Index")

L <- compute_laplacian(B)
print(L)
image(L, main="Graph Laplacian (3x3 Grid)",
      xlab="Pixel Index",
      ylab="Pixel Index")

