#' Plots the density, cumulative distribution function, quantile function and a
#' set of 1000 random samples for a Johnson Quantile-Parameterised Distribution.
#'
#' @param params jqpd object created using \code{jqpd()}
#' @return no return value, called for side effects only
#' @export
plot_jqpd <- function(params){
  if(!is_jqpd_obj(params)){
    stop("Input 'params' must have class 'jqpd'.")
  }
  lower <- params$lower
  upper <- params$upper
  if (is.infinite(upper)){
    upper <- qjqpd(0.999, params)
  }

  x <- seq(lower, upper, length.out = 1001)
  p <- seq(0.001, 0.999, length.out = 1001)
  density <- djqpd(x, params)
  cdf <- pjqpd(x, params)
  quantile <- qjqpd(p, params)
  samples <- rjqpd(1000, params)

  old <- graphics::par(mfrow = c(2, 2), xaxs = "i", yaxs = "i")
  on.exit(graphics::par(old), add = TRUE)

  plot(x, density,
       type = "l", main = "PDF", xlab = "x", ylab = "Density")
  plot(x, cdf, type = "l", main = "CDF", xlab = "x", ylab = "P(X<=x)")
  plot(p, quantile, type = "l", main = "Quantile Function", xlab = "p",
       ylab = "P(X<=x)=p")
  plot(samples, type = "p", main = "Random Sample", xlab = "sample",
       ylab = "X")
}
