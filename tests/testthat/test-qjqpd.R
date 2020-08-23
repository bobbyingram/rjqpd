context("quantile function")

test_models <- list(
  jqpd(c(0.32, 0.4, 0.6), lower = 0, upper = 1, alpha = .1),
  jqpd(c(0.32, 0.4, 0.6), lower = 0, upper = 1, alpha = .3),
  jqpd(c(2, 4, 6), lower = 0, upper = Inf, alpha = .1),
  jqpd(c(2, 4, 6), lower = 0, upper = Inf, alpha = .3)
)

test_that("probability zero returns lower bound", {
  for (params in test_models) {
    expect_equal(qjqpd(0, params), params$lower)
  }
})

test_that("probability 1 returns upper bound", {
  for (params in test_models) {
    expect_equal(qjqpd(1, params), params$upper)
  }
})

test_that("recovers inputs", {
  for (params in test_models) {
    probs <- c(params$alpha, 0.5, 1-params$alpha)
    iles <- qjqpd(probs, params)
    expect_equal(iles[1], params$x[1])
    expect_equal(iles[2], params$x[2])
    expect_equal(iles[3], params$x[3])
  }
})
