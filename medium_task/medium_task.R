# This part is for initializing the package
library(rextendr)
library(usethis)
library(devtools)

usethis::create_package("matrixrowsum")
setwd("matrixrowsum")
rextendr::use_extendr()

# then we write the code inside the package
# Compile and package is ready
rextendr::document()
# adding tests inside the package
usethis::use_testthat()

# To create the shareable tarball
devtools::build()

devtools::load_all()

mat <- matrix(1:12, nrow = 3, ncol = 4)
print(mat)
row_sums_rust(mat)

# Run the tests
devtools::test()

# with the tarball
install.packages("name", repos = NULL, type = "source")
# check the package can be used
library(matrixrowsum)
