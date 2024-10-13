install.packages("WikipediR")
library(WikipediR)

museums <- c(
  "Muzeum Narodowe w Gdańsku",
  "Muzeum Narodowe w Kielcach",
  "Muzeum Narodowe w Krakowie",
  "Muzeum Narodowe w Lublinie",
  "Muzeum Narodowe w Poznaniu",
  "Muzeum Narodowe w Szczecinie",
  "Muzeum Narodowe w Warszawie",
  "Muzeum Narodowe we Wrocławiu"
)

info <- page_info("pl","wikipedia", page = "Muzeum Narodowe w Gdańsku")
info2 <- page_content("pl","wikipedia",page_name = "Muzeum Narodowe w Gdańsku")

str(info)

info$query$pages[[1]]$length

museum_pages_length <- data.frame()

# tworzymy pustą ramkę danych
museum_pages_length <- data.frame()

# zaczynamy definiować pętlę
# będziemy iterowali po wszystkich elementach wektora museums
for(page_title in museums) {
  
  # wysyłamy żądanie do API Wikipedii
  # dynamicznie podmieniamy tytuł analizowanej strony
  info <- page_info("pl","wikipedia", page = page_title)  
  # wyciągamy z odpowiedzi infromację o objętości tej strony
  length <- info$query$pages[[1]]$length
  # tworzymy listę z dwoma kluczami
  museum_data <- list(
    title = page_title,
    length = length
  )
  # dodajemy ją jako wiersz do istniejącej już ramki
  museum_pages_length <- rbind(museum_pages_length, museum_data)
}

museum_pages_length
#                         title length
#1    Muzeum Narodowe w Gdańsku  11566
#2   Muzeum Narodowe w Kielcach  25912
#3   Muzeum Narodowe w Krakowie  93924
#4   Muzeum Narodowe w Lublinie  11621
#5   Muzeum Narodowe w Poznaniu  11705
#6 Muzeum Narodowe w Szczecinie  11759
#7  Muzeum Narodowe w Warszawie  69094
#8 Muzeum Narodowe we Wrocławiu  21729

install.packages("ggplot2")
library(ggplot2)

ggplot(museum_pages_length, aes(x = title, y = length, fill = title)) +
  geom_bar(stat = "identity") +
  labs(title = "Objętość haseł poświęconych muzeom na polskiej Wikipedii",
       x = NULL, y = "Objętość strony w bajtach",
       fill = "Tytul hasła") +  # Zmiana podpisu w legendzie
  theme(axis.text.x = element_blank()) +  # Usunięcie podpisów osi X
  scale_fill_brewer(palette = "Set2")


