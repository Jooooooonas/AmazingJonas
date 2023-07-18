
<!-- README.md is generated from README.Rmd. Please edit that file -->

# AmazingJonas

<!-- badges: start -->
<!-- badges: end -->

The goal of AmazingJonas is to start my project.

## Installation

You can install the development version of AmazingJonas like so:

``` r
# install.packages("devtools")
devtools::install_github("Jooooooonas/AmazingJonas")
```

## Here is the current processing stage.

1.  Create a function (amazing) that calculates the individual
    log-likelihood contribution. (currently done)
2.  Create alogLik(). (currently done)
3.  Document the functions correctly and find a nice example.

## The followings are default texts.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(AmazingJonas)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
