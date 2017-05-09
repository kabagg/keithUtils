#' Emulates the jet colormap from Matlab
#'
#' @param n the number of levels in the colormap;
#'     the default is 64
#' @return an rgb vector of length n
#' @examples
#' plot(1:64, col=jet.colors(64))
#' @export
jet.colors <- function(n = 64){

  ## JET.COLORS(n)
  ## Defines a jet colormap (blue is low, red is high) with
  ## n levels. Returns an n by 3 matrix of rgb values.

  k <- ceiling(n/4);
  temp.red <- c(rep(0, 2*k), 1:k, rep(k, k-1), k:1);
  temp.green <- c(rep(0, k), 1:k, rep(k, k-1), k:1, rep(0, k));
  temp.blue <- c(1:k, rep(k, k-1), k:1, rep(0, 2*k));
  temp.rgb <- cbind(temp.red, temp.green, temp.blue);
  delta <- 5 * k - 1 - n;
  delta <- ceiling(delta/2);
  temp.rgb <- temp.rgb[delta:(delta + n - 1),] / k;

  ## assemble everything; last value is returned
  jet.colors <-
    rgb(temp.rgb[,1], temp.rgb[,2], temp.rgb[,3]);

}
