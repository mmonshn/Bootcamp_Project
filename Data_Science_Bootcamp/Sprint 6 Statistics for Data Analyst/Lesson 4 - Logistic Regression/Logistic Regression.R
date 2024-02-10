## Logistic regression example (Binary Classification)
library(tidyverse)

happiness <- c(10, 8, 9, 7, 8,
               5, 9, 6, 8, 7,
               1, 1, 3, 1, 4,
               5, 6, 3, 2, 0)
divorce <- c(0, 0, 0, 0, 0,
             0, 0, 0, 0, 0,
             1, 1, 1, 1, 1,
             1, 1, 1, 1, 1)

df <- tibble(happiness, divorce)

# Fit logistic regression to full data set
# glm(ตัวแปรตาม ~ ตัวแปรต้น)
# ตัวแปรตาม = Dependent Variable
model <- glm(divorce ~ happiness, data = df, family = "binomial")

summary(model)

# Predict and evaluate model
df$prob_divorce <- predict(model, type = "response")
df$pred_divorce <- ifelse(df$prob_divorce >= 0.5, 1, 0)

# Confusion Matrix
conM <- table(df$pred_divorce, df$divorce,
              dnn = c("Predicted", "Actual"))

# Model Evaluation
cat("Accuracy =", conM[1, 1] + conM[2, 2] / sum(conM) )
cat("Precision =", conM[2, 2] / ( conM[2, 1] + conM[2, 2]) )
cat("Recall =", conM[2, 2] / ( conM[1, 2] + conM[2, 2]) )
cat("F1 =", 2 * ( (0.9 * 0.9) / (0.9 + 0.9) ) )