# 1 instalacja i wczytanie do pamięci pakietu colordistance 
# wraz z zależnościami (innymi pakietami niezbędnymi do jego działania)

install.packages("colordistance")
library(colordistance)

# 2. Wygenerujmy listę histogramów dla wszystkich plików w /images

# tworzymy obiekt images, który będzie zawierał ścieżki do plików
images <- dir("images", full.names=TRUE)

# [1] "images/1.png"              "images/100.png"            "images/2.png"             
# [4] "images/3.png"              "images/4.png"              "images/5.png"             
# [7] "images/6.png"              "images/7.png"              "images/8.png"             
# [10] "images/milkmaid_rijks.png"

# images podajemy jako parametr do funkcji getHistList
# parametr plotting ustawiamy na FALSE - nie chcemy wizualizacji tylko dane
cls <- getHistList(images, n = FALSE, bins=c(2, 2, 2), lower=NULL, upper=NULL, plotting=FALSE, pausing=FALSE)

# obiekt cls to lista ramek danych. Zobaczmy ramkę dla pliku wzorcowego 
# (skorzystajmy z $ aby wskazać na interesujący nas element listy) 

cls$milkmaid_rijks

# r         g         b          Pct
# 1 0.2269861 0.1940903 0.1698912 0.5720756032
# 2 0.5538118 0.4403769 0.3284896 0.0387845758
# 3 0.4784314 0.5372549 0.4274510 0.0006843605
# 4 0.6662203 0.5793214 0.4310356 0.0690830814
# 5 0.2166270 0.3647059 0.5566936 0.0046163226
# 6 0.7500000 0.2500000 0.7500000 0.0000000000
# 7 0.3910640 0.5441337 0.6426872 0.0015180360
# 8 0.7969949 0.7656331 0.6886053 0.3132380206

# Widzimy tutaj prosty układ tabeli (kolumny i wiersze). Tego typu dane wygenerowaliśmy dla każdego 
# obrazka w katalogu images. Pierwsze trzy kolumny to współrzędne każdego klastra, 
# a ostatnia kolumna reprezentuje względną wielkość każdego klastra jako proporcję. Wyobrażmy sobie te klastry jako punkty na w przestrzeni 3D. Kolejne kolumny wskazują na umiejscowienie tych punktów na osiach kolorów podstawowych 
# (czerwonego, zielonego i niebieskiego). Wartości wierszy z czwartej kolumny opisują wielkość danego punktu.

# Korzystają z operatora $, który działa także dla kolumn ramek danych, możemy 
# wyświetlić wartości kolumny Pct

cls$milkmaid_rijks$Pct

# Jeśli je zsumujemy, dadzą 1 (100%) - to wartości relatywne.

sum(cls$milkmaid_rijks$Pct)

# Porównajmy to z histogramem naszego pliku wzorcowego:

h0 <- getImageHist("images/milkmaid_rijks.png", n = FALSE, bins=c(2, 2, 2), lower=NULL, upper=NULL)

# wyliczamy EMD dla wszystkich reprodukcji

cls_emd <- getColorDistanceMatrix(cls, method="emd", plotting=FALSE)

cls_emd

# generujemy wykres mapy ciepła, używamy plotting=TRUE

cls_emd_viz <- getColorDistanceMatrix(cls, method="emd", plotting=TRUE)

# generujemy dendrogram na podstawie colorDistanceMatrix (parametr plotting = FALSE)

cls_emd_tree_data <- getColorDistanceMatrix(cls, method="emd", plotting=FALSE)

cls_emd_tree <- exportTree(cls_emd_tree_data, 'milkmaids_tree.newick')

# aby zobaczyć wygenerowane drzewo, skorzystajmy z pakietu ape

install.packages("ape")
library(ape)

# importujemy plik milkmaids_tree.newick do funkcji

plot.phylo(read.tree('milkmaids_tree.newick'), edge.color = "blue")

# warto zapoznać się z dokumentacją plot.phylo

?plot.phylo
