# uwaga - ta sciezka w Twoim przypadku będzie wyglądać inaczej
setwd("/home/m/XXX/XXX/project")


# 1. pobranie danych z pliku

library(dplyr)
# wczytanie danych
bot_data <- read.csv("bot_data.csv", row.names = NULL)
# wybór wszystkich niewysłanych obiektów
allowed_rows <- bot_data %>% filter(is_sent == 0) 
# wygenerowanie pseudolosowego wskażnika - numeru wiersza, który będzie przetwarzany
pointer <- sample(allowed_rows$object_id, 1)
# pobranie danych
post_data <- bot_data %>% filter(object_id == pointer)
# ustawienie w danych is_sent na 1 w bot_data
bot_data$is_sent[bot_data$object_id == pointer] <- 1
# nadpisanie pliku danych z aktualizacją kolumny is_sent
write.csv(bot_data, "bot_data.csv", row.names = FALSE)

# 2. Przygotowanie danych
# korzystamy z post_data
# str(post_data)
#'data.frame':	1 obs. of  6 variables:
#  $ object_id   : int 83
# url         : chr "https://zbiory.mnk.pl/pl/katalog/323348"
# desc        : chr "Wieczór nad Sekwaną, Gierymski, Aleksander (1850-1901)"
#$ img_src     : chr "https://cdn-zbiory.mnk.pl/upload/cache/multimedia_detail/89/0a/890ae49e3c83d434468bd7a844b0ab08.jpg"
#$ full_img_src: chr "https://cdn-zbiory.mnk.pl/upload/multimedia/89/0a/890ae49e3c83d434468bd7a844b0ab08.jpg"
#$ is_sent     : int 0

# przygotowanie bloba

library(bskyr)
library(jsonlite)

set_bluesky_user('XXXXXXXX.social')
set_bluesky_pass('XXXX-XXXX-XXXX-XXXX')

download.file(post_data$img_src, "temp.jpg")

# czekamy 15 sekund, żeby nie wysyłać blobu przed pobraniem obrazka
Sys.sleep(15)

image_blob <- bs_upload_blob("temp.jpg", clean = FALSE)

# 3. Wysłanie danych

post_description <- paste(post_data$desc, post_data$url)

bs_post(
  text = post_description,
  images = image_blob,
  images_alt = post_data$desc
)


