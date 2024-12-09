library(bskyr)

set_bluesky_user('XXXXXXXXXXXXXX.social')
set_bluesky_pass('XXXX-XXXX-XXX-XXXX')

download.file("https://cdn-zbiory.mnk.pl/upload/cache/multimedia_detail/e7/90/e790c7242e5bf12295c9d58f6750d0f0.jpg", "scan.jpg")

image_blob <- bs_upload_blob("scan.jpg", clean = FALSE)

bs_post(
  text = "Portret aktora Nakamura Nakazo obok ołtarza. Deszcz, Katsukawa, Shunsho (1726-1792), https://zbiory.mnk.pl/pl/katalog/14759",
  images = image_blob,
  images_alt = "Portret aktora Nakamura Nakazo obok ołtarza. Deszcz, Katsukawa, Shunsho (1726-1792)"
)

str(image_blob)
