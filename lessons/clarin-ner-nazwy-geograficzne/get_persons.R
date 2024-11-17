install.packages('WikipediR')
install.packages('stringi')
library(WikipediR)
library(stringi)

persons <- c(
  "Marcelina_Czartoryska",
  "Maria_Szymanowska",
  "Maria_Skłodowska-Curie",
  "Klaudyna_Potocka",
  "Aniela_Tułodziecka",
  "Narcyza_Żmichowska",
  "Jadwiga_Zamoyska",
  "Ksawera_Deybel",
  "Eliza_Orzeszkowa",
  "Maria_Dulębianka",
  "Olga_Boznańska",
  "Jadwiga_Łuszczewska",
  "Helena_Modrzejewska",
  "Julia_Molińska-Woykowska",
  "Seweryna_Duchińska",
  "Maria_Kalergis",
  "Olga_Drahonowska-Małkowska",
  "Emilia_Sczaniecka"
)
#t <- page_content("pl", "wikipedia", page_name = "Maria_Skłodowska-Curie")

for (person in persons) {
  cat(person)
  wp_content <- page_content("pl", "wikipedia", page_name = person)
  wp_txt <- wp_content$parse$text
  file_name <- stri_trans_general(person, "Latin-ASCII") # Usunięcie polskich znaków
  file_name <- gsub(" ", "_", file_name)                # Zamiana spacji na podkreślenia
  file_name <- paste0(file_name, ".txt")                # Dodanie rozszerzenia
  writeLines(unlist(wp_txt), file_name)
}
