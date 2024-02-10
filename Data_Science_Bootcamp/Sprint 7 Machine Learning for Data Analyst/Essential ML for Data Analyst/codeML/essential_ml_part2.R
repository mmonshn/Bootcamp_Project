## mlbench rpart randomForest class glmnet

## load library
library(caret)
library(tidyverse)
library(mlbench)
library(MLmetrics)

# see available data
data()

# load dataset for regression
data(BostonHousing)
df_bh <- BostonHousing
glimpse(df_bh)

# clustering => segmentation
sub_bh <- df_bh %>%
    select(crim, rm, age, lstat, medv) %>%
    as_tibble()

# test different k (2-5)
result_bh <- kmeans(x = sub_bh, centers = 3)
# k = number of cluster
# mean = mean in each cluster

# membership [1, 2, 3]
sub_bh$cluster <- result_bh$cluster

## -----------------------------------------
## lm, knn
df_bh_tib <- as_tibble(df_bh)

## 1.split data
set.seed(42)
n <- nrow(df_bh_tib)
id <- sample(1:n, size = 0.8*n)
train_data <- df_bh_tib[id, ]
test_data <- df_bh_tib[-id, ]

## 2. train model
# medv = f(crim, rm, age)
lm_model <- train(medv ~ crim + rm + age,
                  data = train_data,
                  method = "lm",
                  preProcess = c("center", "scale"))

set.seed(42)
ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = TRUE)

# grid search tune hyperparameters
# for tune hyperparameter
k_grid <- data.frame(k = c(3,5,7,9,11))

(knn_model <- train(medv ~ crim + rm + age,
                   data = train_data,
                   method = "knn",
                   metric = "Rsquared",
                   tuneGrid = k_grid,
                   preProcess = c("center", "scale"),
                   trControl = ctrl))

# tuneLength random search
(knn_model_rs <- train(medv ~ crim + rm + age,
                   data = train_data,
                   method = "knn",
                   metric = "Rsquared",
                   tuneLength = 5,
                   preProcess = c("center", "scale"),
                   trControl = ctrl))

## 3.score
p <- predict(knn_model, newdata = test_data)

## 4.evaluate
rmse <- sqrt(mean((p - test_data$medv)**2))
RMSE(p, test_data$medv)

## --------------------------------------
## classification problem
# load dataset for classification
library(forcats)

data("PimaIndiansDiabetes")
df_pid <- PimaIndiansDiabetes
glimpse(df_pid)

# จะ predict class ไหนเป็นหลักใช้ fct_relevel() จะ focus level นั้น
# from library(forcats)
df_pid$diabetes <- fct_relevel(df_pid$diabetes, "pos")

df_pid_tib <- df_pid %>% 
  select(glucose, insulin, age, diabetes) %>%
  as_tibble(df_pid)
glimpse(df_pid_tib)

## 1.split data
set.seed(42)
n <- nrow(df_pid_tib)
id <- sample(1:n, size = 0.8*n)
train_data <- df_pid_tib[id, ]
test_data <- df_pid_tib[-id, ]

## 2.train model
set.seed(42)
ctrl_pid <- trainControl(method = "cv",
                         number = 5,
                         verboseIter = TRUE,
                         summaryFunction = twoClassSummary,
                         classProbs = TRUE)

(knn_model_pid <- train(diabetes ~ ., 
                       data = train_data, 
                       method = "knn",
                       metric = "ROC", # Recall
                       preProcess = c("center", "scale"),
                       trControl = ctrl_pid))
# AUC = Area Under The Curve

## 3.score
p_pid <- predict(knn_model_pid, newdata = test_data)

## 4.evaluate
table(test_data$diabetes, p_pid,
      dnn = c("Actual",
              "Prediction"))
confusionMatrix(p_pid, test_data$diabetes, 
                positive = "pos",
                mode = "prec_recall")

# -------------------------------------------------
## Logistic Regression
set.seed(42)

ctrl_pid_glm <- trainControl(method = "cv",
                             number = 5,
                             verboseIter = TRUE)

(glm_model_pid <- train(diabetes ~ ., 
                       data = train_data, 
                       method = "glm",
                       metric = "Accuracy",
                       trControl = ctrl_pid_glm))

# -------------------------------------------------
## Decision Tree (rpart) 
library(rpart.plot)

(tree_model_pid <- train(diabetes ~ .,
                    data = train_data,
                    method = "rpart",
                    metric = "Accuracy", 
                    trControl = ctrl))

rpart.plot(tree_model$finalModel)

# -------------------------------------------------
## Random Forest 
# Model accuracy the higest >= 76%

# mtry = number of features used to train model
# bootstrap sampling

# bagging technique
mtry_grid <- data.frame(mtry = 2:8)

(ran_tree_model_pid <- train(diabetes ~ .,
                     data = train_data,
                     method = "rf",
                     metric = "Accuracy", 
                     tuneGrid = mtry_grid,
                     trControl = ctrl))

## --------------------------------------------
## ridge vs. lasso regression
library(glmnet)

# 0=Ridge, 1=Lasso
glmnet_grid <- expand.grid(alpha = 0:1,
                          lambda = c(0.1, 0.2, 0.3))

(glmnet_model_pid <- train(diabetes ~ .,
                   data = train_data,
                   method = "glmnet",
                   metric = "Accuracy", 
                   tuneLength = 10,
                   trControl = ctrl))
## ----------------------------------------------
## compare models 

list_models <- list(knn = knn_model_pid,
                    logistic = glm_model_pid,
                    decisionTree = tree_model_pid,
                    randomForest = ran_tree_model_pid)

result_list_model <- resamples(list_models)

summary(result_list_model)
modelCor(result_list_model)

## ----------------------------------------------
## Save our models for later use
saveRDS(model, "model.rds")
model <- readRDS("model.rds")
