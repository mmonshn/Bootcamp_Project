library(tidyverse)
library(caret)

# train test split
# 1. split data
# 2. train
# 3. score
# 4. evaluate

glimpse(mtcars)

# split 80:20
train_test_split <- function(data, trainRatio=0.7) {
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, trainRatio*n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  list(train = train_data, test = test_data)
}

set.seed(42)
splitData <- train_test_split(mtcars, 0.8)
train_data <- splitData$train
test_data <- splitData$test

# train model
model <- lm(mpg ~ hp + wt + am, data = train_data)
# score model
mpg_pred <- predict(model, newdata = test_data)

# evaluate model
# MAE, MSE, RMSE

mae_metric <- function(actual, prediction) {
  # mean absolute error
  # mae treats every data point the same
  abs_error <- abs(actual - prediction)
  mean(abs_error)
}

mse_metric <- function(actual, prediction) {
  # mean squared error
  # mse treats ตัวที่ทายผิดเยอะๆ มากกว่า
  sq_error <- (actual - prediction)**2
  mean(sq_error)
}

rmse_metric <- function(actual, prediction) {
  # root mean squared error
  sq_error <- (actual - prediction)**2
  sqrt(mean(sq_error))
  # ถอด root เพื่อให้กลับมาเป็นค่าเดิมจากค่าที่ยกกำลัง 2
}

# Caret = Classification and Regression Tree
# Supervised Learning = Prediction
# experimentation

# train test split
# 1. split data 70:30
splitData <- train_test_split(mtcars, 0.7)
train_data <- splitData[[1]]
test_data <- splitData[[2]]

# 2. train
# mpg = f(hp, wt, am)
set.seed(42)

ctrl <- trainControl(
  # method = "LOOCV", # leave one out CV
  # method = "boot", # bootstrap
  # number = 100,
  method = "cv", # K-fold golden standard
  number = 5, # k = 5
  verboseIter = TRUE # print log ที่ train
)

lm_model <- train(mpg ~ hp + wt + am, 
                  data = train_data,
                  method = "lm", # algorithm
                  trControl = ctrl)

rf_model <- train(mpg ~ hp + wt + am, 
                  data = train_data,
                  method = "rf",
                  trControl = ctrl)

knn_model <- train(mpg ~ hp + wt + am, 
                   data = train_data,
                   method = "knn",
                   trControl = ctrl)

# 3. score
p <- predict(model, newdata = test_data)

# 4. evaluate
rmse_metric(test_data$mpg, p)

# 5. save model
saveRDS(model, "linear_regression_v1.RDS")

# other laptop
# read model into R enviroment
new_cars <- data.frame(
  hp = c(150,200,250),
  wt = c(1.25,2.2,2.5),
  am = c(0,1,1)
)

model <- readRDS("linear_regression_v1.RDS")

new_cars$mpg_pred <- predict(model, newdata=new_cars)
View(new_cars)
