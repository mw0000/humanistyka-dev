install.packages("ngramr")

library(ngramr)
library(ggplot2)

c("bauhaus","brutalism")
length(c("bauhaus","brutalism"))

w1 <- ggram(c("bauhaus", "brutalism"), year_start = 1900, year_end = 2019, 
            corpus = "en-2019", ignore_case = TRUE, 
            geom = "area", geom_options = list(position = "stack")) + labs(y = NULL)
w1

w2 <- ggram(c("bauhaus", "brutalism"), year_start = 1900, year_end = 2019, corpus = "en-2019", ignore_case = TRUE, geom = "line") + 
  labs(y = NULL, title = "Wybrane style architektoniczne w korpusie Google Ngram Viewer (en-2019)") +
  scale_colour_manual(values = c("red", "green"), 
                      guide = guide_legend(title = NULL, position = "bottom"),
                      labels = c("Bauhaus", "Brutalism")) +
  scale_linetype_manual(values = c("solid", "dashed")) +
  theme(legend.position = "bottom") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_blank(), axis.line = element_line(colour = "black", linewidth = 0.5))

w2

w3 <- ggram(c("bauhaus", "brutalism"), year_start = 1900, year_end = 2019, corpus = "en-2019", ignore_case = TRUE, google_theme = TRUE) + theme(legend.direction = "vertical")

w3
