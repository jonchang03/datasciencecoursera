## Quiz 2

## 1. Consider the following data with x as the predictor and y as as the outcome.
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
# Give a P-value for the two sided hypothesis test of whether β1 from a linear regression model is 0 or not.

# from Chapter 5, question 1
summary(lm(y ~ x))$coef
## 0.05296439

## 2. Consider the previous problem, give the estimate of the residual standard deviation.
summary(lm(y ~ x))$sigma
## 0.223

## 3. In the mtcars data set, fit a linear regression model of weight (predictor) on mpg(outcome). Get a 95%
# confidence interval for the expected mpg at the average weight. What is the lower endpoint?

# Chapter 7 Exercise 4
data(mtcars)
x <- mtcars$wt
y <- mtcars$mpg
fit <- lm(y ~ x)
predict(fit, newdata = data.frame(x = mean(x)), interval = "confidence")
## 18.99098

## 4. Refer to the previous question. Read the help file for mtcars. What is the weight coefficient interpreted as?
## Weight coefficient is interpreted as estimated expected change in mpg per 1000 lb increase in weight

## 5. Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (1,000 lbs).
# A new car is coming weighing 3000 pounds. Construct a 95% prediction interval for its mpg. What is the upper endpoint?
predict(fit, newdata = data.frame(x = 3), interval = "prediction")
## 27.57355

## 6. Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (1,000 lbs).
# A "short" ton is deefined as 2,000 lbs. Construct a 95% confidence interval for the expected change
# in mpg per 1 short ton increase in weight. Give the lower endpoint.

# change unit of predictor by dividing - pg. 31
fit2 <- lm(y ~ I(x/2))
# getting confidence interval - pg. 49
sumCoef <- summary(fit2)$coefficients
(sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit2$df) * sumCoef[2, 2])
## -12.97262

## 7. If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to
# the slope coefficient?
# pg. 29
## 1m = 100cm
## To convert to meters, you would have to multiply by 1m/100cm which means the coefficient is multiplied by 100

## 8. I have an outcome, Y, and a predictor, X and fit a linear regression model with Y=β0+β1X+ϵ to obtain β^0 and β^1.
# What would be the consequence to the subsequent slope and intercept if I were to refit the model
# with a new regressor, X+c for some constant, c?
# pg. 28
# changes intercept, but not the slope
## new intercept would be β0 - cβ1

## 9. Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor. About what is the
# ratio of the sum of the squared errors, when comparing a model with just an intercept (denominator) to the model
# with the intercept and slope (numerator)?
sum(resid(fit)^2) / sum((y - mean(y)) ^ 2)
## 0.2471672

## 10. Do the residuals always have to sum to 0 in linear regression?
## If an intercept is included, then they will sum to 0.