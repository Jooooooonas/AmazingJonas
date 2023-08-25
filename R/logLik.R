#' Sum Log-likelihood Contributions From Individual Observations
#'
#' S3 logLik method for logLikVec objects
#'
#' @param object An object of class \code{"logLikVec"} returns from a
#'   \code{logLikVec} method.
#' @param ... Further arguments.
#'
#' @return An object of class \code{"logLik"} that sums up all the individual
#'         log-likelihood contributions from the object of class
#'         \code{"logLikVec"}. Attributes are saved from \code{"logLikVec"}.
#'
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
#' logLik(logLikVec(fit)) ## This should be the expected sum of log-likelihoods
#'
#' ## Check if the sum of individual log-likelihood == total log-likelihood
#' all.equal(logLik(fit), logLik(logLikVec(fit)), check.attributes = FALSE)
#'
#' @references Smithson, Michael & Verkuilen, Jay. (2006). A better lemon
#'             squeezer? Maximum-likelihood regression with beta-distributed
#'             dependent variables. Psychological methods. 11. 54-71.
#'             \doi{10.1037/1082-989X.11.1.54}
logLik.logLikVec <- function(object, ...) {
  save_attributes <- attributes(object)
  object <- sum(object) # Sum all individual contributions
  attributes(object) <- save_attributes
  class(object) <- "logLik"
  return(object)
}
