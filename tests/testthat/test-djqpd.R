context("density function")

test_models <- list(
  jqpd(c(0.32, 0.4, 0.6), lower = 0, upper = 1, alpha = .1),
  jqpd(c(0.32, 0.4, 0.6), lower = 0, upper = 1, alpha = .3),
  jqpd(c(2, 4, 6), lower = 0, upper = Inf, alpha = .1),
  jqpd(c(2, 4, 6), lower = 0, upper = Inf, alpha = .3)
)

test_that("outside bounds density is NaN", {
   for (params in test_models) {
     expect_equal(djqpd(params$lower - 1, params), NaN)
     if(!is.infinite(params$upper)){
       expect_equal(djqpd(params$upper + 1, params), NaN)
     }
   }
})

test_that("at bounds density is 0", {
  for (params in test_models) {
    expect_equal(djqpd(params$lower, params), 0)
    expect_equal(djqpd(params$upper, params), 0)
  }
})

test_that("within bounds density is non-zero", {
  for (params in test_models) {
    density <- djqpd(params$x, params)
    expect_true(all(density > 0))
  }
})

