## Logistic Regression Homework
library(titanic)

# Load tidyverse library
library(tidyverse)

# Load titanic train data set
# titanic_train

# Check column name
head(titanic_train)

# Drop NA (Clean Data)
titanic_train <- na.omit(titanic_train)

# Check column count
nrow(titanic_train)

# Check if value in 'Survived' column is factor or not
str(titanic_train$Survived)

# Change the value in 'Survived' column from int to factor
titanic_train$Survived <- factor(titanic_train$Survived,
                                 levels = c(0,1),
                                 labels = c("Not Survived",
                                            "Survived"))

# Split data
set.seed(42)
n <- nrow(titanic_train)
id <- sample(1:n, size = n * 0.7) #Train 70% Test 30%
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

# Train model
model <- glm(Survived ~ Pclass, 
             data = train_data,
             family = "binomial")

# Predict & evaluate train model
train_data$prob_survive <- predict(model, type = "response")
train_data$pred_survive <- if_else(train_data$prob_survive >= 0.7,
                                   1, 0)
summary(train_data)
conM <- table(train_data$pred_survive, train_data$Survived,
              dnn = c("Predicted", "Actual"))

# create Variables to store accuracy, precision, recall, and F1 for conM
acc_train <- conM[1, 1] + conM[2, 2] / sum(conM)
pre_train <- conM[2, 2] / ( conM[2, 1] + conM[2, 2] )
rec_train <- conM[2, 2] / ( conM[1, 2] + conM[2, 2] )
f1_train <- 2 * ( (pre_train * rec_train) / (pre_train + rec_train) )

# Show accuracy, precision, recall, and F1 for conM
cat("accuracy_train = ", acc_train,
    "\nprecision_train = ", pre_train,
    "\nrecall_train = ", rec_train,
    "\nf1_train (Harmonic Mean) = ", f1_train)

## Predict & evaluate test model 
test_data$prob_survive <- predict(model, 
                                  newdata = test_data,
                                  type = "response")
test_data$pred_survive <- if_else(test_data$prob_survive >= 0.7,
                                  1, 0)
summary(test_data)
conMtest <- table(test_data$pred_survive, test_data$Survived,
                  dnn = c("Predicted", "Actual"))

# create Variables to store accuracy, precision, recall, and F1 for conMtest
acc_test <- conMtest[1, 1] + conMtest[2, 2] / sum(conMtest) 
pre_test <- conMtest[2, 2] / ( conMtest[2, 1] + conMtest[2, 2]) 
rec_test <- conMtest[2, 2] / ( conMtest[1, 2] + conMtest[2, 2]) 
f1_test <- 2 * ( (pre_test * rec_test) / (pre_test + rec_test) )

# Show accuracy, precision, recall, and F1 for conMtest
cat("accuracy_test = ", acc_test,
    "\nprecision_test = ", pre_test,
    "\nrecall_test = ", rec_test,
    "\nf1_test (Harmonic Mean) = ", f1_test)

# Create data frame to store train and test parameters
titanic_logit_df <- data.frame(accuracy = c(acc_train, acc_test),
                               precision = c(pre_train, pre_test),
                               recall = c(rec_train, rec_test),
                               f1 = c(f1_train, f1_test),
                               row.names = c("train", "test"))

# export data frame as csv
write_csv(titanic_logit_df, "titanic_logit_test.csv")