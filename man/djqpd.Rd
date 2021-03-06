% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/djqpd.R
\name{djqpd}
\alias{djqpd}
\title{Density function of Johnson Quantile-Parameterised Distribution.}
\usage{
djqpd(x, params)
}
\arguments{
\item{x}{vector of quantiles}

\item{params}{jqpd object created using \code{jqpd()}}
}
\value{
A numeric vector of density values corresponding to the x quantile
  vector
}
\description{
Density function of Johnson Quantile-Parameterised Distribution.
}
\examples{
x <- c(0.32, 0.40, 0.60)
params <- jqpd(x, lower = 0, upper = 1, alpha = 0.1)
iles <- seq(0.01, 0.99, 0.01)
density <- djqpd(x = iles, params)
}
