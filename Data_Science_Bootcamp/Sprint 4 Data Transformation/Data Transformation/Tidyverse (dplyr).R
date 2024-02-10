# Load Tidyverse, sqldf, and glue
library(tidyverse)
library(sqldf)
library(glue)

## Use glipmse, head, and tail to review(explore) data frame
# Glimpse = check data type in columns
glimpse(mtcars)
head(mtcars, 3)
tail(mtcars, 3)

## Run SQL query in R 
# You can assign the result of query to the variable
sqldf("SELECT * FROM mtcars WHERE mpg > 30")
df <- sqldf("SELECT mpg, wt, hp 
            FROM mtcars 
            WHERE wt < 2")
sqldf("SELECT am, avg(mpg), sum(mpg) 
      FROM mtcars
      GROUP BY am")

# Glue คือ การสร้าง String template
my_name = "Simon"
my_age = 21

glue("My name is {my_name} + I am {my_age} years old.")

## Dplyr = Data Transformation [Inspired by SQL]
# 1. Select
# 2. Filter
# 3. Mutate
# 4. Arrange
# 5. Summarize + group_by

# Select
select(mtcars, mpg, hp, wt, am)
select(mtcars, contains("a"))
select(mtcars, starts_with("a"))
select(mtcars, ends_with("p"))
select(mtcars, 1, 3, 5)
select(mtcars, 1:5, am)
select(mtcars, mpg:disp)

# %>% Pipe Operator
mtcars %>% 
  select(mpg, hp, wt)

# Select w/Pipe Operator
# Data Pipeline in R
car_mpg30_hp100 <- mtcars %>% 
  select(mpg, hp, wt) %>%
  filter(mpg > 30 & hp > 100) %>%
  rownames()

# Filter
mtcars %>% 
  select(mpg, hp, wt, am) %>%
  filter(mpg > 30 | am == 1) %>%
  filter(mpg < 20)

mtcars %>% 
  rownames_to_column() %>%
  select(model = rowname, 
         miles_per_gallon = mpg,
         horsepower = hp,
         weight = wt) %>%
  head()

mtcars <- mtcars %>% 
  rownames_to_column() %>%
  rename(model = rowname)

## Filter model names (Filter with condition)
# grepl(" ", Table$Column) ~ Regular Expression, แสดงผล: TRUE FALSE 
mtcars %>%
  select(model, mpg, hp, wt) %>%
  filter(grepl("^Me", model))

mtcars %>%
  select(model, mpg, hp, wt) %>%
  filter(grepl("n$", model))

# Mutate (Create new column)
df <- mtcars %>% 
  select(model, mpg, hp) %>%
  head() %>%
  mutate(mpg_double = mpg * 2,
         mpg_log = log(mpg),
         hp_double = hp * 2)

# Create Label (am 0 = Auto, 1 = Manual)
mtcars <- mtcars %>%
  mutate(am = ifelse(am == 0, "Auto", "Manual"))

# Arrange (Sort data)
mtcars %>% 
  select (model, mpg, am) %>%
  arrange(desc(mpg)) %>%
  head(10)

mtcars %>% 
  select (model, mpg, am) %>%
  arrange(am, desc(mpg)) %>%
  head(10)

# Create data frame from scratch
df <- data.frame(
  id = 1:5,
  country = c("Thailand", "Korea", "Japan", "Belgium", "USA")
)

# case_when, ~ , TRUE >> CASE WHEN THEN ELSE
df %>%
  mutate(region = case_when(
    country %in% c("Thailand", "Korea", "Japan") ~ "Asia",
    country == "USA" ~ "America",
    TRUE ~ "Other Regions"
  ))

# Append data frame
df2 <- data.frame(
  id = 6:8,
  country = c("Germany", "Italy", "Spain")
)

df3 <- data.frame(
  id = 9:10,
  country = c("Canada", "Malaysia")
)

full_df <- df %>% 
  bind_rows(df2) %>%
  bind_rows(df3)

list_df <- list(df, df2, df3)
full_df <- bind_rows(list_df)

# case when then else end in SQL
sqldf("select *, case 
            when country in ('USA', 'Canada') then 'America'
            when country in ('Thailand', 'Korea', 'Japan', 'Malaysia') then 'Asia'
            else 'Europe'
            end as region
            from full_df")

# case_when in R
full_df %>% 
  mutate(region = case_when(
    country %in% c("Thailand", "Korea", "Japan", "Malaysia") ~ "Asia",
    country %in% c("Canada", "USA") ~ "America",
    TRUE ~ "Europe"))

## Summarize + Group By
# Either summarize or summarise is OK
mtcars %>%
  group_by(am) %>%
  summarise(avg_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_mpg = max(mpg),
            n = n())

result <- mtcars %>% 
  mutate(vs = ifelse(vs==0, "v-shaped", "straight")) %>%
  group_by(am, vs) %>%
  summarise(avg_mpg = mean(mpg),
            sum_mpg = sum(mpg),
            min_mpg = min(mpg),
            max_mpg = max(mpg),
            n = n())
View(result)
write_csv(result, "result.csv")
df <- read_csv("result.csv")

# Missing Value (NA = Not Available)
v1 <- c(5, 10, 15, NA, 25)

# NA check by using is.na()
is.na(v1)

# Build data frame ใหม่อีกรอบ
data("mtcars")
mtcars[5, 1] <- NA

# Filter Missing Value or NA
mtcars %>% 
  filter(is.na(mpg))

# Filter complete case
mtcars %>% 
  select(mpg, hp, wt) %>%
  filter(!is.na(mpg))

## Filter mean NOT Missing Value
#1
mtcars %>%
  filter(!is.na(mpg)) %>%
  summarise(avg_mpg = mean(mpg))
#2
mtcars %>%
  summarise(avg_mpg = mean(mpg, na.rm = TRUE))

# Pull Value
mean_mpg <- mtcars %>% 
  summarise(mean(mpg, na.rm = TRUE)) %>%
  pull()

# Replace Missing Value
mtcars %>%
  select(mpg) %>%
  mutate(mpg2 = replace_na(mpg, mean_mpg))

# Looping over data frame
data(mtcars)
# For other programming language, use for loop
for(i in 1 : ncol(mtcars)) {
  print(mean(mtcars[[i]]))
}

## In R, using apply() to loop over data frame:
# Apply mean to all columns in mtcars
apply(mtcars, 2, mean)

apply(mtcars, 2, sum)

## JOIN data frame
# JOINs In SQL: INNER, LEFT, RIGHT, FULL
band_members #data frame
band_instruments #data frame

left_join(band_members, band_instruments, by = "name")
# %>%
band_members %>%
  left_join(band_instruments, by = "name")

band_members %>%
  inner_join(band_instruments, by = "name")

band_members %>%
  full_join(band_instruments, by = "name")

band_members %>%
  rename(member_name = name) -> band_members_2

band_members_2 %>%
  left_join(band_instruments, by = c("member_name" = "name"))

# Use larger library
library(nycflights13)

glimpse(flights)

flights %>% 
  filter(year == 2013 & month == 9) %>%
  count(carrier) %>%
  arrange(-n) %>% ##arrange(desc(n))
  head(5) %>%
  left_join(airlines, by = "carrier")

glimpse(airlines)
