# Question 1
#There will be an object called 'iris' in your workspace. In this dataset, what is the mean of 'Sepal.Length' 
# for the species virginica? Please round your answer to the nearest whole number!!!
library(datasets)
data(iris)
round(mean(iris$Sepal.Length[iris$Species=="virginica"]))

# Question 2
# Continuing with the 'iris' dataset from the previous Question, what R code returns a vector 
# of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?
apply(iris[, 1:4], 2, mean)

# Question 3
# How can one calculate the average miles per gallon (mpg) 
# by number of cylinders in the car (cyl)? Select all that apply.
library(datasets)
data(mtcars)

with(mtcars, tapply(mpg, cyl, mean))
sapply(split(mtcars$mpg, mtcars$cyl), mean)
tapply(mtcars$mpg, mtcars$cyl, mean)

# Question 4
# Continuing with the 'mtcars' dataset from the previous Question, what is the absolute difference 
# between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars?
avg_by_cyl <- tapply(mtcars$hp, mtcars$cyl, mean)
abs(round(avg_by_cyl[3] - avg_by_cyl[1]))

# Question 5
# If you run debug(ls) what happens when you next call the 'ls' function?
# Ans: Execution of 'ls' will suspend at the beginning of the function and you will be in the browser.

