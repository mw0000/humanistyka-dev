x <- 0
while(x != 10) {
  x <- x + 1
  print(x)
}

page <- 1
api_url <- 'https://api.wellcomecollection.org/catalogue/v2/works?query=Amman%20Jost&page='
current_api_url <- paste0(api_url,page)

add10 <- function(i) {
  return(i + 10)
}

add10(100)

our_data <- getDataFromWC()

names(our_data)

table(our_data$workType.label)

library(dplyr)
filtered_data <- our_data %>% filter(workType.label == 'Pictures')

filtered_data <- filtered_data %>% filter(!is.na(thumbnail.url))

getFilesFromWC(filtered_data)
