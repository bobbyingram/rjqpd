context("random number generation")

test_models <- list(
  jqpd(c(0.32, 0.4, 0.6), lower = 0, upper = 1, alpha = .1),
  jqpd(c(0.32, 0.4, 0.6), lower = 0, upper = 1, alpha = .3),
  jqpd(c(2, 4, 6), lower = 0, upper = Inf, alpha = .1),
  jqpd(c(2, 4, 6), lower = 0, upper = Inf, alpha = .3)
)

n <- 1000

test_that("all samples gte to lower bound", {
  for (params in test_models) {
    samples <- rjqpd(n, params)
    all_above <- all(samples >= params$lower)
    expect_true(all_above)
  }
})

test_that("all samples lte to upper bound", {
  for (params in test_models) {
    samples <- rjqpd(n, params)
    all_below <- all(samples <= params$upper)
    expect_true(all_below)
  }
})

test_that("return vector is correct length", {
  for (params in test_models) {
    samples <- rjqpd(n, params)
    expect_equal(length(samples), n)
  }
})
