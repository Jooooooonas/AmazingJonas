library(betareg)
set.seed(996)
data <- data.frame(y = stats::rbeta(100, shape1 = 12, shape2 = 34),
                   x1 = stats::rnorm(100, mean = 5, sd = 6),
                   x2 = stats::rgamma(100, shape = 7, rate = 8),
                   x3 = sample(1:10, size = 100, replace = T))
fit <- betareg(y ~ x1 + x2 + x3, data = data)

test_that("logLik() vs. logLik(logLikVec)", {
  expect_equal(logLik(fit), logLik(logLikVec(fit)), ignore_attr = TRUE)
})

fit2 <- betareg(y ~ x1 + x2 + x3 | x1, data = data)

test_that("logLik() vs. logLik(logLikVec)", {
  expect_equal(logLik(fit2), logLik(logLikVec(fit2)), ignore_attr = TRUE)
})
