#1 instalujemy xml2 do pracy z DOM
install.packages("xml2")
library(xml2)

#2 importujemy strone nocy muzeow do obiektu xml

source <- read_html('noc_muzeow.html')

#3 korzystamy z kwerendy XPath, zeby wyodrebnic informacje o adresach

locations <- xml_find_all(source, "//a/span[3]/text()")

#4 instalujemy bibliotekę ułatwiającą pracę z usługami geolokalizacji adresów

install.packages('tidygeocoder')
library(tidygeocoder)

#5 nadpisujemy obiekt locations, zeby zamienic go w wieloelementowy obiekt tekstowy

locations = unlist(as_list(locations))

#6 tworzymy pustą ramkę danych (dataframe) na dane do mapy

map_data <- data.frame()

#7 odpytujemy pętlą usługę arcgis - przetwarzamy adresy na koordynaty geograficzne

for(l in locations) {
  map_data <- rbind(map_data, geo(address = l, method = "arcgis", mode = "single"))
  Sys.sleep(1)
}

#8 Skoro mamy już dane, możemy zacząć pracę nad mapą - instalujemy leaflet i wczytujemy go do środowiska

install.packages("leaflet")
library(leaflet)

#9 tworzymy mapę, używając przy tym ustawień dla klastrów (clusterOptions)

m <- leaflet(data = map_data) %>% addTiles() %>% addMarkers(~long, ~lat, popup = ~address, clusterOptions = markerClusterOptions())

m

#10 zmieniamy standardową warstwę mapy

m2 <- leaflet(data = map_data) %>% addProviderTiles(provider = "Stadia.AlidadeSmoothDark") %>% addMarkers(~long, ~lat, popup = ~address, clusterOptions = markerClusterOptions())

m2
