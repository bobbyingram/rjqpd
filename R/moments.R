moments <- function(params, n = 1, c = 0, ...){
  f <- function(x) ((x-c)^n) * djqpd(x, params)
  mu <- stats::integrate(f, params$lower, params$upper, ...)
  mu$value
}

#' Calculates the mean of a Johnson Quantile-Parameterised Distribution.
#'
#' @param params jqpd object created using \code{jqpd()}
#' @return The mean of the distribution as a length one numeric vector.
#' @export
jqpd_mean <- function(params) {
  if(!is_jqpd_obj(params)){
    stop("Input 'params' must have class 'jqpd'.")
  }
  moments(params)
}

#' Calculates the variance of a Johnson Quantile-Parameterised Distribution.
#'
#' @param params jqpd object created using \code{jqpd()}
#' @return The variance of the distribution as a length one numeric vector.
#' @export
jqpd_var <- function(params){
  if(class(params) != "jqpd"){
    stop("Input 'params' must have class 'jqpd'.")
  }
  mu <- jqpd_mean(params)
  moments(params, 2, mu)
}

#' Calculates the standard-deviation of a Johnson Quantile-Parameterised
#' Distribution.
#'
#' @param params jqpd object created using \code{jqpd()}
#' @return The standard deviation of the distribution as a length one numeric
#' vector.
#' @export
jqpd_sd <- function(params){
  sqrt(jqpd_var(params))
}

#' Calculates the skewness of a Johnson Quantile-Parameterised
#' Distribution.
#'
#' @param params jqpd object created using \code{jqpd()}
#' @return The skewness of the distribution as a length one numeric vector.
#' @export
jqpd_skewness <- function(params){
  if(class(params) != "jqpd"){
    stop("Input 'params' must have class 'jqpd'.")
  }
  mu <- jqpd_mean(params)
  sd <- jqpd_sd(params)
  moments(params, 3, mu) / sd^3
}

#' Calculates the kurtosis of a Johnson Quantile-Parameterised
#' Distribution.
#'
#' @param params jqpd object created using \code{jqpd()}
#' @return The kurtosis of the distribution as a length one numeric vector.
#' @export
jqpd_kurtosis <- function(params){
  if(class(params) != "jqpd"){
    stop("Input 'params' must have class 'jqpd'.")
  }
  mu <- jqpd_mean(params)
  var <- jqpd_var(params)
  moments(params, 4, mu) / var^2
}
