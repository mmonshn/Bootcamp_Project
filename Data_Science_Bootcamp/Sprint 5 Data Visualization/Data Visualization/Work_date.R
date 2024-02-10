library(lubridate)
library(tidyverse)

## YYYY-MM-DD
date_df <- data.frame(
  x = c(
    "2023-02-25",
    "2023-02-26",
    "2023-02-27",
    "2023-02-28",
    "2023-03-01"
  )
)

date_df %>%
  mutate(date_x = ymd(x),
         year = year(date_x),
         month = month(date_x),
         day = day(date_x),
         wday = wday(date_x))

date_df %>%
  mutate(date_x = ymd(x),
         year = year(date_x),
         month = month(date_x, label=TRUE, abbr=FALSE),
         day = day(date_x),
         wday = wday(date_x, label=TRUE, abbr=FALSE),
         week = week(date_x))

ydm("2023..25..FEB")

## Excel default USA date
## MM/DD/YYYY
date_df <- data.frame(
  x = c(
    "02/25/2023",
    "02/26/2023",
    "02/27/2023",
    "02/28/2023",
    "03/01/2023"
  )
)

date_df %>%
  mutate(date_x = mdy(x),
         year = year(date_x),
         month = month(date_x, label=TRUE, abbr=FALSE),
         day = day(date_x),
         wday = wday(date_x, label=TRUE, abbr=FALSE),
         week = week(date_x))

convert_thai_to_eng_date <- function(year){
  return(year-543)
}

convert_thai_to_eng_date(2566)

## Excel default USA date
date_df <- data.frame(
  x = c(
    "Feb 2023 - 25",
    "Feb 2023 - 26",
    "Feb 2023 - 27",
    "Mar 2023 - 9",
    "April 2023 - 1")
) 

date_df %>%
  mutate(date_x = myd(x),
         year = year(date_x),
         month = month(date_x, label=TRUE, abbr=FALSE  ),
         day = day(date_x),
         wday = wday(date_x, label=TRUE, abbr=FALSE),
         week = week(date_x))