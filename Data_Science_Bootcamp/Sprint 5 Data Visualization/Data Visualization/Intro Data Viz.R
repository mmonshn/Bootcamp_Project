library(tidyverse)
## Data Visualization
## base R visualization
plot(mtcars$mpg, mtcars$hp, pch=16, col='red')

boxplot(mtcars$mpg)

t1 <- table(mtcars$am)
barplot(t1)

hist(mtcars$mpg)

## ggplot => grammar of graphic
## One variable, numeric
ggplot(data = mtcars, mapping = aes(x=mpg)) +
  geom_histogram(bins=10)

ggplot(data = mtcars, mapping = aes(x=mpg)) +
  geom_density()

ggplot(data = mtcars, mapping = aes(x=mpg)) +
  geom_freqpoly()

p1 <- ggplot(mtcars, aes(mpg)) +
  geom_histogram(bins=5)

p2 <- ggplot(mtcars, aes(hp)) +
  geom_histogram(bins=10)

mtcars %>%
  filter(hp <= 200) %>%
  count()

mtcars %>%
  count(am)

## summary table before make bar chart
t2 <- mtcars %>%
  mutate(am = ifelse(am==0, "Auto", "Manual")) %>%
  count(am)
# approach 01 - summary table + geom_col()
ggplot(t2, aes(am, n)) +
  geom_col()
# approach 02 - geom_bar()
ggplot(mtcars, aes(am)) +
  geom_bar()

# Together
mtcars %>%
  mutate(am = ifelse(am==0, "Auto", "Manual")) %>%
  count(am) %>%
  ggplot(aes(am, n)) +
  geom_col()

## Two variables, numeric
## scatter plot
ggplot(mtcars, aes(hp, mpg)) +
  geom_point(col='red', size=5) #setting

## ordinal factor
temp <- c("high", "med", "low", "high")
temp <- factor(temp, levels = c("low", "med", "high"), ordered = TRUE)

## categorical factor
gender <- c("m", "f", "m")
gender <- factor(gender)

## data frame => diamonds
glimpse(diamonds)

diamonds %>%
  count(cut, color, clarity)

## Sample
set.seed(99)
diamonds %>%
  sample_n(5)

diamonds %>%
  sample_frac(0.1) # 10% Data

diamonds %>%
  slice(1:5)

diamonds %>%
  slice(50300,)

## relationship (pattern)
p3 <- ggplot(diamonds %>% sample_n(1000) , aes(carat, price)) +
  geom_point() +
  geom_smooth(method = "loess") +
  geom_rug()

## setting vs. mapping
colors()
# setting
ggplot(diamonds, aes(price)) +
  geom_histogram(bins=100, fill="salmon", col="#2585f9")

ggplot(diamonds %>% sample_n(500), 
       aes(carat, price)) +
  geom_point(size=5, alpha=0.2, col="red")

# mapping
ggplot(diamonds %>% sample_n(500), 
       mapping = aes(carat, price, col =cut)) +
  geom_point(size=5, alpha=0.5) + 
  theme_minimal() +
  labs(
    title = "Relationship carat and price",
    x = "Carat",
    y = "Price USD",
    subtitle = "We found a positive relationship",
    caption = "Datasource: Diamonds ggplot2"
  ) +
  scale_color_manual(values = c(
    "red", "green", "blue", "gold", "salmon"
  ))

ggplot(diamonds %>% sample_n(500), 
       mapping = aes(carat, price, col =cut)) +
  geom_point(size=5, alpha=0.5) + 
  theme_minimal() +
  labs(
    title = "Relationship carat and price",
    x = "Carat",
    y = "Price USD",
    subtitle = "We found a positive relationship",
    caption = "Datasource: Diamonds ggplot2"
  ) +
  scale_color_brewer(type="qual", palette = 2)

## map color scale
ggplot(mtcars, mapping = aes(hp, mpg, col=wt)) +
  geom_point(size=5, alpha=0.7) +
  theme_minimal() +
  scale_color_gradient(low="gold", high="purple")

## facet
ggplot(diamonds %>% sample_n(5000), aes(carat, price)) +
  geom_point(alpha=0.3) +
  geom_smooth(col="red",fill="gold") +
  theme_minimal() +
  facet_wrap( ~cut, ncol=3)

ggplot(diamonds %>% sample_n(5000), aes(carat, price)) +
  geom_point(alpha=0.3) +
  geom_smooth(col="red") +
  theme_minimal() +
  facet_grid( ~cut ~color)

## combine charts
library(patchwork)
library(ggplot2)

p1 <- qplot(mpg, data=mtcars, geom = "histogram", bins=10)
p2 <- qplot(hp, mpg, data=mtcars, geom = "point")
p3 <- qplot(hp, data=mtcars, geom = "density")

## quick plot
p1 + p2 + p3
p1 + p2 / p3
(p1+p2) / p3
(p1 + p2 + p3) / p4

## Document Homework
library(rmarkdown)
