#' rescale_bytiago
#'
#' \code{rescale_bytiago} description of your function
#'
#' @param \code{x} A numeric object
#' @usage get_each_data(data="name of the data")
#' @return returns a reescaled numeric varibles
#' @examples
#' rescale_bytiago(rnorm(10000))
#' @export


rescale_bytiago <- function(x){ # one input
  rng <- range(x) # More efficient
  (x - rng[1])/(rng[2] - rng[1])
}

