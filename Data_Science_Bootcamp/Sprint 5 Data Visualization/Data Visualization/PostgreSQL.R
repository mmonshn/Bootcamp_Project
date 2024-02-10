library(RPostgreSQL)

## connect database
con <- dbConnect(PostgreSQL(),
          host = "arjuna.db.elephansql.com", #server
          port = 5432, #default
          user = "uhxscpvf",
          pass = "1nIwvZwkyVDvrmtX1CVcZvzXiF-D9Mve",
          dbname = "uhxscpvf")

## write table
dbWriteTable(con, "cars", mtcars %>% slice(1:5))

## list table
dbListTables(con)

## get query
dbGetQuery(con, "select count(*) from cars")
dbGetQuery(con, "select * from cars")

## disconnection
dbDisconnect(con)