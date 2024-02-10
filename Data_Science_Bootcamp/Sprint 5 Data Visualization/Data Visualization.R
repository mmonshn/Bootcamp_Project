# Get working directory
getwd()

# Library tidyverse
library(tidyverse)

# Basic plot in Base R 
# Histogram
hist(mtcars$mpg)

# Analyzing horse power
# Histogram - One Quantitative Variable
hist(mtcars$hp)
mean(mtcars$hp)
median(mtcars$hp)

# Change num -> factor
str(mtcars)
mtcars$am <- factor(mtcars$am,
                    levels = c(0,1),
                    labels = c("Auto", "Manual"))

# Bar Plot - One Qualitative Variable
barplot(table(mtcars$am))

# Box Plot
boxplot(mtcars$hp)
fivenum(mtcars$hp)

min(mtcars$hp)
quantile(mtcars$hp, probs = c(0.25, 0.5, 0.75))
max(mtcars$hp)

# Whisker Calculation
Q3 <- quantile(mtcars$hp, probs = 0.75)
Q1 <- quantile(mtcars$hp, probs = 0.25)
IQR_HP <- Q3 - Q1

Q3 + 1.5 * IQR_HP
Q1 + 1.5 * IQR_HP

boxplot.stats(mtcars$hp, coef = 1.5)

# Filter Outliers
mtcars_no_out <- mtcars %>%
    filter (hp < 335)
boxplot(mtcars_no_out$hp)

# Boxplot 2 Variables
# Qualitative(เชิงคุณภาพ) X Quantitative(เชิงปริมาณ)
boxplot(mpg ~ am, 
        data = mtcars,
        col = c("gold","salmon"))

# How to restore dataframe
data(mtcars)

# Scatterplot
# 2 X Quantitative
plot(mtcars$hp,
     mtcars$mpg,
     pch = 16,
     col = c("red","blue"),
     main = "My first scatter plot",
     xlab = "Horsepower",
     ylab = "Miles per Gallon")
cor(mtcars$hp, mtcars$mpg) #ต้องได้ค่าติดลบ
lm(mpg ~ hp, data = mtcars)

## ggplot2
# Library tidyverse
library(tidyverse)

# Our very first plot in ggplot2
ggplot(data = mtcars,
       mapping = aes(x = hp, y = mpg)) + 
    geom_point() +
    geom_smooth() +
    geom_rug()

# Simpler:
ggplot(mtcars,
       aes(hp, mpg)) + geom_point(size = 3,
                                  col = "blue",
                                  alpha = 0.5) #ความจาง 0-1

# Histogram with ggplot2 (default bin = 30)
ggplot(mtcars,
       aes(hp)) + geom_histogram(bins = 10,
                                 fill = "salmon",
                                 alpha = 0.7)

# boxplot
ggplot(mtcars,
       aes(hp)) + geom_boxplot()

p <- ggplot(mtcars, aes(hp))
p + geom_histogram(bins = 10)
p + geom_density()

# Box plot by groups
diamonds %>% count(cut)
ggplot(diamonds,
       aes(cut)) + geom_bar(fill = "#0366fc")

ggplot(diamonds,
       aes(cut, fill = color)) + geom_bar(position = "stack")

ggplot(diamonds,
       aes(cut, fill = color)) + geom_bar(position = "dodge")

ggplot(diamonds,
       aes(cut, fill = color)) + geom_bar(position = "fill")

# Scatter Plot
set.seed(99)
smol_diamonds <- sample_n(diamonds, 5000)

ggplot(smol_diamonds,
       aes(carat, price)) + geom_point()

# Facet: Small Multiples
ggplot(smol_diamonds,
       aes(carat, price)) + 
    geom_point() + 
    geom_smooth(method = "lm", col = "red") +
    facet_wrap(~color, ncol = 2) +
    theme_minimal() +
    labs(title = "Relationship between carat and price by colour",
         x = "Carat",
         y = "Price USD",
         caption = "Source: Diamonds from ggplot2 package")

# Final Example:
ggplot(smol_diamonds,
       aes(carat, price, col = cut)) + 
    geom_point() + 
    facet_wrap(~color, ncol = 2) +
    theme_minimal()