context("cumulative distribution function")

test_models <- list(
  jqpd(c(0.32, 0.4, 0.6), lower = 0, upper = 1, alpha = .1),
  jqpd(c(0.32, 0.4, 0.6), lower = 0, upper = 1, alpha = .3),
  jqpd(c(2, 4, 6), lower = 0, upper = Inf, alpha = .1),
  jqpd(c(2, 4, 6), lower = 0, upper = Inf, alpha = .3)
)

test_that("lower bound returns probability zero", {
  for (params in test_models) {
    expect_equal(pjqpd(params$lower, params), 0)
  }
})

test_that("upper bound returns probability one", {
  for (params in test_models) {
    expect_equal(pjqpd(params$upper, params), 1)
  }
})

test_that("recovers inputs", {
  for (params in test_models) {
    p <- pjqpd(params$x, params)
    expect_equal(p[1], params$alpha)
    expect_equal(p[2], 0.5)
    expect_equal(p[3], 1-params$alpha)
  }
})
