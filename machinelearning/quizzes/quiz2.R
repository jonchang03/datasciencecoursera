## Quiz 2
library(caret)
library(AppliedPredictiveModeling)
library(Hmisc)
library(ggplot2)

# 1. Which of the following commands will create non-overlapping training and test sets with about 50%
# of the observations assigned to each?
data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

# for 2-3
data(concrete)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

# 2. Make a plot of the outcome (CompressiveStrength) versus the index of the samples. Color by each of the variables
# in the data set (you may find the cut2() function in the Hmisc package useful for turning continuous covariates
# into factors). What do you notice in these plots?

# use this example to print plots to pdf file where each page is a separate plot
# http://stackoverflow.com/questions/26034177/r-saving-multiple-ggplots-using-a-for-loop
names_list <- names(training)
pdf(file = "CompressiveStrength.pdf")
for (var in names_list) {
    print(qplot(x = 1:length(inTrain), y = CompressiveStrength, data = training, color = cut2(training[[var]],g=4), main=var))
}
dev.off()

# If the data were strongly correlated with any variable, we could expect that each step would mostly be colored by one
# cut for that variable, similar to the cutCompressiveStrength plot. This colour pattern is to be expected, because
# of course the CompressiveStrength would correlate strongly with itself. This is not the case for any of the varibales,
# however, and we have coloured all of them. We conclude that a variable may be missing.

##  There is a non-random pattern in the plot of the outcome versus index that does not appear to be perfectly explained by any predictor suggesting a variable may be missing.

# 3. Make a histogram and confirm the SuperPlasticizer variable is skewed.
# Normally you might use the log transform to try to make the data more symmetric.
# Why would that be a poor choice for this variable?

hist(training$Superplasticizer, breaks=15)

## There are values of zero so when you take the log() transform those values will be -Inf.

# for 4-5
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# 4. Find all the predictor variables in the training set that begin with IL. Perform principal components on
# these variables with the preProcess() function from the caret package. Calculate the number of principal components
# needed to capture 90% of the variance. How many are there?
inds<-grep(pattern = "^IL", x = names(training))
names(training)[inds]
preProc <- preProcess(x=training[,inds], method="pca", thresh = 0.9)
preProc
## 9

# 5. Create a training data set consisting of only the predictors with variable names beginning with IL and the
# diagnosis. Build two predictive models, one using the predictors as they are and one using PCA with principal
# components explaining 80% of the variance in the predictors. Use method="glm" in the train function.

# What is the accuracy of each method in the test set? Which is more accurate?

trainSubset = training[,grep("^IL", names(training))]
testSubset = testing[,grep("^IL", names(testing))]
pp = preProcess(trainSubset, thresh = 0.8, method = "pca")
trainTransformed <- predict(pp, trainSubset)
testTransformed <- predict(pp, testSubset)
trainSubset$diagnosis = training$diagnosis
testSubset$diagnosis = testing$diagnosis
trainTransformed$diagnosis = training$diagnosis
testTransformed$diagnosis = testing$diagnosis
glmpca = train(diagnosis ~ ., data = trainTransformed, method = "glm")
glm = train(diagnosis ~ ., data = trainSubset, method = "glm")
round(confusionMatrix(testSubset$diagnosis,predict(glm, testSubset))$overall["Accuracy"],2)
round(confusionMatrix(testTransformed$diagnosis,predict(glmpca, testTransformed))$overall["Accuracy"],2)