test_that("row sums are computed correctly", {
  # Test 1: Simple 3x4 matrix with integers
  mat1 <- matrix(1:12, nrow = 3, ncol = 4)
  result1 <- row_sum(mat1)
  expected1 <- rowSums(mat1)
  
  expect_equal(result1, expected1)
  
  # Test 2: Matrix with decimal values
  mat2 <- matrix(c(1.5, 2.5, 3.5, 4.5, 5.5, 6.5), nrow = 2, ncol = 3)
  result2 <- row_sum(mat2)
  expected2 <- rowSums(mat2)
  
  expect_equal(result2, expected2)
  
  # Test 3: Single row matrix
  mat3 <- matrix(1:5, nrow = 1)
  result3 <- row_sum(mat3)
  expected3 <- rowSums(mat3)
  
  expect_equal(result3, expected3)
  
  # Test 4: Single column matrix
  mat4 <- matrix(1:5, ncol = 1)
  result4 <- row_sum(mat4)
  expected4 <- rowSums(mat4)
  
  expect_equal(result4, expected4)
  
  # Test 5: Matrix with negative values
  mat5 <- matrix(c(-1, 2, -3, 4, -5, 6), nrow = 2, ncol = 3)
  result5 <- row_sum(mat5)
  expected5 <- rowSums(mat5)
  
  expect_equal(result5, expected5)
  
  # Test 6: Matrix with zeros
  mat6 <- matrix(c(0, 0, 0, 1, 2, 3), nrow = 2, ncol = 3)
  result6 <- row_sum(mat6)
  expected6 <- rowSums(mat6)
  
  expect_equal(result6, expected6)
  
  # Test 7: Larger matrix
  mat7 <- matrix(1:100, nrow = 10, ncol = 10)
  result7 <- row_sum(mat7)
  expected7 <- rowSums(mat7)
  
  expect_equal(result7, expected7)
  
  # Test 8: Matrix created with as.numeric (explicit doubles)
  mat8 <- matrix(as.numeric(1:12), nrow = 3, ncol = 4)
  result8 <- row_sum(mat8)
  expected8 <- rowSums(mat8)
  
  expect_equal(result8, expected8)
})

test_that("error handling works", {
  # Test with non-matrix input (vector)
  expect_error(row_sum(1:10), "Input must be a numeric matrix")
  
  # Test with non-numeric matrix (character)
  expect_error(row_sum(matrix(letters[1:6], nrow = 2)), 
               "Input must be a numeric matrix")
  
  # Test with NULL
  expect_error(row_sum(NULL), "Input must be a numeric matrix")
  
  # Test with data frame (not a matrix)
  expect_error(row_sum(data.frame(a = 1:3, b = 4:6)), 
               "Input must be a numeric matrix")
  
  # Test with logical matrix
  expect_error(row_sum(matrix(c(TRUE, FALSE, TRUE, FALSE), nrow = 2)), 
               "Input must be a numeric matrix")
})

test_that("edge cases work correctly", {
  # Test with 1x1 matrix
  mat_small <- matrix(5, nrow = 1, ncol = 1)
  result_small <- row_sum(mat_small)
  expect_equal(result_small, 5)
  
  # Test with very small values
  mat_tiny <- matrix(c(0.0001, 0.0002, 0.0003, 0.0004), nrow = 2, ncol = 2)
  result_tiny <- row_sum(mat_tiny)
  expected_tiny <- rowSums(mat_tiny)
  expect_equal(result_tiny, expected_tiny)
  
  # Test with mixed positive and negative
  mat_mixed <- matrix(c(100, -100, 50, -50), nrow = 2, ncol = 2)
  result_mixed <- row_sum(mat_mixed)
  expected_mixed <- rowSums(mat_mixed)
  expect_equal(result_mixed, expected_mixed)
})