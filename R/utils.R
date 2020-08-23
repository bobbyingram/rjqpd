is_jqpd_obj <- function(obj){
  class(obj) == "jqpd"
}

is_bounded <- function(jqpd){
  !is.infinite(jqpd$upper)
}

is_compatible <- function(x, lower, upper){
  all(diff(c(lower, x, upper)) > 0)
}

is_valid_alpha <- function(alpha){
  is_valid_numeric_input(alpha) && alpha > 0 && alpha < 0.5
}

is_valid_bounds <- function(lower, upper){
  is_valid_numeric_input(lower) && is_valid_numeric_input(upper)
}

is_valid_numeric_input <- function(x, n = 1){
  length(x) == n && class(x) == "numeric"
}

construct_spt <- function(alpha){
  c(alpha, 0.5, 1-alpha)
}
