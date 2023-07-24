#' Evaluate Log-likelihood Contributions From Specific Observations
#'
#' This is a generic function for calculating log-likelihood contributions from
#' individual observations for a fitted model.
#'
#' @param object A fitted model object.(do we need to specify betareg here?)
#' @param pars A vector of coefficients.
#' @param ... Further arguments.
#'
#'
#' @name logLikVec
NULL

#' @rdname logLikVec
#' @export
logLikVec <- function(object, ...){
  UseMethod("logLikVec")
}

#' @rdname logLikVec
#' @export
logLikVec.betareg <- function(object, pars = NULL, ...){
  # Discard other arguments
  if (!missing(...)) {
    warning("extra arguments discarded")
  }

  # Require pars to be a list of two: mean and precision
  # No More Requirements! just a plain vector
  if (!is.null(pars)) {
    num_mean <- length(object$coefficients$mean)
    object$coefficients$mean <- pars[1:num_mean]
    object$coefficients$precision <- pars[-(1:num_mean)]
  }

  # Extract means
  mu <- predict(object = object, type = "response")

  # Extract variance
  var <- predict(object = object, type = "variance")

  # Change means and precisions to shape1 and shape2
  shape1 <- ((1 - mu) / var - 1 / mu) * mu ^ 2
  shape2 <- shape1 * (1 / mu - 1)

  # Calculate the log-likelihood
  if (any(shape1 <= 0) || any(shape2 <= 0)) val <- -Inf else {
    val <- stats::dbeta(object$y, shape1 = shape1, shape2 = shape2, log = T)
  }

  # Return the usual attributes for a "logLik" object
  names(val) <- NULL
  attr(val, "nobs") <- nobs(object)
  attr(val, "df") <- length(coef(object))
  class(val) <- "logLikVec"
  return(val)
}
