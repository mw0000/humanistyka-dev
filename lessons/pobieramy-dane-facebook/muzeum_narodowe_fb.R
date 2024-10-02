m <- read.csv('muzeum_narodowe_sample.csv', fileEncoding = "UTF-8", row.names = FALSE)

# średnia i mediana polubień
mean(m$likes, na.rm = TRUE)
#[1] 218.4818
median(m$likes, na.rm = TRUE)
#[1] 91

# przetwarzanie dat
m$year_month <- as.POSIXct(m$time, format="%Y-%m-%dT%H:%M:%OSZ", tz="UTC")
m$year_month <- format(m$year_month, "%Y-%m")
p <- as.data.frame(table(m$year_month))
names(p) <- c("rok_miesiac","liczba_wpisow")

# generowanie wykresu
library(ggplot2)
install.packages("ggplot2")
ggplot(p, aes(x = rok_miesiac, y = liczba_wpisow, group = 1)) +
  geom_line(color = "skyblue", size = 1) +
  labs(x = "Rok i miesiąc (YYYY-MM)", y = "Liczba wpisów", title = "Wpisy na profilu Muzeum Narodowego w Warszawie") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))