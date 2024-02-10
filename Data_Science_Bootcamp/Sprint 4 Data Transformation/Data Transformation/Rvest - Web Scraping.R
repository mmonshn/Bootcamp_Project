# static website
# load rvest and tidyverse
library(rvest)
library(tidyverse)

url <- "https://www.imdb.com/search/title/?groups=top_100&sort=user_rating.desc"

# Static Website (Ex.: Wikipedia)
movie_name <- url %>%
  read_html() %>%
  html_elements("h3.lister-item-header") %>%
  html_text2() #remove characters

ratings <- url %>%
  read_html() %>%
  html_elements("div.ratings-imdb-rating") %>%
  html_text2() %>%
  as.numeric()

votes <- url %>%
  read_html() %>%
  html_elements("p.sort-num_votes-visible") %>%
  html_text2()

imdb_df <- data.frame(
  movie_name,
  ratings,
  votes
)
View(imdb_df)

# ข้างหน้า | ต้องใส่ \ สองตัวติดกัน ซึ่งเป็น escape characters ใน R
imdb_df %>%
  separate(votes, sep=" \\| ", into=c("votes", 
                                      "gross", 
                                      "tops")) %>%
  View()

specphone_url <- "https://specphone.com/Samsung-Galaxy-S23-5G.html"

specphone_url %>%
  read_html() %>%
  html_elements("div.topic") %>%
  html_text2()

specphone_url %>%
  read_html() %>%
  html_elements("div.detail") %>%
  html_text2()
