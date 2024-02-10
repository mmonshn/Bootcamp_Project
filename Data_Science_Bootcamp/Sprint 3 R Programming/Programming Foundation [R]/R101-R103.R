setwd("/cloud/project/R Programming")
getwd()

nums <- c(5,10,15,20,25,30)
deck <- read.csv("deck.csv")

friends <- c("mon", "drew", "ya", "boo")
ages <- c(20,17,14,22)
names(ages) <- friends

name_age <- function(name = "mon", age = 25){
  print( paste("Hello",name))
  print( paste("Age",age))
}

balls <- c("red", "green", "pink", "blue")
count_ball <- function(balls,color){
  sum(balls == color)
}

head(USArrests)
cal_mea_col <- function(df){
  for (i in 1:ncol(df)) {
    print( names(df[i]))
    print( mean(df[[i]]))
  }
}

# refactor our code for more readability
cal_mean_by_col <- function(df) {
  col_names <- names(df)
  
  for (i in 1:ncol(df)) {
    avg_col <- mean(df[[i]]) 
    print(paste(col_names[i], ":", avg_col))
  }
}
# test our code with mtcars
cal_mean_by_col(mtcars)
