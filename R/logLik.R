#' Sum Log-likelihood Contributions From Individual Observations
#'
#' S3 logLik method for logLikVec objects
#'
#' @param object An object of class \code{"logLikVec"} return from a
#'   \code{logLikVec} method.
#' @param ... Further arguments.
#'
#' @export
logLik.logLikVec <- function(object, ...) {
  save_attributes <- attributes(object)
  object <- sum(object) # Sum all individual contributions
  attributes(object) <- save_attributes
  class(object) <- "logLik"
  return(object)
}
