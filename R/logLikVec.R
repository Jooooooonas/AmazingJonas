#' Title
#'
#'
#' @export
logLikVec <- function(object, ...) UseMethod("logLikVec")

#' Title
#'
#' @export
logLikVec.betareg <- function(object, pars = NULL, ...){
  # Don't bother with other arguments
  if (!missing(...)) {
    warning("extra arguments discarded")
  }

  # Require pars to be a list of two: mean and precision
  if (!is.null(pars)) {
    object$coefficients$mean <- pars$mean
    object$coefficients$precision <- pars$precision
  }

  # Extract means
  mu <- object$fitted.values

  # Extract variance
  var <- predict(object = object, type = "variance")

  # Change means and precisions to shape1 and shape2
  shape1 <- ((1 - mu) / var - 1 / mu) * mu ^ 2
  shape2 <- shape1 * (1 / mu - 1)

  # Calculate the log-likelihood (need to consider neg alpha&beta??? YES!!!)
  if (any(shape1 <= 0) || any(shape2 <= 0)) val <- -Inf else {
    val <- dbeta(object$y, shape1 = shape1, shape2 = shape2, log = T)
  }

  # Return the usual attributes for a "logLik" object
  names(val) <- NULL
  attr(val, "nobs") <- nobs(object)
  attr(val, "df") <- length(coef(object))
  class(val) <- "logLikVec"
  return(val)
}
