getDataFromWC <- function(s = "Amman Jost", cols = c("id", "workType.label", "title", "description", "thumbnail.url", "thumbnail.license.label")) {
  
  # 1. Funkcja przyjmuje dwa atrybuty: frazę wyszukiwania (s) oraz listę kolumn (metadanych) 
  
  # 2. Potrzebujemy dwóch bibliotek: jsonlite do łączenia się z API, a dplyr do opracowania pozyskanych danych
  library(jsonlite)
  library(dplyr)
  
  # 3. Formatujemy frazę wyszukiwania (m.in. pozbywamy się spacji na rzecz %20) 
  s <- URLencode(s)
  
  # 4. Dynamicznie budujemy adres żądania, łącząc endpoint z frazą wyszukiwania
  api_url <- paste0('https://api.wellcomecollection.org/catalogue/v2/works?query=',s,'&page=')
  
  # 5. Definiujemy podstawowe zmienne (wektory), które będą się nadpisywać w trakcie działania pętli
  # total - liczba pozyskanych obiektów (wierszy)
  # page - numer strony
  total <- 0
  page <- 1
  
  # 6. Musimy sprawdzić liczbę wszystkich dostępnych obiektów
  # Zapisujemy ją do total_results
  first <- fromJSON(paste0(api_url, 1), flatten = TRUE)
  total_results <- first$totalResults
  
  # 7. Wyświetlamy informację o zakładanej liczbie obiektów
  cat(paste0('\n Total results: ', total_results))
  
  # 8. Tworzymy pustą ramkę danych, do której dogrywać będziemy wiersze z informacjami o kolejnych obiektach
  objects <- data.frame()
  
  # 9. Definiujemy pętlę, która będzie wykonywać się do czasu, aż liczba pozyskanych obiektów (total) będzie równa liczbie dostępnych obiektów w API (total_results)
  
  while(total < total_results) {
    # 9.1 dynamicznie definiujemy aktualny adres żądania (zmienia się strona)
    current_api_url <- paste0(api_url,page)
    # 9.2 Wyświetlamy informację o tym adresie i numerze strony
    cat(paste0('\n', current_api_url))
    cat(paste0('\n', page))
    # 9.3 Wysyłamy żądanie do API
    request <- fromJSON(paste0(current_api_url), flatten = TRUE)
    # 9.4 Z ramki danych dostępnej w odpowiedzi serwera pobieramy wybrane kolumny (metadanych)
    current_objects <- request$results %>% select(all_of(cols))
    # 9.5 Dodajemy nowe wiersze do zapisanych już danych 
    objects <- rbind(objects, current_objects)
    # 9.6 Sprawdzamy liczbę pozyskanych obiektów
    total <- nrow(objects)
    # 9.7 Zwiększamy numer strony o 1
    page <- page + 1
    # 9.8 Czekamy 3 sekundy
    Sys.sleep(3) 
  } 
  # 10. Zwracamy pozyskane dane w postaci ramki danych objects 
  return(objects)
}