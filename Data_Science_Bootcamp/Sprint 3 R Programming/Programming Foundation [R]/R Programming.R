## Basic Calculation
1+1
2*2
3*5
5/2
6-2
5%%2 # mod
log(5)
exp(2)
abs(-10)
2**5

# R case sensitive
# Basic knowledge of Programming Languages ทุกภาษาจะแบ่งได้เป็น 5 เรื่อง
# 1. Variables
# 2. Data Types
# 3. Data Structures
# 4. Control Flow [if, for, while]
# 5. Functions

income <- 28000
expense <- 19500
saving <- income - expense

# rm() remove variable
rm(income)
rm(expense)
rm(saving)

# Data Types
# 1. numeric
# 2. character(text)
# 3. date
# 4. logical (TRUE, FALSE)
my_age <- 20
my_name <- "Mon"
movie_love <- TRUE

class(my_age)
class(my_name)
class(movie_love)

is.numeric(my_age)
is.character(my_name)
is.logical(movie_love)

# YYYY-MM-DD
wantee <- "2023-02-04"
wantee <- as.Date(wantee)

# Data Structures
# 1. vector
# 2. matrix
# 3. list
# 4. data.frame

# 1.vector collect only ONE data type
friends <- c("mon","newjeans","toy","boo")
length(friends)
friends[1]
friends[1:2]
friends[c(1,4)]
friends[2] <- "Data Rockie"
friends[c(1,4)] <- c("A","B")
friends == "newjeans"
which(friends == "newjeans")

# 2.matrix, vector 2 dimension
?matrix
help(matrix)
m1 <- matrix(1:6, ncol=2, byrow = TRUE)
m2 <- matrix(c(5,10,15,20,25,30), ncol=3, byrow = TRUE)
# element wise computation
## vectorization
m <- 1:6 * 3
m*2
m*m1
dim(m2) <- c(3,2)
m2

# 3.list
# can collect multiple data types /object
## key = value
my_playlist <- list(
  fav_movie = c("The Dark Knight" ,"Marvel"),
  fav_song = c("OMG", "Ditto", "Attention"),
  fav_artist = "NewJeans",
  year = 2000,
  movie_lover = TRUE,
  my_fav_matrix = matrix(1:10, ncol=5)
)
my_playlist$fav_movie
my_playlist[2]
my_playlist[[2]]
my_playlist$fav_song[2]
my_playlist[[1]][2]

## customer database for our company
customer_01 <- list(
  name = "toy",
  location = "BKK",
  age = 34,
  movise = c("John Wick", "Dark Knight")
)

customer_02 <- list(
  name = "John",
  lname = "Wick",
  age = 42,
  movise = c("John Wick 4"),
  fav_weapon = "A Pencil"
)

customer_db <- list(
  toy = customer_01,
  john = customer_02
)

customer_db$toy$movise
names(customer_db$john)
names(customer_db)

# 4.data.frame
## table in google sheets /sql database
data()
mtcars
View(mtcars) # built-in data frame

# create a new data frame
c("toy", "jisoo", "lisa", "rose", "jenny") -> friends
ages <- c(34, 25 ,27, 26, 28)
movie_lover <- c(F, F, T, F, T)

df1 <- data.frame(id = 1:5,
  friend = friends, 
  age = ages, 
  movie_love = movie_lover
)
View(df1)

# altarative approach to crate data frame in R
customers <- list(
  friends = c("John", "David", "Anna"),
  ages = c(25, 20, 19),
  movie = c(T, T, F)
)

df2 <- data.frame(customers)
View(df2)

# (Not Available) NA == NULL in SQL
x <- c(30, 29, 22, NA, 25)
is.na(x)
sum(is.na(x))

# ชื่อ Table[row, column]
df1[ , 2:3]
df1[ , c("id", "friend", "movie_love")]
df1[1, 2] <- "NewJeans"
lisa_index <- which(df1$friend == "lisa")
df1[lisa_index, "friend"] <- "LISA"

## NOT in R !
## AND in R &
## OR in R  |
df1$age < 30
df1$movie_love
frien_donlike_movie <- df1[! df1$movie_love, ]

cond1 <- df1$age < 30 & df1$movie_love
df1[cond1, ]

df1$age >= 28 
cond2 <- df1$age >= 28 | !df1$movie_love
df1[cond2, ]

write.csv(df1, "friend.csv", row.names = FALSE)
df <- read.csv("friend.csv")
View(df)

# control flow + function
print("Hello World")
## user defined function
add_two_nums <- function(v1, v2) {
  v1+v2
}
add_two_nums(10 ,55)

## power 3
cube <- function(x) x**3
cube(5)

## power
my_power <- function(base, pow) {
  return(base**pow)
}
my_power(base=5, pow=2)
# (base, pow) parameters
# (5, 2) arguments
my_power(pow=3, base=4)

my_power3 <- function(base, pow=3) {
  return(base**pow)
}
my_power3(5)

# no input in function
greeting_name <- function(name) {
  text = paste("Hello", name)
  print(text)
  print("Done!")
}
greeting_name("Mon")

## Crate a chatbot
greeting_bot <- function() {
  username = readline("What's your name: ")
  print(paste("Hello!", username))
  
  your_age = readline("How old your name: ")
  your_age = as.numeric(your_age)
  print(your_age)
  print(paste("You are", your_age, "Year old"))
}
greeting_bot()

## control flow
## if, for, while
# if
score <- 65
if (score >= 80) {
  print("Passed")
} else if (score >= 50) {
  print("Just OK") 
} else {
  print("You have to retake the exam!")
}

## control flow & function
grade_cal <- function(score) {
  if (score >= 80) {
    print("Passed")
  } else if (score >= 50) {
    print("Just OK") 
  } else {
    print("You have to retake the exam!")
  }
}
grade_cal(50)

# while loop example
count <- 0           # counter
while (count < 5) {
  print("😂")
  count <- count + 1 # update counter
}

new_chatbot <- function() {
  
  print("Instruction: type 'exit' to exit the program")
  
  while (TRUE) {
    text = readline("What's your name: ")
    if (text == "exit") {
      print("Thank you for using our chatbot.")
    } else {
      print(paste("Hello!", text))
    }
    break
  }
}

# for loop
friends <- c("toy", "mon", "boo")
for (friend in friends){
  text = paste("Hi", toupper(friend))
  print(text)
}

paste("Hi", toupper(friends))

# HW01: Chatbot 5 diaogues
# HW02: Pao Ying Chub

## Example Hw02
play_game <- function() {
  print("##########")
  option <- c("hammer", "scissor", "paper")
  
  user_select <- readline("Choose one: ")
  computer_select <- sample(options, 1)
  
  if (user_select == computer_select) {
    print("tie !")
  } else {
    print("Thank for playing")
  }
}

## regular expression
state.name

city_start_A <- grep("^K", state.name)
state.name[city_start_A]

city_end_S <- grep("s$", state.name)
state.name[city_end_S]

city_contrain_new <- grep("new", state.name, 
                          ignore.case = TRUE)
state.name[city_contrain_new]
