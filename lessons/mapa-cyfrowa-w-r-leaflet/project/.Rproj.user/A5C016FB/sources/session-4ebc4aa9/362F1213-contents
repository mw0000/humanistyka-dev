# 1. instalujemy i wczytujemy do środowiska pakiet leaflet

install.packages("leaflet")
library(leaflet)

# 2. tworzymy podstawową instancję mapy za pomocą funkcji leaflet()

map <- leaflet()

# 3. możemy podejrzeć strukturę obiektu mapy
str(map)

# 4. oraz ją wyświetlić

map

# 5. dodajemy standardową warstwę OpenStreetMap, korzystając z przetwarzania potokowego (piping)

map %>% addTiles()

# 6. moglibyśmy to zrobić też w klasycznym zapisie

addTiles(map)

#7. centrujemy mapę na interesującym nas obszarze:

map %>% addTiles() %>% setView(20.9706, 52.3209, zoom = 17)

#8. dodajemy punkt z popupem

map %>% addTiles() %>% setView(20.9706, 52.3209, zoom = 17) %>% addMarkers(20.9707, 52.3211, popup ='<a href="https://archiwumlat90.pl/obiekty/obiekt/?id=278&source=table">Ratusz Białołęka</a>')

#9. możemy dodać wiele punktów na raz, korzystając z danych w postaci json
# aby z nich skorzystać, wczytajmy bibliotekę jsonline

library(jsonlite)

# i zdefiniujmy obiekt markers

markers <- fromJSON("markers.json")

# teraz wyślijmy markes do naszej mapy jako źródło danych
# znak tyldy ~ pozwala wskazać kolumny (klucze) naszych danych

leaflet(data = markers) %>% addTiles() %>% setView(20.9706, 52.3209, zoom = 12) %>% addMarkers(~dlugosc_geogr, ~szerokosc_geogr, popup = ~nazwa)
