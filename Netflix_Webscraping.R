rm(list = ls())

library('rvest')
library('xml2')

setwd("/Users/jiminhuh/Desktop")

################## Webscraping ##################

seq <- seq(0,9951,50)
titles <- character(0)
years <- character(0)
genres <- character(0)
ratings <- character(0)
durations <- character(0)

for (i in seq){
  print(i)
  url <- paste("https://www.imdb.com/search/title/?companies=co0144901&start=",i,sep="")
  page <- read_html(url)
  
  title1 <- xml_text(xml_find_all(page,"//h3[@class = 'lister-item-header']/a[1]"))
  titles <- c(titles,title1)
  
  year1 <- xml_text(xml_find_all(page,"//h3[@class='lister-item-header']/span[@class='lister-item-year text-muted unbold'][1]"))
  years <- c(years,year1)
  
  genre1 <- html_text(html_node(html_nodes(page, '.lister-item-content'), '.genre'))
  genres <- c(genres,genre1)
  
  rating1 <- html_text(html_node(html_nodes(page, '.lister-item-content'),'.ratings-imdb-rating strong'))
  ratings <- c(ratings,rating1)
  
  duration1 <- html_text(html_node(html_nodes(page, '.lister-item-content'),'.runtime'))
  durations <- c(durations,duration1)
} 

################## Dataframe ##################

imdb_netflix <- data.frame(title = titles,
                           year = years,
                           genre = genres,
                           rating = ratings,
                           duration = durations)

################## Combine the data ##################

Netflix <- read.csv("netflix_titles.csv",header = T)
setdiff(imdb_netflix,Netflix)

Combine <- merge(Netflix,imdb_netflix,by.x = "title",by.y = "title",all.x = T)



sum(is.na(Combine$rating.y))

new_DF <- Combine[!is.na(Combine$rating.y) & Combine$type == "Movie",]

################## Clean the data ##################

new_DF$year <- NULL
new_DF$genre <- NULL
new_DF$duration.y <- NULL
new_DF$description <- NULL
new_DF$cast <- NULL
new_DF$director <- NULL
new_DF$duration.x <- as.numeric(gsub(" min", "", new_DF$duration.x))
str(new_DF)

names(new_DF)[names(new_DF)=="rating.x"] <- "age_rating"
names(new_DF)[names(new_DF)=="rating.y"] <- "star_rating"
new_DF$star_rating <- as.numeric(new_DF$star_rating)

write.csv(new_DF,"Netflix_maybeFinal.csv")


