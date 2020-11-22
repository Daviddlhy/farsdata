test_that("Check number of rows for 2015 accidents file", {
  testthat::expect_equal(nrow(fars_read_years(2015)[[1]]), 32166)
})

test_that("Check number of rows for 2014 accidents file", {
  testthat::expect_equal(nrow(fars_read_years(2014)[[1]]), 30056)
})


test_that("Check number of rows for 2015 accidents file", {
  testthat::expect_equal(nrow(fars_read_years(2013)[[1]]), 30202)
})
