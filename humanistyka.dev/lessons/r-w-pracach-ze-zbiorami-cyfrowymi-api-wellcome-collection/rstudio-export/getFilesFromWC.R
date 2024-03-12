getFilesFromWC <- function(df) {
  # 1. liczymy iteracje	
  iteration <- 1
  
  # 2. pętla for - przechodzimy przez wszystkie wiersze (wartości) w kolumnie thumbnail.url naszej ramki danych 	
  for(image_url in df$thumbnail.url) {
    
    # 3. tworzymy nazwę pliku z kolumny id, przy czym musimy wskazać numer wiersza
    fname <- paste0(df$id[iteration],'.jpg')
    
    # 3.1 wyświetlamy sobie adres i docelową nazwę pliku	
    cat(paste0('\n', image_url, ' -- ', fname))
    
    # 3.2 pobieramy plik, plik docelowy (destfile) to dynamicznie generowana nazwa pliku	
    download.file(url = image_url, destfile = fname)
    
    # 3.3 doliczamy kolejną iterację	
    iteration <- iteration + 1
    
    # 3.4 trzy sekundy przerwy	
    Sys.sleep(3)
    
  }
} 