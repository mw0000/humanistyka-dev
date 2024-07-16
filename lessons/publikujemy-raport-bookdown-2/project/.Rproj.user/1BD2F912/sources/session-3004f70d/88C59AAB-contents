# bookdown

# 1. instalujemy bibliotekę bookdown i wczytujemy do środowiska

install.packages("bookdown")
library(bookdown)



#2. generowanie pliku pdf

render_book("index.Rmd", "bookdown::pdf_book", config_file="_bookdown.yml")

#2 html

render_book("index.Rmd", "bookdown::gitbook", config_file="_bookdown.yml")

#3 epub

render_book("index.Rmd", "bookdown::epub_book", config_file="_bookdown.yml")