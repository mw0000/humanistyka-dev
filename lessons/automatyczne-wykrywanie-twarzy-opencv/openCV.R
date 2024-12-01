# 1. instalowanie pakietu i dodanie go do środowiska
install.packages('opencv')
library(opencv)

# 2. wczytanie pliku ze zdjęciem do środowiska
photo <- ocv_read('nac_photos/PIC_1-K-8240-1.jpg')

# 3. wykonanie rozpoznania funkcją ocv_face
# funkcja przyjmuje OBIEKT obrazka, a nie ścieżkę do niego!
photo_faces <- ocv_face(photo)

# 4. Zapisanie zdjęcia z oznaczonymi twarzami
ocv_write(photo_faces, 'nac_faces/PIC_1-K-8240-1_faces.jpg')

# 5. Masowe wykrywanie twarzy w pętli
# 5.1 zebranie nazw plików z katalogu nac_photos
photos <- dir("nac_photos")
# photos
# [1] "PIC_1-K-8240-1.jpg"  "PIC_1-K-8240-14.jpg" "PIC_1-K-8240-18.jpg"
# [4] "PIC_1-K-8240-26.jpg" "PIC_1-K-8240-45.jpg" "PIC_1-K-8240-47.jpg"
# [7] "PIC_1-K-8240-50.jpg" "PIC_1-K-8240-58.jpg"

# 5.2 napiszmy pętlę

for(photo in photos) {
  # wczytanie pliku do środowiska
  # funkcją paste0 łączymy ścieżkę dostępu
  p <- ocv_read(paste0('nac_photos/', photo))
  # analiza funkcją ocv_face
  p_faces <- ocv_face(p)
  # zapisanie pliku wynikowego
  # do oryginalnej nazwy pliku dodajemy faces_
  ocv_write(p_faces, paste0('nac_faces/faces_', photo))
}







t <- ocv_read('nac_photos/PIC_1-K-8240-1.jpg')
t_faces <- ocv_face(t)
t_faces









