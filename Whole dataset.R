
Netflix <- read.csv("netflix_titles.csv",header = T)
setdiff(imdb_netflix,Netflix)

Combine <- merge(Netflix,imdb_netflix,by.x = "title",by.y = "title",all.x = T)



sum(is.na(Combine$rating.y))

new_DF <- Combine[!is.na(Combine$rating.y) & Combine$type == "Movie",]
