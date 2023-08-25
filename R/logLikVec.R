#' Evaluate Log-likelihood Contributions From Specific Observations
#'
#' This is a generic function for calculating log-likelihood contributions from
#' individual observations for a fitted model.
#'
#' @param object A fitted model object.
#' @param pars A vector of coefficients.
#' @param ... Further arguments.
#'
#' @return A vector of individual log-likelihood contributions of class
#'         \code{"logLikVec"}, computed from \code{"betareg"} object,
#'         with two additional attributes:
#'             \item{nobs}{number of observations}
#'             \item{df}{degrees of freedom}
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
#'
#' @examples
#' data("sp", package = "abetareg")
#'
#' ## Data scaling suggested by Smithson and Verkuilen (2006)
#' x <- sp$performance
#' x1 <- (x - 10) / (100 - 10)
#' x2 <- (x1 * (length(x) - 1) + 0.5) / length(x)
#' sp$performance <- x2
#'
#' ## Fit the betareg model
#' library(betareg)
#' fit <- betareg(performance ~ studyh + ea + previous | studyh + sleeph, data = sp)
#' summary(fit)
#'
#' ## Check if the sum of individual log-likelihood == total log-likelihood
#' all.equal(fit$loglik, sum(logLikVec(fit)), check.attributes = FALSE)
#'
#' @references Smithson, Michael & Verkuilen, Jay. (2006). A better lemon
#'             squeezer? Maximum-likelihood regression with beta-distributed
#'             dependent variables. Psychological methods. 11. 54-71.
#'             \doi{10.1037/1082-989X.11.1.54}
logLikVec.betareg <- function(object, pars = NULL, ...){
  # Discard other arguments
  if (!missing(...)) {
    warning("extra arguments discarded")
  }

  # Replace object with the inputted mean and precision
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
