#' Calculates the parameters of the Johnson Quantile-Parameterised Distribution
#'
#' @param x a length 3 numeric vector containing the symmetric percentile
#'  triplet values used to parameterise the distribution.
#' @param lower a real number specifying the lower bound of the distribution.
#'  (default: 0)
#' @param upper a real number specifying the upper bound of the distribution. A
#'  value of Inf indicates a semi-bounded distribution. (default: Inf)
#' @param alpha a real number (between 0 and 0.5) used to describe the symmetric
#'  percentile triplet for which the quantile values provided in 'x' correspond.
#'  For instance, alpha = 0.1 (default value) indicates the percentiles used are
#'  [0.1, 0.5, 0.9].
#'
#' @return A \code{jqpd} object with elements
#' \item{x}{a length 3 numeric vector containing the symmetric percentile
#'  triplet values used to parameterise the distribution}
#' \item{alpha}{a real number (between 0 and 0.5) used to describe the symmetric
#'  percentile triplet for which the quantile values provided in 'x' correspond}
#' \item{lower}{a real number specifying the lower bound of the distribution}
#' \item{upper}{a real number specifying the upper bound of the distribution}
#' \item{c}{distribution parameter}
#' \item{n}{distribution parameter}
#' \item{eta}{distribution parameter}
#' \item{delta}{distribution parameter}
#' \item{lambda}{distribution parameter}
#' \item{k}{distribution parameter}
#' @export
#'
#' @examples
#' theta <- jqpd(c(0.32, 0.40, 0.6), 0, 1, alpha = 0.1)
jqpd <- function(x, lower = 0, upper = Inf, alpha = 0.1){

  if (!is_valid_numeric_input(x, 3)){
    stop("Input 'x' must be a length 3 numeric vector.")
  }

  if (!is_valid_bounds(lower, upper)){
    stop("Inputs 'lower' and 'upper' must be length 1 numeric vectors.")
  }

  if (!is_valid_alpha(alpha)) {
    stop("Inputs 'alpha' must be length 1 numeric vector between 0 and 0.5.")
  }

  if (!is_compatible(x, lower, upper)){
    stop("The quantiles provided are not compatible. Please ensure that:
         lower < x[1] < x[2] < x[3] < upper")
  }

  # Lots of sanity checks here.
  if(is.infinite(upper)){
    return(semibounded_params(x, lower, alpha))
  }
  bounded_params(x, lower, upper, alpha)
}

bounded_params <- function(x, lower, upper, alpha = 0.1){

  c <- stats::qnorm(1-alpha)
  L <- stats::qnorm((x[1] - lower)/(upper-lower))
  B <- stats::qnorm((x[2] - lower)/(upper-lower))
  H <- stats::qnorm((x[3] - lower)/(upper-lower))
  n <- sign(L + H - 2*B)

  eta <- L
  if (n == 0){
    eta <- B
  }
  if (n == -1){
    eta <- H
  }

  delta <- (1/c)*acosh((H-L)/(2*min(B-L, H-B)))
  lambda <- (H-L) / sinh(2*delta*c)

  params <- structure(list(), class = "jqpd")
  params$x <- x
  params$alpha <- alpha
  params$lower <- lower
  params$upper <- upper
  params$c <- c
  params$n <- n
  params$eta <- eta
  params$delta <- delta
  params$lambda <- lambda
  params$k <- 0
  params
}

semibounded_params <- function(x, lower, alpha = 0.1){

  c <- stats::qnorm(1-alpha)
  L <- log(x[1] - lower)
  B <- log(x[2] - lower)
  H <- log(x[3] - lower)
  n <- sign(L + H - 2*B)
  eta <- x[1] - lower
  if (n == 0){
    eta <- x[2] - lower
  }
  if (n == -1){
    eta <- x[3] - lower
  }

  delta <- (1/c)*sinh(acosh((H-L)/(2*min(B-L, H-B))))
  lambda <- (1 / (delta*c))*min(H-B, B-L)
  k <- sqrt(1+(c*delta)^2)

  params <- structure(list(), class = "jqpd")
  params$x <- x
  params$alpha <- alpha
  params$lower <- lower
  params$upper <- Inf
  params$c <- c
  params$n <- n
  params$eta <- eta
  params$delta <- delta
  params$lambda <- lambda
  params$k <- k
  params
}
