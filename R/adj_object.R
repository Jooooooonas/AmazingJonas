#' Internal abetareg functions
#'
#' Internal abetareg functions
#' @details
#' These functions are not intended to be called by the user.
#' @name abetareg-internal
#' @keywords internal
NULL

#' @keywords internal
#' @rdname abetareg-internal
adj_object <- function(x, cluster = NULL, use_vcov = TRUE, ...) {
  #
  # Make coefficients as the first argument of the individual log-likelihood
  # contribution function
  #
  loglik_fn <- function(pars, fitted_object, ...) {
    return(logLikVec(fitted_object, pars = pars))
  }
  #
  # Set H, but not if use_vcov = FALSE or no vcov method exists ----------
  #
  if (!use_vcov) {
    H <- NULL
  } else {
    H <- -solve(vcov(x))
  }
  #
  # Set mle and nobs ----------
  #
  mle <- coef(x)
  n_obs <- x$nobs
  #
  # Set V, using meat() or meatCL() from the sandwich package ----------
  #
  if (is.null(cluster)) {
    V <- sandwich::meat(x, fitted_object = x, loglik_fn = loglik_fn,
                        ...) * n_obs
  } else {
    V <- sandwich::meatCL(x, cluster = cluster, fitted_object = x,
                          loglik_fn = loglik_fn, ...) * n_obs
  }
  #
  # We don't pass cluster because it would only be used in the estimation of
  # V: we have already estimated V using sandwich::meat() or sandwich::meatCL()
  #
  res <- chandwich::adjust_loglik(loglik = loglik_fn,
                                  fitted_object = x,
                                  p = length(mle),
                                  par_names = names(mle),
                                  name = paste(class(x), collapse = "_"),
                                  mle = mle, H = H, V = V)
  class(res) <- c("abetareg", "chandwich")
  return(res)
}
