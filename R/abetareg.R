#' abetareg: Log-likelihood Adjustment for Beta Regression Models
#'
#' This package preforms log-likelihood adjustment for beta
#' regression, using maximum likelihood estimation, by 'betareg' package
#' \href{https://cran.r-project.org/package=betareg}{betareg}.
#'
#' @docType package
#' @name abetareg
#' @import betareg
#' @importFrom stats coef nobs vcov
NULL

#' Student Performance
#'
#' The Student Performance Dataset is a dataset designed to examine the factors
#' influencing academic student performance. The dataset consists of 10,000
#' student records, with each record containing information about various
#' predictors and a performance index.
#'
#' The dataset aims to provide insights into the relationship between the
#' predictor variables and the performance index. Researchers and data analysts
#' can use this dataset to explore the impact of studying hours, previous
#' scores, extracurricular activities, sleep hours, and sample question papers
#' on student performance.
#'
#' P.S: Please note that this dataset is synthetic and created for illustrative
#' purposes. The relationships between the variables and the performance index
#' may not reflect real-world scenarios.
#'
#' @format A data frame with 10,000 rows and 6 columns:
#' \describe{
#'   \item{studyh}{The total number of hours spent studying by each student.}
#'   \item{previous}{The scores obtained by students in previous tests.}
#'   \item{ea}{Whether the student participates in extracurricular activities
#'             (Yes or No).}
#'   \item{sleeph}{The average number of hours of sleep the student had per day.}
#'   \item{sqpp}{The number of sample question papers the student practiced.}
#'   \item{performance}{A measure of the overall performance of each
#'                            student. The performance index represents the
#'                            student's academic performance and has been
#'                            rounded to the nearest integer. The index ranges
#'                            from 10 to 100, with higher values indicating
#'                            better performance.}
#' }
#' @source <https://www.kaggle.com/datasets/nikhil7280/student-performance-multiple-linear-regression>
"sp"
