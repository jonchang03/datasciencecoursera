## Quiz 4

## 1. Consider the space shuttle data ?shuttle in the MASS library. Consider modeling the use of the autolander as the
# outcome (variable name use). Fit a logistic regression model with autolander (variable auto) use (labeled as "auto" 1)
# versus not (0) as predicted by wind sign (variable wind). Give the estimated odds ratio for autolander use comparing
# head winds, labeled as "head" in the variable headwind (numerator) to tail winds (denominator).
library(MASS)
data(shuttle)
## Make our own variables just for illustration
shuttle$auto <- 1 * (shuttle$use == "auto")
shuttle$headwind <- 1 * (shuttle$wind == "head")
fit <- glm(auto ~ headwind, data = shuttle, family = binomial)
exp(coef(fit))
## 0.9686888


## 2. Consider the previous problem. Give the estimated odds ratio for autolander use comparing head winds (numerator)
# to tail winds (denominator) adjusting for wind strength from the variable magn.
shuttle$auto <- 1 * (shuttle$use == "auto")
shuttle$headwind <- 1 * (shuttle$wind == "head")
fit2 <- glm(auto ~ headwind + magn, data = shuttle, family = binomial)
exp(coef(fit2))
## 0.9684981

## 3. If you fit a logistic regression model to a binary variable, for example use of the autolander, then fit a
# logistic regression model for one minus the outcome (not using the autolander) what happens to the coefficients?


## The coefficients reverse their signs.

## 4. Consider the insect spray data InsectSprays. Fit a Poisson model using spray as a factor level.
# Report the estimated relative rate comapring spray A (numerator) to spray B (denominator).íº™ðš›ðšŠðš¢ðšœ. Fit a Poisson model using spray as a factor level. Report the estimated relative rate comapring spray A (numerator) to spray B (denominator).
fit4 <- glm(count ~ relevel(spray, "B"), data = InsectSprays, family = poisson)
exp(coef(fit4))[2]
#fit4 <- glm(count ~ factor(spray) - 1, family = "poisson", data = InsectSprays)
#exp(coef(fit4))[1]/exp(coef(fit4))[2]

## 0.9456522

## 5. Consider a Poisson glm with an offset, t. So, for example, a model of the form glm(count ~ x + offset(t)), family=poisson)
# where x is a factor variable comparing a treatment (1) to a control (0) and t is the natural log of a monitoring time.
# What is impact of the coefficient for x if we fit the model glm(count ~ x + offset(t2), family=poisson)
# where 2 <- log(10) + t? In other words, what happens to the coefficients if we change the units of the offset variable.
# (Note, adding log(10), on the log scale is multiplying by 10 on the original scale. )
fit5 <- glm(count ~ factor(spray) + offset(log(rep(sum(count), length(count)))), family = "poisson", data = InsectSprays)
fit5_1 <- glm(count ~ factor(spray) + offset(log(10) + log(rep(sum(count), length(count)))), family = "poisson", data = InsectSprays)
coef(summary(fit5))
coef(summary(fit5_1))
## The coefficient estimate is unchanged

## 6. Consider the data
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
# Using a knot point at 0, fit a linear model that looks like a hockey stick with two lines meeting at x=0.
# Include an intercept term, x and the knot point term. What is the estimated slope of the line after 0?
z <- (x > 0) * x
fit <- lm(y ~ x + z)
sum(coef(fit)[2:3])

## 1.013067