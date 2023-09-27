
<!-- README.md is generated from README.Rmd. Please edit that file -->

# abetareg

<!-- badges: start -->
<!-- badges: end -->

## Loglikelihood Adjustment for Beta Regression Models

The *abetareg* package adjusts the log-likelihood function for beta
regression from the
[betareg](https://cran.r-project.org/package=betareg) package to provide
robust sandwich estimation of parameter covariance matrix. The
methodology of the adjustment is based on the
[chandwich](https://cran.r-project.org/package=chandwich) package.

## An Example

``` r
library(abetareg)
data("sp", package = "abetareg")
# Data scaling suggested by Smithson and Verkuilen (2006)
x <- sp$performance
x1 <- (x - 10) / (100 - 10)
x2 <- (x1 * (length(x) - 1) + 0.5) / length(x)
sp$performance <- x2
# Fit a beta regression model for student performance
library(betareg)
opt_naive <- betareg(performance ~ studyh + ea | sleeph, data = sp)
# Adjust the log-likelihood function
adj_naive <- alogLik(opt_naive)
(s1 <- summary(adj_naive))
#>                         MLE       SE  adj. SE
#> (Intercept)       -0.682100 0.019070 0.019850
#> studyh             0.133800 0.003100 0.003214
#> eaYes              0.050830 0.015850 0.015910
#> (phi)_(Intercept)  1.706000 0.051680 0.046820
#> (phi)_sleeph      -0.004126 0.007654 0.006870
# Account for the clustered structure
adj_naive2 <- alogLik(opt_naive, cluster = sp$sqpp)
(s2 <- summary(adj_naive2))
#>                         MLE       SE  adj. SE
#> (Intercept)       -0.682100 0.019070 0.012300
#> studyh             0.133800 0.003100 0.002061
#> eaYes              0.050830 0.015850 0.014420
#> (phi)_(Intercept)  1.706000 0.051680 0.059870
#> (phi)_sleeph      -0.004126 0.007654 0.008568
```

### Installation

To get the current released version from CRAN:

``` r
install.packages("abetareg")
#> Warning: package 'abetareg' is in use and will not be installed
```

### Vignette

See `vignette("abetareg", package = "abetareg")` for an overview of the
package.
