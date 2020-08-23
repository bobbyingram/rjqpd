#' Generate random samples from a jqpd distribution object
#'
#' @param n number of observations (default is 1)
#' @param params jqpd object created using \code{jqpd()}
#' @return A numeric vector of n random samples from the input distribution
#'
#' @export
#'
#' @examples
#' x <- c(0.32, 0.40, 0.60)
#' params <- jqpd(x, lower = 0, upper = 1, alpha = 0.1)
#' samples <- rjqpd(n = 1000, params)
rjqpd <- function(n = 1, params){
  UseMethod("rjqpd", params)
}

#' @export
rjqpd.default <- function(n, params){
  print("Object must have class 'jqbd'.")
}

#' @export
rjqpd.jqpd <- function(n, params){
  qjqpd(stats::runif(n), params)
}
