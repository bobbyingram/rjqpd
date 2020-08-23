#' Cumulative distribution function of Johnson Quantile-Parameterised
#' Distribution.
#'
#' @param x vector of quantiles
#' @param params jqpd object created using \code{jqpd()}
#' @return A numeric vector of probabilities corresponding to the x quantiles
#'   vector
#'
#' @export
#'
#' @examples
#' x <- c(0.32, 0.40, 0.60)
#' params <- jqpd(x, lower = 0, upper = 1, alpha = 0.1)
#' iles <- seq(0.01, 0.99, 0.01)
#' probs <- pjqpd(x = iles, params)
pjqpd <- function(x, params){
  UseMethod("pjqpd", params)
}

#' @export
pjqpd.default <- function(x, params){
  print("'params' object must have class 'jqbd'.")
}

#' @export
pjqpd.jqpd <- function(x, params){
  p <- numeric(length(x))
  i <- x > params$lower & x < params$upper
  # Outside of the bounds the CDF is undefined.
  p[!i] <- NaN
  # At the lower boundary the CDF has value 0.
  p[x == params$lower] <- 0
  # At the upper boundary the CDF has value 1.
  p[x == params$upper] <- 1

  if (length(x[i]) <= 0){
    return(p)
  }
  # Calculate the CDF at all points inside the bounds
  if(is_bounded(params)){
    p[i] <- cdf_bounded(x[i], params)
  } else {
    p[i] <- cdf_semibounded(x[i], params)
  }
  p
}

cdf_bounded <- function(x, params){
  l <- params$lower
  u <- params$upper

  eta <- params$eta
  lambda <- params$lambda
  delta <- params$delta
  n <- params$n
  c <- params$c

  stats::pnorm((1/delta)*asinh((1/lambda)*(stats::qnorm((x-l)/(u-l))-eta))-n*c)
}

cdf_semibounded <- function(x, params){
  l <- params$lower

  eta <- params$eta
  lambda <- params$lambda
  delta <- params$delta
  n <- params$n
  c <- params$c

  stats::pnorm((1/delta)*sinh(asinh((1/lambda)*log((x-l)/eta))-asinh(n*c*delta)))
}
