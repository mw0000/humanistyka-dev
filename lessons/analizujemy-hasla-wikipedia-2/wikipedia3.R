install.packages("WikipediR")
library(WikipediR)

museum_pages <- pages_in_category("pl", "wikipedia", categories = "Muzea historyczne w Polsce", properties = "title", limit = 100, type=c("page"))

museum_pages$query$categorymembers[[1]]$title
museum_pages$query$categorymembers[[10]]$title

historical_museums <- data.frame()

for(museum_page in museum_pages$query$categorymembers) {
  
  title <- museum_page$title
  historical_museums <- rbind(
    historical_museums,
    list(
      page_title = title
    )
  )
  
}

historical_museums[10,1]

test_content <- page_content("pl","wikipedia", page_name = historical_museums[10,1])

install.packages("xml2")
library(xml2)

test_content_html <- read_html(test_content$parse$text[[1]])

test_images <- xml_find_all(test_content_html, '//img/@src')

test_images

test_count_images <- length(unique(unlist(as_list(test_images))))

test_count_images

historical_museum_images <- data.frame()

for (museum_title in historical_museums$page_title) {
  # pobieranie treści strony
  museum_page_content <- page_content("pl", "wikipedia", page_name = museum_title)
  # przetwarzenie ją na dokument html
  museum_page_content_html <- read_html(museum_page_content$parse$text[[1]])
  # wysyłanie kwerendy XPath
  museum_page_content_images <- xml_find_all(museum_page_content_html, '//img/@src')
  # zliczanie unikalnych wartości ścieżek do obrazków
  museum_page_content_images_count <- length(unique(unlist(as_list(
    museum_page_content_images
  ))))
  # dodawanie danych do ramki historical_museum_images
  historical_museum_images <- rbind(
    historical_museum_images,
    list(page_title = museum_title, images_count = museum_page_content_images_count)
  )
}

write.csv(historical_museum_images, "historical_museum_images.csv", row.names = FALSE)