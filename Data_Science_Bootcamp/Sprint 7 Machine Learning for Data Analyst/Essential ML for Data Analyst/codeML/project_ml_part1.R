# Load library
library(tidyverse)
library(caret)
library(readxl)

# Load dataset
ds <- read_excel("House Price India.xlsx")
glimpse(ds)
View(ds)

# Visual for check
ds %>% 
    ggplot(mapping = aes(x = Price)) +
    geom_histogram(bin = 15, 
                   fill = "blue",
                   alpha = 0.5)

# Log Price for normal distribution
ds_log_price <- ds %>% 
    mutate(log_price = log(Price + 1))

glimpse(ds_log_price)
View(ds_log_price)

ds_log_price %>% 
    ggplot(mapping = aes(x = log_price)) +
    geom_histogram(bin = 15, 
                   fill = "blue",
                   alpha = 0.5)

# Rename for easily use
ds_clean <- ds_log_price %>%
    rename("date" = "Date",
           "number_of_bedrooms" = "number of bedrooms",
           "number_of_bathrooms" = "number of bathrooms",
           "living_area" = "living area",
           "lot_area" = "lot area",
           "number_of_floors" = "number of floors",
           "waterfront_present" = "waterfront present",
           "number_of_views" = "number of views",
           "condition_of_the_house" = "condition of the house",
           "grade_of_the_house" = "grade of the house",
           "area_of_the_house(excluding basement)" = "Area of the house(excluding basement)",
           "area_of_the_basement" = "Area of the basement",
           "built_year" = "Built Year",
           "renovation_year" = "Renovation Year",
           "postal_code" = "Postal Code",
           "lattitude" = "Lattitude",
           "longitude" = "Longitude",
           "number_of_schools_nearby" = "Number of schools nearby",
           "distance_from_the_airport" = "Distance from the airport",
           "price" = "Price")

# ML
# split data 70:30
glimpse(ds_clean)

train_test_split <- function(data, trainRatio=0.7) {
    set.seed(48)
    n <- nrow(data)
    id <- sample(1:n, trainRatio*n)
    train_data <- data[id, ]
    test_data <- data[-id, ]
    list(train = train_data, test = test_data)
}

set.seed(48)
splitData <- train_test_split(ds_clean, 0.7)
train_data <- splitData$train
test_data <- splitData$test

# train
ctrl <- trainControl(
    method = "cv", # K-fold golden standard
    number = 5,
    verboseIter = TRUE # print log
)

lm_model <- train(log_price ~  number_of_bedrooms +
                      number_of_bathrooms +
                      living_area +
                      lot_area +
                      number_of_floors +
                      condition_of_the_house +
                      grade_of_the_house,
                  data = train_data,
                  method = "lm",
                  trControl = ctrl)

# score
p <- predict(lm_model, newdata = test_data)

# evaluate
mae_metric <- function(actual, prediction) {
    abs_error <- abs(actual - prediction)
    mean(abs_error)
}

mse_metric <- function(actual, prediction) {
    sq_error <- (actual - prediction)**2
    mean(sq_error)
}

rmse_metric <- function(actual, prediction) {
    sq_error <- (actual - prediction)**2
    sqrt(mean(sq_error))
}

mae_metric(test_data$log_price, p)
mse_metric(test_data$log_price, p)
rmse_metric(test_data$log_price, p)