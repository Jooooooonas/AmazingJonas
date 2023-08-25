#' Adjust Log-likelihood For Fitted Models
#'
#' This is a generic function for adjusting log-likelihood from a fitted model,
#' following Chandler and Bate (2007).
#'
#' @param x A fitted model object with certain associated S3 methods.
#'
#' @param cluster A vector or factor indicating from which cluster the
#'   respective log-likelihood contributions from \code{loglik} originate.
#'   This must have the same length as the vector returned by the
#'   \code{logLikVec} method for an object like \code{x}.
#'   If \code{cluster} is not supplied (i.e. is \code{NULL}) then it is
#'   assumed that each observation forms its own cluster.
#'
#' @param use_vcov A logical scalar.  Should we use the \code{vcov} S3 method
#'   for \code{x} (if this exists) to estimate the Hessian of the independence
#'   log-likelihood to be passed as the argument \code{H} to
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
#' @return An object inheriting from class \code{"chandwich"}.  See
#'   \code{\link[chandwich]{adjust_loglik}}.
#'
#' @references Chandler, R. E. and Bate, S. (2007). Inference for clustered
#'   data using the independence loglikelihood. \emph{Biometrika},
#'   \strong{94}(1), 167-183. \doi{10.1093/biomet/asm015}
#' @references Smithson, Michael & Verkuilen, Jay. (2006). A better lemon
#'             squeezer? Maximum-likelihood regression with beta-distributed
#'             dependent variables. Psychological methods. 11. 54-71.
#'             \doi{10.1037/1082-989X.11.1.54}
#'
#' @rdname aloglik
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
#' ## Adjust the log-likelihood
#' adj <- alogLik(fit)
#' adj2 <- alogLik(fit, cluster = sp$sqpp)
#' (s1 <- summary(adj))
#' (s2 <- summary(adj2))
#'
#' ## How are the standard errors affected?
#' plot(s2[,3], pch = 16, type = "o", col = "blue", lwd = 2,
#'      xlab = "covariates", ylab = "SE", main = "Standard Error Difference")
#' points(s1[,3], pch = 16, type = "o", col = "red", lwd = 2)
#' points(s1[,2], pch = 16, type = "o", col = "black", lwd = 2)
#' legend(x = 1, y = 0.3, legend = c("MLE SE", "ADJ SE", "ADJ SE with clusters"),
#'        col = c("black","red","blue"), lwd = 2, pch = 16, cex = .8)
alogLik <- function(x, cluster = NULL, use_vcov = TRUE, ...){
  UseMethod("alogLik")
}

#' @rdname aloglik
#' @export
alogLik.betareg <- function(x, cluster = NULL, use_vcov = TRUE, ...) {
  # Call adj_object() to adjust the log-likelihood
  res <- adj_object(x, cluster = cluster, use_vcov = use_vcov, ...)
  class(res) <- c("abetareg", "chandwich", class(x))
  return(res)
}
