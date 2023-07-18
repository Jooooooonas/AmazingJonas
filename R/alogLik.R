#' Title
#'
#' @export
alogLik <- function(x, cluster = NULL, use_vcov = TRUE, ...)UseMethod("alogLik")

#' Title
#'
#' @export
alogLik.betareg <- function(x, cluster = NULL, use_vcov = TRUE, ...) {
  # Call adj_object() to adjust the log-likelihood
  res <- adj_object(x, cluster = cluster, use_vcov = use_vcov, ...)
  class(res) <- c("AmazingJonas", "chandwich", class(x))
  return(res)
}
