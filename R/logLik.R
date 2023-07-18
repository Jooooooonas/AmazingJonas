#' Title
#'
#' @export
logLik.logLikVec <- function(object, ...) {
  save_attributes <- attributes(object)
  object <- sum(object)
  attributes(object) <- save_attributes
  class(object) <- "logLik"
  return(object)
  # why do we need this function
  # this function seems to sum the individual contributions
  # ism't there already a function doing this job?
}
