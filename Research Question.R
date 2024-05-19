

Final <- read.csv("netflixWC.csv",header = T)
Final$X <- NULL
#names(Final)[names(Final)=="duration.x"]<-"duration_in_minutes"

Final$movie_timeFrame <- ifelse(Final$release_year < 2018, "Recent Movie","New Movie") 

library(dplyr)
library(reshape2)
####By age_rating
movie_group <- group_by(Final,age_rating,movie_timeFrame)
movie_summary <- summarise(movie_group,
                           Total = n(),
                           Average = round(mean(star_rating,na.rm = T),2),
                           Min = min(star_rating,na.rm = T),
                           Max = max(star_rating,na.rm = T))
movie_summary

movie_pivot <- dcast(movie_summary,age_rating~movie_timeFrame,value.var = "Average")
movie_pivot
####By Country
movie_group2 <- group_by(Final,country,movie_timeFrame)
movie_summary2 <- summarise(movie_group2,
                           Total = n(),
                           Average = round(mean(star_rating,na.rm = T),2),
                           Min = min(star_rating,na.rm = T),
                           Max = max(star_rating,na.rm = T))
movie_summary2

movie_pivot2 <- dcast(movie_summary2,country~movie_timeFrame,value.var = "Average")
movie_pivot2
####By genre
movie_group3 <- group_by(Final,genre,movie_timeFrame)
movie_summary3 <- summarise(movie_group3,
                            Total = n(),
                            Average = round(mean(star_rating,na.rm = T),2),
                            Min = min(star_rating,na.rm = T),
                            Max = max(star_rating,na.rm = T))
movie_summary3

movie_pivot3 <- dcast(movie_summary3,genre~movie_timeFrame,value.var = "Average")
movie_pivot3

