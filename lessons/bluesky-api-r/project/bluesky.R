# https://cran.r-project.org/web/packages/bskyr/index.html
# http://christophertkenny.com/bskyr/

install.packages('bskyr')

# https://bsky.app/settings/privacy-and-security

library(bskyr)

# autoryzacja
set_bluesky_user('XXXXXXXXXXXXXXXX.social')
set_bluesky_pass('XXXX-XXXX-XXXX-XXXX')

# ściągamy wpisy użytkownika o identyfikatorze nhmla.bsky.social
timeline <- bs_get_author_feed("nhmla.bsky.social")

timeline <- bs_get_author_feed("nhmla.bsky.social", limit=352)

# ta kolumna zabiera adresy URL obrazków
# timeline$post_embed.images.fullsize...279

# oczywiście nie każdy wpis zawiera obrazek
sum(!is.na(timeline$post_embed.images.fullsize...32))
# [1] 63
# tylko 63 wpisy zawierają obrazek
sum(is.na(timeline$post_embed.images.fullsize...32))
# [1] 285

# w tym kodzie do obiektu images zapiszemy tylko te wiersze całej ramki danych, w których znajdują się odnośniki do obrazków
images <- timeline[!is.na(timeline$post_embed.images.fullsize...32), ]

# write.csv zapisze ramkę danych images do pliku CSV
write.csv(images, "images.csv", row.names = FALSE)

install.packages("dplyr")
library(dplyr)

# znak operatora potokowego %>% wpisujemy za pomocą kombinacji Ctrl + Shift + M
# do images2 została zapisana wartość images, ale przefiltrowana (wyłącznie z wyznaczonymi w funkcji select() kolumnami)
images2 <- images %>% select(post_uri, post_cid, post_author.handle, post_record.created_at, post_like_count, post_embed.images.fullsize...32) 

write.csv(images2, "images2.csv", row.names = FALSE)

max((as.integer(images2$post_like_count)))
# [1] 208

hot_image <- images2 %>% filter(post_like_count == "208") %>% select(post_embed.images.fullsize...32)
hot_image$post_embed.images.fullsize...32
# [1] "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:v4dpm7icom54y366e76xy3mj/bafkreibeejdzksjrlqmg6xhw5u74xd7nedqteifejta6y2u4v5phkjdk5e@jpeg"