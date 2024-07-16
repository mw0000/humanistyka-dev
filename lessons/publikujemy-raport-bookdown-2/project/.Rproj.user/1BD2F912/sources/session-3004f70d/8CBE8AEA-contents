library(bookdown)

# dodawanie dynamicznych tabel i wykresów do publikacji

# instalacja niezbednych pakietow

install.packages("webshot")
install.packages("plotly")
webshot::install_phantomjs()
install.packages("DT")

# CSV do data.frame
# file.choose() umożliwi nam ręczne wskazanie pliku csv - dzięki temu nie musimy wpisywać pełnej ścieżki

dane <- read.csv(file.choose())

# zobaczmy nasze dane

View(dane)

# wczytujemy pakiety do środowiska

library(DT)
library(webshot)

# test interaktywnego wykresu

library(plotly)
fig <- plot_ly(dane, x = ~miesiac, y = ~pocztowki_udostepnione, type = 'bar')
fig <- fig %>% layout(title = 'Pocztówki udostępnione w poszczególnych miesiącach',
                      xaxis = list(title = 'Miesiąc'),
                      yaxis = list(title = 'Pocztówki udostępnione'))

fig
