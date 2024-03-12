# 1. Wczytujemy dodatkowe pakiety R, aby skorzystać z metod przez nie oferowanych.
library(jsonlite)
library(dplyr)

# 2. Przypisujemy do api_url podstawowy adres, na który będziemy wysyłać żądanie. W adresie brakuje informacji o stronie - tę dodawać będziemy dynamicznie.
api_url <- 'https://api.wellcomecollection.org/catalogue/v2/works?query=Amman%20Jost&page='

# 3. Tworzymy obiekty, które będą nadpisywane przez pętlę.
# total - liczba wyników (na początku 0, docelowo 113)
# page - liczba stron - na początku 1
# objects - pusta ramka danych, w której znajdą się metadane wyszukiwanych obiektów

total <- 0
page <- 1
objects <- data.frame()

# 4. Konstruujemy pętlę z warunkiem, którego elementem jest dynamicznie zmieniana wartość total

while(total < 113) {
  # 4.1 Budujemy dynamicznie adres żądania i go wyświetlamy
  current_api_url <- paste0(api_url,page)
  cat(paste0('\n', current_api_url))
  # 4.2 wysyłamy żądanie i spłaszczamy strukturę danych
  request <- fromJSON(paste0(current_api_url), flatten = TRUE)
  # 4.3 Wybieramy tylko niektóre kolumny z ramki danych i tworzymy z nich ramkę current_objects 
  current_objects <- request$results %>% select(id, workType.label, title, description, thumbnail.url, thumbnail.license.label)
  # 4.4 Dopisujemy ramkę current_objects do naszej wyjściowej ramki (objects)  
  objects <- rbind(objects, current_objects)
  # 4.5 modyfikujemy wartość wektora total, tak aby pętla mogła się kiedyś skończyć :) 
  total <- nrow(objects)
  # 4.6 aby wysłać żądanie o kolejną stronę wyników, zwiększamy numer strony
  page <- page + 1
}