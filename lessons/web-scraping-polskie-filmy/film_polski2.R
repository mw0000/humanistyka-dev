install.packages("xml2")
library(xml2)

count_movies <- function(year = 2020) {
  # upewnijmy się, że biblioteka xml2 jest wczytana do środowiska
  library(xml2)
  # budujemy dynamicznie adres URL (w zależności od wybranego roku)
  # jako standardowy ustawiliśmy rok 2020
  # filmy fabularne = type=1
  fp_url <- paste0("https://filmpolski.pl/fp/index.php?filmy_z_roku=",year,"&typ=1")
  # metoda read_html ściąga z podanego adresu URL dokument HTML/XML  
  fp_page <- read_html(fp_url)
  # definiujemy kwerendę XPath, którą poruszamy się po dokumencie
  # będziemy pobierać teksty wszystkich linków z listy 
  xpath <- "//div[@class='visibletext']/ul[@class='wynikifilmyzroku']/li//a/text()"
  # tutaj wykonujemy kwerendę xpath na naszym dokumencie fp_page
  # xml_find_all znajduje wszystkie pasujące elementy
  fp_movies <- xml_find_all(fp_page, xpath)
  # tutaj przetwarzamy zbiór znalezionych elementów (węzłów) i zliczamy unikalne wartości
  fp_count <- length(unique(unlist(as_list(fp_movies))))
  # funkcja zwraca liczbę i kończy się
  return(fp_count)
}

count_movies(2020)

movie_stats <- data.frame()

for(y in 1902:2023) {
  # w każej iteracji rok (1902, 1903 itd.) przypisywany jest do y
  # wykonywana jest funkcja count_movies, do której przekazujemy argument (rok)
  c <- count_movies(y)
  # do ramki danych dodajmy wiersz (generowany jako lista), w którym znajduje się 
  # informacja o roku i liczbie filmów
  movie_stats <- rbind(movie_stats, list(
    year = y,
    movies_count = c
  ))
  # dodajemy krótką informację, która będzie wyświetlana przy każdej iteracji
  cat(paste0("W ",y, " znalazłem filmów: ", c, "\n"))
  # Wprowadzamy 1 sek. przerwy między kolejnymi iteracjami, żeby nie zaburzyć działania serwera
  Sys.sleep(1)
}

install.packages("ggplot2")
library(ggplot2)

ggplot(movie_stats, aes(x = year, y = movies_count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Premiery polskich filmów fabularnych (1902-2023)", x = "Rok", y = "Liczba premier") +
  theme_minimal()

write.csv(movie_stats, "movie_stats.csv", row.names = FALSE)