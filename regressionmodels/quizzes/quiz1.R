## Quiz 1

## 1. Give the value of μ that minimizes the least squares equation
x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)
sum(x*w)/sum(w)
## 0.1471429

## 2.
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y ~ x - 1)
# ?formula:
# y ~ x - 1 specifis a line through the origin
## 0.8263

## 3. Do data(mtcars) from the datsets package and fit the regression model with mpg as the outcome and weight as
# the predictor. Give the slope coefficient.
data(mtcars)
#head(mtcars)
lm(mtcars$mpg ~ mtcars$wt)
## -5.344

## 4. Consider data with an outcome (Y) and a predictor (X). The standard deviation of the predictor is one half
# that of the outcome. The correlation between the two variables is .5. What value would the slope coefficient
# for the regression model with Y as the outcome and X as the predictor?

# pg 19: B1 = Cor(Y,X) * Sd(Y)/Sd(X), where Sd(Y) = 2Sd(X)
# 0.5 * 2Sd(X)/Sd(X)
## 1

## 5. Students were given two hard tests and scores were normalized to have empirical mean 0 and variance 1.
# The correlation between the scores on the two tests was 0.4. What would be the expected score on Quiz 2
# for a student who had a normalized score of 1.5 on Quiz 1?

# pg 25: Cor(Y, X) ∗ Xi where Xi was the normalized score for Quiz 1 (Regression to the mean)
# 0.4 * 1.5
## 0.6

## 6. Consider the data given by the following. What is the value of the first measurement if x were normalized
# (to have mean 0 and variance 1)?
x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
# pg 15 gives normalization formula
((x - mean(x)) / sd(x))[1]
## -0.9718658

## 7. Consider the following data set (used above as well). What is the intercept for fitting the model
# with x as the predictor and y as the outcome?
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y ~ x)
## 1.567

## 8. You know that both the predictor and response have mean 0. What can be said about the intercept
# when you fit a linear regression?
## It must be identically 0

## 9. Consider the data given by:
# What value minimizes the sum of the squared distances between these points and itself?
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
# pg 5: minimized at the mean
mean(x)
## 0.573

## 10. Let the slope having fit Y as the outcome and X as the predictor be denoted as β1.
# Let the slope from fitting X as the outcome and Y as the predictor be denoted as γ1.
# Suppose that you divide β1 by γ1; in other words consider β1/γ1. What is this ratio always equal to?

# pg 19:
# B1 = Cor(Y,X)Sd(Y)/Sd(X)
# y1 = Cor(X,Y)Sd(X)/Sd(Y)
# Cor(Y,X) = Cor(X,Y)
# Var = Sd^2
## B1/y1 = Var(Y)/Var(X)
