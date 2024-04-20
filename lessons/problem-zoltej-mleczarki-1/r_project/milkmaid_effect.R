# 1. instalacja i wczytanie pakietu do środowiska

install.packages("colordistance")
library(colordistance)

# 2. przetwarzanie kolorów z wybranego obrazka na trójwymiarową przestrzeń
# opcje lower i upper zostawiamy jako NULL; służą one do usuwania tła (w naszym przypadku nie ma to sensu)
# n = "all" - chcemy analizować wszystkie piksele

i7 <- plotPixels("images/7.png", n = "all", lower=NULL, upper=NULL)

i100 <- plotPixels("images/100.png", n = "all", lower=NULL, upper=NULL)

# 3. Budujemy histogramy z kolorów obrazka, korzystamy z dwóch koszy (bins) dla każdego koloru podstawowego RGB. 
# Ignorujemy usuwanie tła

h7 <- getImageHist("images/7.png", n = FALSE, bins=c(2, 2, 2), lower=NULL, upper=NULL)

h100 <- getImageHist("images/100.png", n = FALSE, bins=c(2, 2, 2), lower=NULL, upper=NULL)

# 4. dzięki getHistList możemy wygenerować automatycznie histogramy dla wszystkich plików w katalogu

# tworzymy obiekt images, który będzie zawierał ścieżki do plików
images <- dir("images", full.names=TRUE)

# images podajemy jako parametr do funkcji getHistList
# funkcja wygeneruje nam w oknie plot poszczególne palety (możemy je wtedy eskportować do plików)
cls <- getHistList(images, n = FALSE, bins=c(2, 2, 2), lower=NULL, upper=NULL, plotting=TRUE, pausing=FALSE)

# 5. możemy też wygenerować interaktywny wykres 3D w Plotly, ale do tego musimy zmienić parametr plotting na FALSE

cls <- getHistList(images, n = FALSE, bins=c(2, 2, 2), lower=NULL, upper=NULL, plotting=FALSE, pausing=FALSE)

# zapisujemy wykres do obiektu clsViz, po wyświetleniu go w panelu po prawej stronie 
# możemy zapisać go jako stronę internetową

clsViz <- plotClustersMulti(cls) 
