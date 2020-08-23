#' Density function of Johnson Quantile-Parameterised Distribution.
#'
#' @param x vector of quantiles
#' @param params jqpd object created using \code{jqpd()}
#' @return A numeric vector of density values corresponding to the x quantile
#'   vector
#'
#' @export
#'
#' @examples
#' x <- c(0.32, 0.40, 0.60)
#' params <- jqpd(x, lower = 0, upper = 1, alpha = 0.1)
#' iles <- seq(0.01, 0.99, 0.01)
#' density <- djqpd(x = iles, params)
djqpd <- function(x, params){
  UseMethod("djqpd", params)
}

#' @export
djqpd.default <- function(x, params){
  print("'params' object must have class 'jqbd'.")
}

#' @export
djqpd.jqpd <- function(x, params){
  d <- numeric(length(x))
  i <- x > params$lower & x < params$upper

  # Outside of the bounds the density is undefined.
  d[!i] <- NaN
  # At the boundaries the density is zero.
  d[x == params$lower] <- 0
  d[x == params$upper] <- 0

  # Only calculate the density inside the bounds.
  if (length(x[i]) <= 0){
    return(d)
  }
  if(is_bounded(params)){
    d[i] <- density_bounded(x[i], params)
  } else{
    d[i] <- density_semibounded(x[i], params)
  }
  d
}

density_bounded <- function(x, params){
  eta <- params$eta
  lambda <- params$lambda
  delta <- params$delta
  c <- params$c
  l <- params$lower
  u <- params$upper
  n <- params$n
  k <- params$k

  z0 <- stats::qnorm((x-l)/(u-l))
  z1 <- stats::dnorm(-n*c + (1/delta)*asinh((1/lambda)*(-eta+z0)))
  z2 <- delta*(u-l)*sqrt(lambda^2 + (-eta+z0)^2)*stats::dnorm(z0)
  z1 / z2
}

density_semibounded <- function(x, params){
  eta <- params$eta
  lambda <- params$lambda
  delta <- params$delta
  c <- params$c
  l <- params$lower
  u <- params$upper
  n <- params$n
  k <- params$k

  L <- log((x-l)/eta)
  z1 <- 1 / (lambda*delta*(x-l))
  z2 <- k - (n*c*delta*(L / sqrt(lambda^2 + L^2)))
  z3 <- stats::dnorm((1/(lambda*delta))*(k*L-n*c*delta*sqrt(lambda^2 + L^2)))

  z1 * z2 * z3
}
