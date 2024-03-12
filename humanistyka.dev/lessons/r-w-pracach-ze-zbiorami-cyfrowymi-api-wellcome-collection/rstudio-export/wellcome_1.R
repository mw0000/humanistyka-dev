z <- 'Muzea cyfrowe zwiększają dostęp do zbiorów dziedzictwa'

z

nchar(z)

l <- nchar(z)
l + 10

library(jsonlite)

api_url <- 'https://api.wellcomecollection.org/catalogue/v2/works?query=Amman Jost'

response <- fromJSON(api_url, flatten = TRUE)

response$type

response$totalResults

items <- response$results

names(items)

nrow(items)

library(dplyr)

works <- items %>% select(id, workType.label, title, description, thumbnail.url)

write.csv(works, 'works.csv', row.names = FALSE)
