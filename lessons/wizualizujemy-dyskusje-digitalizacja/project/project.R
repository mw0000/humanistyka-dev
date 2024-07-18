# 1. importujemy CSV do ramki danych

c <- read.csv('concordance.csv', fileEncoding = "UTF-8", stringsAsFactors = FALSE)

# 2. podstawowe informacje o danych

names(c)
# [1] "Lewy.kontekst"         "Rezultat"              "Prawy.kontekst"        "Interpretacja"        
# [5] "Nazwa.własna"          "Relacja.zależnościowa" "Lemat.nadrzędnika"     "Izba"                 
# [9] "Typ"                   "Autor"                 "Mówca"                 "Przynależność.mówcy"  
# [13] "Rola.mówcy"            "Płeć.mówcy"            "Komisja"               "Data"                 
# [17] "Timestamp"             "Rok"                   "Ustrój"                "Numer.kadencji"       
# [21] "Etykieta"              "Tytuł"                 "Sesja"                 "Dzień"                
# [25] "Numer"                 "Część"                
nrow(c)
# [1] 1755

# 3. uproszczenie nazw kolumn

names(c) <- c(
  "lewyKontekst", "rezultat", "prawyKontekst", "interpretacja",
  "nazwaWlasna", "relacjaZaleznosciowa", "lematNadrzednika", "izba",
  "typ", "autor", "mowca", "przynaleznoscMowcy",
  "rolaMowcy", "plecMowcy", "komisja", "data",
  "timestamp", "rok", "ustroj", "numerKadencji",
  "etykieta", "tytul", "sesja", "dzien",
  "numer", "czesc"
)

# 4. różne statystyki z funkcją table()

years <- table(c$rok)
years <- as.data.frame(years, stringsAsFactors = FALSE)
names(years)
names(years) <- c("rok","wystapienia")

mean(years$wystapienia)
median(years$wystapienia)

# 5. niezbedne biblioteki

install.packages("ggplot2")
install.packages("plotly")

library(ggplot2)

# 6. tworzneie wykresu z trzech warstw

w1 <- ggplot(data = years, aes(x = rok, y = wystapienia)) +
  geom_line(aes(group = 1)) +  
  labs(x = "Rok", y = "Liczba wystąpień", title = "Wystąpienia parlamentarne na temat digitalizacji")

# 7. Zmiana wyglądu wykresu

install.packages("ggthemes")
library(ggthemes)

w1 + theme_solarized()

w1 + theme_linedraw()

w2 <- ggplot(data = years, aes(x = rok, y = wystapienia)) +
  geom_line(aes(group = 1), color = "#FF5733") +  
  labs(x = "ROK", y = "LICZBA WYSTĄPIEŃ", title = "WYSTĄPIENIA PARLAMENTARNE NA TEMAT DIGITALIZACJI") +
  theme_solarized(base_size = 10, base_family = "monospace", light = TRUE)

w2

w2

# 8 sprawdzanie kompletności danych w kolumnie rok

nodata <- table(is.na(c$rok))

nodata

total <- sum(nodata)

total

nodata / total * 100

# 9. generowanie interaktywnego wykresu

library(plotly)

ggplotly(w2)
