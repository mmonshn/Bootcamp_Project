library(RSQLite) #DBI
library(janitor) #Cleaning Dirty Data

list.files()

## connect database
con <- dbConnect(SQLite(), "chinook.db")

## list table names
dbListTables(con)

## list fields in a table
dbListFields(con, "customers")

## write SQL queries
df <- dbGetQuery(con, "select * from customers limit 10;")

df %>%
  select(FirstName, LastName)

clean_df <- clean_names(df)
View(clean_df)

## write JOIN syntax
df2 <- dbGetQuery(con, "select * from albums, artists
                        where albums.artistid = artists.artistid;") %>%
  clean_names()

View(df2)

## write a table
dbWriteTable(con, "cars", mtcars)
dbListTables(con)

dbGetQuery(con, "select * from cars limit 10;")

## drop table
dbRemoveTable(con, "cars")

## close connection
dbDisconnect(con)