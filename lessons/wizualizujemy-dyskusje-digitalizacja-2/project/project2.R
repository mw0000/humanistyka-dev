# 1. importujemy CSV do ramki danych

c <- read.csv('concordance.csv', fileEncoding = "UTF-8", stringsAsFactors = FALSE)

# 2. upraszczamy nazwy kolumn

names(c) <- c(
  "lewyKontekst", "rezultat", "prawyKontekst", "interpretacja",
  "nazwaWlasna", "relacjaZaleznosciowa", "lematNadrzednika", "izba",
  "typ", "autor", "mowca", "przynaleznoscMowcy",
  "rolaMowcy", "plecMowcy", "komisja", "data",
  "timestamp", "rok", "ustroj", "numerKadencji",
  "etykieta", "tytul", "sesja", "dzien",
  "numer", "czesc"
)

# 3. podglądamy kolumnę

paste0(c$lematNadrzednika, c$rezultat)[1:10]

# [1] "i digitalizacji"              "i digitalizacji"              "na digitalizację"            
# [4] "infrastruktura digitalizacji" "służyć digitalizacji"         "stan digitalizacji"          
# [7] "na digitalizację"             "efekt digitalizuje"           "wykorzystywać digitalizację" 
# [10] "sprawa digitalizacji"  

# 4. funkcja table pozwala na zliczanie częstości występowania wartości w wektorze / kolumnie

table(c$lematNadrzednika)[120:130]

# postępować    postulat   poświecić   poświęcić     potrwać    potrzeba potrzebować  powiedzieć    powinien       powód 
# 1           1           1           1           1           4           1           1           2           2 
# powodować 
# 1 

# 5. Zamiana tabeli do ramki danych i zmiana nazw kolumn sprawi, że dane będą czytelniejsze

wrdcld_data <- as.data.frame(table(c$lematNadrzednika), stringsAsFactors = FALSE)
names(wrdcld_data)
# [1] "Var1" "Freq"

names(wrdcld_data) <- c("lemma", "freq")

head(wrdcld_data)

# lemma freq
# 1     -    3
# 2     –    4
# 3     ,  100
# 4     ;    4
# 5     :    1
# 6     ?    1

#  6. Porusznaie się po ramce danych

# wyświetlenie całej kolumny lemma - sposób I
wrdcld_data$lemma
# wyświetlenie całej kolumny lemma - sposób II
wrdcld_data[,1]
# wyświetlenie wybranych 10 wierszy kolumny lemma - sposób I:
wrdcld_data$lemma[20:29]
# wyświetlenie wybranych 10 wierszy kolumny lemma - sposób II:
wrdcld_data[20:29,1]
# wyświetlenie wybranych 10 wierszy wszystkich kolumn:
wrdcld_data[20:29,]
# sprawdzenie, czy rzeczywiście wyświetliliśmy 10 wierszy:
nrow(wrdcld_data[20:29,])
# [1] 10

# 7. instalowanie niezbędnej biblioteki do przetwarzania tekstu

install.packages("tm")
library(tm)
install.packages("stopwords")
library(stopwords)

# 8. nadpisujemy naszą ramkę danych

wrdcld_data <- c$lematNadrzednika

# 9. usuwamy stopwords

wrdcld_data <- removeWords(wrdcld_data, stopwords("pl", "stopwords-iso"))

# 10. usunięcie znaków interpunkcyjnych

wrdcld_data <-removePunctuation(wrdcld_data)

# 11. wyrzucenie pustych wpisów

wrdcld_data <- wrdcld_data[nchar(wrdcld_data) > 0]

# 12. ramka danych i zmiana nazw kolumn

wrdcld_data <- as.data.frame(table(wrdcld_data), stringsAsFactors = FALSE)

names(wrdcld_data) <- c("lemma", "freq")

# 13. wordcloud 1

library(wordcloud)

wordcloud(wrdcld_data$lemma, wrdcld_data$freq)

# 14. statystyki

mean(wrdcld_data$freq)
# [1] 3.701422
median(wrdcld_data$freq)
# [1] 2
max(wrdcld_data$freq)
# [1] 97

# 14. wordcloud 2

wordcloud(wrdcld_data$lemma, wrdcld_data$freq, min.freq = 1)

# 15. wordcloud 3

wordcloud(wrdcld_data$lemma, wrdcld_data$freq, min.freq = 4)

# 16. kolory

wordcloud(wrdcld_data$lemma, wrdcld_data$freq, colors=brewer.pal(8, "Dark2"))
