rm(list=ls())

library(xml2)

###looping (year only for now)
#for(i in 1){
#  link <- paste("https://www.imdb.com/search/title/?companies=co0144901&start=",i+50,"&ref_=adv_prv",sep="")
#  page2 <- read_html(link)
#  year<-xml_text(xml_find_all(page,"//h3[@class='lister-item-header']/span[@class='lister-item-year text-muted unbold']"))
#  year2 <- c(year,year2)
#}

seq <- seq(0,19791,50)
titles <- character(0)
years <- character(0)
ratings <- character(0)
genres <- character(0)
durations <- character(0)

for (i in seq){
  print(i)
  url <- paste("https://www.imdb.com/search/title/?companies=co0144901&start=",i,sep="")
  page <- read_html(url)
  
  title <- xml_text(xml_find_all(page,"//h3[@class = 'lister-item-header']/a"))
  titles <- c(titles,title)
  
  year <- xml_text(xml_find_all(page,"//h3[@class='lister-item-header']/span[@class='lister-item-year text-muted unbold']"))
  years <- c(year,years)
  
  rating <- as.numeric(xml_text(xml_find_all(page,"//div[@class = 'inline-block ratings-imdb-rating']/strong")))
  ratings <- c(rating,ratings)
  
  genre <- trimws(gsub("(\n)","", xml_text(xml_find_all(page, "//span[@class='genre']"))))
  genres <- c(genre,genres)
  
  duration <- as.numeric(trimws(gsub("min","",xml_text(xml_find_all(page,"//p[@class='text-muted ']/span[@class='runtime']")))))
  durations <- c(duration,durations)
}
