## Quiz 4
library(AppliedPredictiveModeling)
library(caret)
library(ElemStatLearn)
library(pgmm)
library(rpart)
library(gbm)
library(lubridate)
library(forecast)
library(e1071)

# ## 1. Load the vowel.train and vowel.test data sets:
# data(vowel.train)
# data(vowel.test)
# # Set the variable y to be a factor variable in both the training and test set. Then set the seed to 33833.
# # Fit (1) a random forest predictor relating the factor variable y to the remaining variables and (2) a boosted predictor
# # using the "gbm" method. Fit these both with the train() command in the caret package.
# vowel.train$y <- as.factor(vowel.train$y)
# vowel.test$y <- as.factor(vowel.test$y)
# set.seed(33833)
# modRF <- train(y ~ ., data = vowel.train, method="rf") # 1
# modGBM <- train(y ~., data=vowel.train, method="gbm") # 2
# # What are the accuracies for the two approaches on the test data set? What is the accuracy among the test set samples
# # where the two methods agree?
# predRF <- predict(modRF, vowel.test)
# predGBM <- predict(modGBM, vowel.test)
# RF_accuracy <- confusionMatrix(vowel.test$y, predRF)$overall["Accuracy"] # 0.6147186
# GBM_accuracy <- confusionMatrix(vowel.test$y, predGBM)$overall["Accuracy"] # 0.5367965
# equalPredictions <- (predRF == predGBM)
# Agreed_accuracy <- confusionMatrix(vowel.test$y[equalPredictions], predRF[equalPredictions])$overall["Accuracy"] # 0.6656051
#
# ## Closest Answer:
# ## RF Accuracy = 0.6082
# ## GBM Accuracy = 0.5152
# ## Agreement Accuracy = 0.6361
#
# ## 2. Load the Alzheimer's data using the following commands
# set.seed(3433)
# data(AlzheimerDisease)
# adData = data.frame(diagnosis,predictors)
# inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
# training = adData[ inTrain,]
# testing = adData[-inTrain,]
#
# # Set the seed to 62433 and predict diagnosis with all the other variables using a random forest ("rf"),
# # boosted trees ("gbm") and linear discriminant analysis ("lda") model. Stack the predictions together using
# # random forests ("rf"). What is the resulting accuracy on the test set?
# # Is it better or worse than each of the individual predictions?
#
# # individual predictions
# set.seed(62433)
# modRF <- train(diagnosis ~ ., method="rf", data=training)
# modGBM <- train(diagnosis ~ ., method="gbm", data=training)
# modLDA <- train(diagnosis ~ ., method="lda", data=training)
# predRF <- predict(modRF, testing)
# predGBM <- predict(modGBM, testing)
# predLDA <- predict(modLDA, testing)
#
# # model that combines predictors
# predComb <- data.frame(predRF, predGBM, predLDA, diagnosis=testing$diagnosis)
# combModFit <- train(diagnosis ~ ., method="rf", data=predComb)
# combPred <- predict(combModFit, testing)
#
# # Compute accuracies
# RF_accuracy <- confusionMatrix(predRF, testing$diagnosis)$overall["Accuracy"] # 0.7682927
# GBM_accuracy <- confusionMatrix(predGBM, testing$diagnosis)$overall["Accuracy"] # 0.7926829
# LDA_accuracy <- confusionMatrix(predLDA, testing$diagnosis)$overall["Accuracy"] # 0.7682927
# Stacked_accuracy <- confusionMatrix(combPred, testing$diagnosis)$overall["Accuracy"] # 0.804878
# ## Stacked Accuracy: 0.79 is better than random forests and lda and the same as boosting.
#
# ## 3. Load the concrete data with the commands:
# set.seed(3523)
# data(concrete)
# inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
# training = concrete[ inTrain,]
# testing = concrete[-inTrain,]
#
# # Set the seed to 233 and fit a lasso model to predict Compressive Strength. Which variable is the last coefficient
# # to be set to zero as the penalty increases? (Hint: it may be useful to look up ?plot.enet).
# set.seed(233)
# modLasso <- train(CompressiveStrength ~ ., method="lasso", data=training)
# plot.enet(modLasso$finalModel, xvar="penalty", use.color=TRUE)
# ## Cement
#
# ## 4. Load the data on the number of visitors to the instructors blog from here:
# if(!file.exists("data")) {dir.create("data")}
# fileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv"
# download.file(fileUrl, destfile = "./data/gaData.csv", method = "curl")
# dat <- read.csv("./data/gaData.csv")
# training = dat[year(dat$date) < 2012,]
# testing = dat[(year(dat$date)) > 2011,]
# tstrain = ts(training$visitsTumblr)
#
# # Fit a model using the bats() function in the forecast package to the training time series. Then forecast this model
# # for the remaining time points. For how many of the testing points is the true value within the 95% prediction interval
# # bounds?
#
# modTS <- bats(tstrain)
# fcast <- forecast(modTS, level=95, h = length(testing$visitsTumblr))
# sum(fcast$lower < testing$visitsTumblr & testing$visitsTumblr < fcast$upper)/length(testing$visitsTumblr)
# ## 0.9617021
#
# ## 5. Load the concrete data with the commands:
# set.seed(3523)
# data(concrete)
# inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
# training = concrete[ inTrain,]
# testing = concrete[-inTrain,]
#
# # Set the seed to 325 and fit a support vector machine using the e1071 package to predict Compressive Strength using
# # the default settings. Predict on the testing set. What is the RMSE?
# set.seed(325)
# modSVM <- svm(CompressiveStrength ~ ., data=training)
# predSVM <- predict(modSVM, testing)
# accuracy(predSVM, testing$CompressiveStrength)
# ## 6.715009


