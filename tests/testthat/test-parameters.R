test_that("semi-bounded inputs produce semi-bounded parameters", {
  x <- c(3.2, 4, 6)
  lower <- 1
  upper <- Inf
  params <- jqpd(x, lower, upper)
  expect_equal(params$lower, lower)
  expect_equal(params$upper, upper)
  expect_gt(params$k, 0)
})

test_that("bounded inputs produce bounded parameters", {
  x <- c(3.2, 4, 6)
  lower <- 1
  upper <- 10
  params <- jqpd(x, lower, upper)
  expect_equal(params$lower, lower)
  expect_equal(params$upper, upper)
  expect_equal(params$k, 0)
})

test_that("length", {
  x <- numeric()
  expect_error(jqpd(x), "Input 'x' must be a length 3 numeric vector.")
  x <- c(0.32, x)
  expect_error(jqpd(x), "Input 'x' must be a length 3 numeric vector.")
  x <- c(0.4, 0.6, 0.7, x)
  expect_error(jqpd(x), "Input 'x' must be a length 3 numeric vector.")
})

