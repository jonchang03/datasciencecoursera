## Quiz 3

## 1. Consider the mtcars data set. Fit a model with mpg as the outcome that includes number of cylinders as a
# a factor variable and weight as confounder. Give the adjusted estimate for the expected change in mpg comparing
# 8 cylinders to 4.
data(mtcars)
fit <- lm(mpg ~ factor(cyl) + wt, data=mtcars)
summary(fit)$coef
## -6.071

## 2. Consider the mtcars data set. Fit a model with mpg as the outcome that includes number of cylinders as a factor
# variable and weight as a possible confounding variable. Compare the effect of 8 versus 4 cylinders on mpg for the
# adjusted and unadjusted by weight models. Here, adjusted means including the weight variable as a term in the
# regression model and unadjusted means the model without weight included. What can be said about the effect
# comparing 8 and 4 cylinders after looking at models with and without weight included?
fit2 <- lm(mpg ~ factor(cyl), data=mtcars)
summary(fit2)$coef
## -11.563636 (without weight) => greater effect
## Holding weight constant, cylinder appears to have less of an impact on mpg than if weight is disregarded.

## 3. Consider the mtcars data set. Fit a model with mpg as the outcome that considers number of cylinders as a
# factor variable and weight as confounder. Now fit a second model with mpg as the outcome model that considers
# the interaction between number of cylinders (as a factor variable) and weight. Give the P-value for the likelihood
# ratio test comparing the two models and suggest a model using 0.05 as a type I error rate significance benchmark.
fit3 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
fit4 <- lm(mpg ~ factor(cyl) * wt, data = mtcars)
anova(fit3, fit4)
## The P-value is larger than 0.05. So, according to our criterion, we would fail to reject,
# which suggests that the interaction terms may not be necessary.

## 4. Consider the mtcars data set. Fit a model with mpg as the outcome that includes number of cylinders as a factor
# variable and weight inlcuded in the model as
lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
# How is the wt coefficient interpretted?
## The estimated expected change in MPG per one ton increase in weight for a specific number of cylinders (4, 6, 8).


## 5. Consider the following data set
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# Give the hat diagonal for the most influential point
fit <- lm(y ~ x)
max(hatvalues(fit))
## 0.9945734

## 6. Consider the following data set
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
# Give the slope dfbeta for the point with the highest hat value.
fit <- lm(y ~ x)
influence.measures(fit)$infmat[5,"dfb.x"]
## -133.8226

## 7. Consider a regression relationship between Y and X with and without adjustment for a third variable Z. Which of
# the following is true about comparing the regression coefficient between Y and X with and without adjustment for Z.

## It is possible for the coefficient to reverse sign after adjustment. For example, it can be strongly significant
# and positive before adjustment and strongly significant and negative after adjustment.

