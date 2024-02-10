library(tidyverse)

## Correlation
library(ggplot2)

cor(mtcars$mpg, mtcars$hp)
cor(mtcars$mpg, mtcars$wt)

plot(mtcars$hp, mtcars$mpg, pch=16)
plot(mtcars$wt, mtcars$mpg, pch=16)
plot(mtcars$wt, mtcars$hp, pch=16)

ggplot(mtcars, aes(hp, mpg)) + geom_point()
ggplot(mtcars, aes(wt, mpg)) + geom_point()
ggplot(mtcars, aes(wt, hp)) + geom_point()

cor(mtcars[ , c("mpg", "wt", "hp")])

# Dplyr (Tidyverse)
library(dplyr)
cormat <- mtcars %>% 
    select(mpg, wt, hp, am) %>%
    cor()

# Compute correlation (r) and significance test
cor(mtcars$mpg, mtcars$hp)
cor.test(mtcars$mpg, mtcars$hp)

## Linear Regression
# Simple linear regression
lmFit <- lm(mpg ~ hp, data = mtcars)

summary(lmFit)

# Prediction
lmFit$coefficients[[1]] + lmFit$coefficients[[2]] * 200

new_cars <- data.frame(
    hp = c(250, 320, 400, 410, 450)
)
new_cars <- tibble(
    hp = c(250, 320, 400, 410, 450)
)

# Predict
new_cars$hp_pred <- predict(lmFit, newdata = new_cars) #wrong column
new_cars$mpg_pred <- predict(lmFit, newdata = new_cars)
new_cars$hp_pred <- null #remove column
new_cars

summary(mtcars$hp)

# RMSE (Root Mean Squared Error)
# Multiple linear regression
# lm(ตัวแปรตาม ~ ตัวแปรต้น)
#mpg = f(hp, wt, am)
#mpg = intercept + b0*hp + b1*wt + b2*am
lmFit_v2 <- lm(mpg ~ hp + wt + am, data = mtcars)
coefs <- coef(lmFit_v2)
coefs[[1]] + coefs[[2]]*200 + coefs[[3]]*3.5 + coefs[[4]] * 1

## Build full model
lmFit_full <- lm(mpg ~ ., data = mtcars)
mtcars$predicted <- predict(lmFit_full)
head(mtcars)

## Train RMSE
squared_error <- (mtcars$mpg - mtcars$predicted) ** 2
(rmse <- sqrt(mean(squared_error))) 

## Randomly split Data
set.seed(42)
n <- nrow(mtcars)
id <- sample(1:n, size = n*0.7)
train_data <- mtcars[id, ]
test_data <- mtcars[-id, ]

# Train model
model1 <- lm(mpg ~ hp + wt + am +disp, data = train_data)
p_train <- predict(model1)
(rmse_train <- sqrt(mean((train_data$mpg - p_train) ** 2)))

# Test model
p_test <- predict(model1, newdata = test_data)
(rmse_test <- sqrt(mean((test_data$mpg - p_test) ** 2)))

# Print result
cat("RMSE of train data: ", rmse_train, 
    "\nRMSE of test data: ", rmse_test)

## Logistic regression
mtcars %>% head()

str(mtcars)

# Convert am to factor
mtcars$am <- factor(mtcars$am,
                    levels = c(0,1),
                    labels = c("Auto", "Manual"))
class(mtcars$am)
table(mtcars$am) #Crate frequency table

# Build model Logistic regression
# Randomly split Data
set.seed(42)
n <- nrow(mtcars)
id <- sample(1:n, size = n*0.7)
train_data <- mtcars[id, ]
test_data <- mtcars[-id, ]

# Train model
logit_model <- glm(am ~ mpg, 
                   data = train_data,
                   family = "binomial")
p_train <- predict(logit_model, type = "response") #probability
train_data$pred <- if_else(p_train >= 0.5, "Manual", "Auto")
mean(train_data$am == train_data$pred)

# Test model
p_test <- predict(logit_model, 
                  newdata = test_data,
                  type = "response") 
test_data$pred <- if_else(p_test >= 0.5, "Manual", "Auto")
mean(test_data$am == test_data$pred)