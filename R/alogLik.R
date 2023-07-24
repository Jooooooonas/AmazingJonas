#' Adjust Log-likelihood For Fitted Models
#'
#' This is a generic function for adjusting log-likelihood from a fitted model,
#' following Chandler and Bate (2007).
#'
#' @param x A fitted model object with certain associated S3 methods.
#'   See \strong{Details}.
#'
#' @param cluster A vector or factor indicating from which cluster the
#'   respective loglikelihood contributions from \code{loglik} originate.
#'   This must have the same length as the vector returned by the
#'   \code{logLikVec} method for an object like \code{x}.
#'   If \code{cluster} is not supplied (i.e. is \code{NULL}) then it is
#'   assumed that each observation forms its own cluster.
#'   See \strong{Details}.
#'
#' @param use_vcov A logical scalar.  Should we use the \code{vcov} S3 method
#'   for \code{x} (if this exists) to estimate the Hessian of the independence
#'   loglikelihood to be passed as the argument \code{H} to
#'   \code{\link[chandwich]{adjust_loglik}}?
#'   Otherwise, \code{H} is estimated inside
#'   \code{\link[chandwich]{adjust_loglik}} using
#'   \code{\link[stats:optim]{optimHess}}.
#'
#' @param ... Further arguments to be passed to the functions in the
#'   sandwich package \code{\link[sandwich]{meat}} (if \code{cluster = NULL}),
#'   or \code{\link[sandwich:vcovCL]{meatCL}} (if \code{cluster} is not
#'   \code{NULL}).
#'
#' @references Chandler, R. E. and Bate, S. (2007). Inference for clustered
#'   data using the independence loglikelihood. \emph{Biometrika},
#'   \strong{94}(1), 167-183. \doi{10.1093/biomet/asm015}
#'
#' @export
alogLik <- function(x, cluster = NULL, use_vcov = TRUE, ...){
  UseMethod("alogLik")
}

#' @export
alogLik.betareg <- function(x, cluster = NULL, use_vcov = TRUE, ...) {
  # Call adj_object() to adjust the log-likelihood
  res <- adj_object(x, cluster = cluster, use_vcov = use_vcov, ...)
  class(res) <- c("AmazingJonas", "chandwich", class(x))
  return(res)
}
