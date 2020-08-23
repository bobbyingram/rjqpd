#' Quantile function of Johnson Quantile-Parameterised Distribution.
#'
#' @param p vector of probabilities
#' @param params jqpd object created using \code{jqpd()}
#' @return A numeric vector of quantiles corresponding to the p probability
#'   vector
#'
#' @export
#'
#' @examples
#' x <- c(0.32, 0.40, 0.60)
#' params <- jqpd(x, lower = 0, upper = 1, alpha = 0.1)
#' probs <- seq(0.01, 0.99, 0.01)
#' quantiles <- qjqpd(p = probs, params)
qjqpd <- function(p, params){
  UseMethod("qjqpd", params)
}

#' @export
qjqpd.jqpd <- function(p, params){
  x <- numeric(length(p))
  i <- p > 0 & p < 1
  # Outside of the bounds the QF is undefined.
  x[!i] <- NaN
  # When the CDF is zero the quantile is the lower boundary.
  x[p == 0] <- params$lower
  # When the CDF is 1 the quantile is the upper boundary.
  x[p == 1] <- params$upper

  if(is_bounded(params)){
    x[i] <- quantile_bounded(p[i], params)
  } else{
    x[i] <- quantile_semibounded(p[i], params)
  }
  x
}

#' @export
qjqpd.default <- function(p, params){
  print("'params' object have class 'jqbd'.")
}

quantile_bounded <- function(p, params){
  l <- params$lower
  u <- params$upper

  eta <- params$eta
  lambda <- params$lambda
  delta <- params$delta
  n <- params$n
  c <- params$c

  l + (u-l)*stats::pnorm(eta + (lambda*sinh(delta*(stats::qnorm(p)+(n*c)))))
}

quantile_semibounded <- function(p, params){
  l <- params$lower

  eta <- params$eta
  lambda <- params$lambda
  delta <- params$delta
  n <- params$n
  c <- params$c

  l + eta*exp(lambda*sinh(asinh(delta*stats::qnorm(p))+asinh(n*c*delta)))
}
