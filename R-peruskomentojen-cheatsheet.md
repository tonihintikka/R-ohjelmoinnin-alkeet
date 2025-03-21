# R-ohjelmoinnin peruskomentojen cheatsheet

## Perusteet

### R:n kommentointi
```r
# Tämä on yhden rivin kommentti

# Moniriviset kommentit tehdään useilla
# risuaita-merkeillä näin
```

### Muuttujien luominen ja arvon asettaminen
```r
# Muuttujan luominen ja arvon asettaminen
x <- 5
nimi <- "Matti"
on_totta <- TRUE

# Vaihtoehtoiset tavat
x = 5
5 -> x
```

### Perusoperaatiot
```r
# Aritmeettiset operaatiot
summa <- 5 + 3       # Yhteenlasku: 8
erotus <- 5 - 3      # Vähennyslasku: 2
tulo <- 5 * 3        # Kertolasku: 15
jako <- 5 / 3        # Jakolasku: 1.666667
potenssi <- 5 ^ 2    # Potenssi: 25
jakojaannos <- 5 %% 3  # Jakojäännös: 2
kokonaislukujako <- 5 %/% 3  # Kokonaislukujako: 1

# Loogiset operaatiot
x <- 5
y <- 10
x < y     # Pienempi kuin: TRUE
x > y     # Suurempi kuin: FALSE
x <= y    # Pienempi tai yhtä suuri kuin: TRUE
x >= y    # Suurempi tai yhtä suuri kuin: FALSE
x == y    # Yhtä suuri kuin: FALSE
x != y    # Eri suuri kuin: TRUE
```

### Muuttujan tyyppi ja rakenne
```r
# Muuttujan tyypin tarkistaminen
class(x)      # Palauttaa muuttujan luokan
typeof(x)     # Palauttaa muuttujan tyypin
str(x)        # Näyttää muuttujan rakenteen
length(x)     # Palauttaa muuttujan pituuden
```

## Vektorit

### Vektorin luominen
```r
# Luominen c()-funktiolla (combine)
numerot <- c(1, 2, 3, 4, 5)
nimet <- c("Matti", "Maija", "Pekka")
totuusarvot <- c(TRUE, FALSE, TRUE)

# Luominen sekvenssillä
luvut_1_10 <- 1:10
luvut_10_1 <- 10:1
seq(from = 0, to = 1, by = 0.1)  # 0, 0.1, 0.2, ..., 1
seq(0, 1, length.out = 11)      # 11 tasavälein olevaa arvoa väliltä 0-1

# Toistolla
rep(1, times = 5)               # 1, 1, 1, 1, 1
rep(c(1, 2), times = 3)         # 1, 2, 1, 2, 1, 2
rep(c(1, 2), each = 3)          # 1, 1, 1, 2, 2, 2
```

### Vektorin käsittely
```r
# Vektorista valitseminen (indeksointi)
x <- c(10, 20, 30, 40, 50)
x[1]            # Ensimmäinen alkio: 10 (R:ssä indeksointi alkaa 1:stä!)
x[c(1, 3, 5)]   # Valitut alkiot: 10, 30, 50
x[2:4]          # Alkiot väliltä: 20, 30, 40
x[-1]           # Kaikki paitsi ensimmäinen: 20, 30, 40, 50
x[x > 30]       # Alkiot, jotka ovat suurempia kuin 30: 40, 50

# Vektorin muokkaus
x[1] <- 15      # Muutetaan ensimmäinen alkio 15:ksi
x[x < 30] <- 0  # Muutetaan kaikki alle 30 olevat arvot 0:ksi
```

### Vektorin operaatiot
```r
# Vektorien yhdistäminen
c(c(1, 2), c(3, 4))            # 1, 2, 3, 4

# Vektorien aritmetiikka (tapahtuu alkioittain)
x <- c(1, 2, 3)
y <- c(10, 20, 30)
x + y            # 11, 22, 33
x * y            # 10, 40, 90
x + 1            # 2, 3, 4 (lisätään 1 jokaiseen alkioon)

# Vektorin funktiot
sum(x)           # Summa: 6
mean(x)          # Keskiarvo: 2
median(x)        # Mediaani: 2
min(x)           # Minimi: 1
max(x)           # Maksimi: 3
range(x)         # Minimi ja maksimi: 1, 3
sd(x)            # Keskihajonta (standard deviation)
var(x)           # Varianssi
length(x)        # Vektorin pituus: 3
sort(x)          # Järjestää pienimmästä suurimpaan
rev(x)           # Kääntää järjestyksen: 3, 2, 1
```

## Matriisit

### Matriisin luominen
```r
# Matriisin luominen matrix()-funktiolla
mat <- matrix(1:12, nrow = 3, ncol = 4)  # 3x4 matriisi
mat <- matrix(1:12, nrow = 3)            # Määrittää rivit, sarakkeet automaattisesti
mat <- matrix(1:12, ncol = 4)            # Määrittää sarakkeet, rivit automaattisesti

# Matriisin täyttö tapahtuu oletuksena sarakkeittain
mat <- matrix(1:12, nrow = 3, ncol = 4, byrow = FALSE) # Sarakkeittain (oletus)
mat <- matrix(1:12, nrow = 3, ncol = 4, byrow = TRUE)  # Riveittäin
```

### Matriisin indeksointi
```r
# Matriisin alkioiden valinta
mat <- matrix(1:12, nrow = 3, ncol = 4)
mat[1, 1]       # Rivi 1, sarake 1: 1
mat[2, 3]       # Rivi 2, sarake 3: 8
mat[1, ]        # Koko ensimmäinen rivi: 1, 4, 7, 10
mat[, 2]        # Koko toinen sarake: 2, 5, 8, 11
mat[1:2, 3:4]   # 2x2 osamatriisi (rivit 1-2, sarakkeet 3-4)
```

### Matriisin funktiot
```r
t(mat)           # Transpoosi (vaihtaa rivit ja sarakkeet)
nrow(mat)        # Rivien määrä
ncol(mat)        # Sarakkeiden määrä
dim(mat)         # Dimensiot (rivit, sarakkeet)
colSums(mat)     # Sarakkeiden summat
rowSums(mat)     # Rivien summat
colMeans(mat)    # Sarakkeiden keskiarvot
rowMeans(mat)    # Rivien keskiarvot
```

## Data Frame

### Data Frame -rakenteen luominen
```r
# Data framen luominen
df <- data.frame(
  nimi = c("Matti", "Maija", "Pekka"),
  ika = c(25, 30, 22),
  pituus = c(180, 165, 175)
)

# Toisen data framen luominen
df2 <- data.frame(
  x = 1:5,
  y = c("a", "b", "c", "d", "e"),
  z = c(TRUE, FALSE, TRUE, FALSE, TRUE)
)
```

### Data Framen käsittely
```r
# Sarakkeiden valinta
df$nimi          # Palauttaa nimi-sarakkeen vektorina
df[["nimi"]]     # Sama kuin yllä
df[, "nimi"]     # Sama kuin yllä, mutta data frame -muodossa
df[, 1]          # Ensimmäinen sarake

# Rivien valinta
df[1, ]           # Ensimmäinen rivi
df[df$ika > 25, ] # Rivit, joissa ikä on yli 25

# Sarakkeen lisääminen
df$sukupuoli <- c("mies", "nainen", "mies")

# Rivien ja sarakkeiden määrä
nrow(df)          # Rivien määrä
ncol(df)          # Sarakkeiden määrä
dim(df)           # Dimensiot (rivit, sarakkeet)

# Data framen rakenne
str(df)           # Näyttää rakenteen
head(df, n = 2)   # Näyttää 2 ensimmäistä riviä
tail(df, n = 2)   # Näyttää 2 viimeistä riviä
summary(df)       # Yhteenveto jokaisesta sarakkeesta
```

## Listat

### Listan luominen
```r
# Listan luominen
my_list <- list(
  nimi = "Matti",
  ika = 25,
  pisteet = c(95, 88, 92),
  tiedot = data.frame(pvm = as.Date(c("2023-01-01", "2023-01-02")), 
                      arvo = c(10, 15))
)
```

### Listan käsittely
```r
# Listan elementtien valinta
my_list$nimi                 # Palauttaa "Matti"
my_list[["nimi"]]            # Sama kuin yllä
my_list[[1]]                 # Ensimmäinen elementti
my_list[1]                   # Listan ensimmäinen elementti listana
my_list$pisteet[2]           # Toinen alkio pisteet-vektorista: 88
my_list$tiedot$pvm           # pvm-sarake tiedot-data framesta

# Listan elementtien lisääminen ja muokkaaminen
my_list$uusi <- "Uusi arvo"  # Lisää uuden elementin
my_list$nimi <- "Pekka"      # Muokkaa olemassa olevaa elementtiä
```

## Ehtolauseet

### If-else rakenne
```r
# Perusmuoto
if (ehto) {
  # Koodia, joka suoritetaan jos ehto on totta
} else {
  # Koodia, joka suoritetaan jos ehto on epätotta
}

# Esimerkki
x <- 10
if (x > 5) {
  print("x on suurempi kuin 5")
} else {
  print("x on 5 tai pienempi")
}

# Moniosainen ehtolause
if (x < 0) {
  print("x on negatiivinen")
} else if (x == 0) {
  print("x on nolla")
} else {
  print("x on positiivinen")
}
```

### Vektoroitu if-else
```r
# ifelse-funktio (toimii vektoreilla)
x <- c(-2, 0, 3, 5)
ifelse(x > 0, "positiivinen", "ei-positiivinen")
# Tulos: "ei-positiivinen" "ei-positiivinen" "positiivinen" "positiivinen"
```

## Silmukat

### For-silmukka
```r
# Perusmuoto
for (alkio in kokoelma) {
  # Koodia, joka suoritetaan jokaiselle alkiolle
}

# Esimerkki 1: Numerot
for (i in 1:5) {
  print(paste("Numero:", i))
}

# Esimerkki 2: Vektorin alkiot
nimet <- c("Matti", "Maija", "Pekka")
for (nimi in nimet) {
  print(paste("Hei", nimi))
}
```

### While-silmukka
```r
# Perusmuoto
while (ehto) {
  # Koodia, joka suoritetaan niin kauan kuin ehto on totta
}

# Esimerkki
x <- 1
while (x <= 5) {
  print(x)
  x <- x + 1
}
```

## Funktiot

### Funktion määrittely ja kutsuminen
```r
# Funktion määrittely
tervehdys <- function(nimi) {
  paste("Hei", nimi, "!")
}

# Funktion kutsuminen
tervehdys("Matti")  # Tulos: "Hei Matti !"

# Funktio oletusarvoilla
tervehdys2 <- function(nimi = "maailma") {
  paste("Hei", nimi, "!")
}

tervehdys2()        # Tulos: "Hei maailma !"
tervehdys2("Maija") # Tulos: "Hei Maija !"

# Funktio useilla argumenteilla
laske_summa <- function(a, b) {
  a + b
}

laske_summa(5, 3)   # Tulos: 8
```

### Moniarvoisen funktion palauttaminen
```r
# Listan palauttaminen
tiedot <- function(nimi, ika) {
  list(nimi = nimi, 
       ika = ika, 
       vuosi = 2023 - ika)
}

tulos <- tiedot("Matti", 25)
tulos$nimi   # Tulos: "Matti"
tulos$vuosi  # Tulos: 1998
```

## Datan tuonti ja vienti

### Datan tuonti
```r
# CSV-tiedoston lukeminen
data <- read.csv("tiedosto.csv")
data <- read.csv("tiedosto.csv", sep = ";")  # Käytä puolipistettä erottimena
data <- read.csv("tiedosto.csv", header = TRUE)  # Ensimmäinen rivi on otsikkorivi

# Tekstitiedoston lukeminen
data <- read.table("tiedosto.txt")
data <- read.table("tiedosto.txt", header = TRUE)  # Ensimmäinen rivi on otsikkorivi
data <- read.table("tiedosto.txt", sep = "\t")   # Käytä sarkainta erottimena

# Exceliin tarvitaan readxl-paketti
# install.packages("readxl")
library(readxl)
data <- read_excel("tiedosto.xlsx")
data <- read_excel("tiedosto.xlsx", sheet = "Sheet1")  # Määritä käytettävä taulukko
```

### Datan vienti
```r
# CSV-tiedostoon tallentaminen
write.csv(data, file = "tiedosto.csv")
write.csv(data, file = "tiedosto.csv", row.names = FALSE)  # Ilman rivinumeroita

# Tekstitiedostoon tallentaminen
write.table(data, file = "tiedosto.txt")
write.table(data, file = "tiedosto.txt", sep = "\t")  # Käytä sarkainta erottimena

# Exceliin tarvitaan writexl-paketti
# install.packages("writexl")
library(writexl)
write_xlsx(data, path = "tiedosto.xlsx")
```

## Paketit

### Pakettien asennus ja käyttö
```r
# Paketin asennus
install.packages("dplyr")         # Yhden paketin asennus
install.packages(c("dplyr", "ggplot2"))  # Usean paketin asennus

# Paketin lataaminen käyttöön
library(dplyr)                    # Paketin lataaminen
require(dplyr)                    # Vaihtoehtoinen tapa (palauttaa TRUE/FALSE)

# Paketin funktioiden käyttö
library(dplyr)
df <- data.frame(x = 1:5, y = 6:10)
filter(df, x > 3)                 # dplyr-paketin filter-funktio
select(df, y)                     # dplyr-paketin select-funktio

# Asennettujen pakettien tarkastelu
installed.packages()              # Näyttää kaikki asennetut paketit
```

## Hyödyllisiä vinkkejä

### R:n työympäristö
```r
# Työympäristön hallinta
getwd()                 # Näyttää nykyisen työhakemiston
setwd("/polku/hakemistoon")  # Asettaa työhakemiston

# Objektien hallinta
ls()                    # Näyttää kaikki ympäristön objektit
rm(x)                   # Poistaa objektin x
rm(list = ls())         # Poistaa kaikki objektit ympäristöstä

# Ohje
help(mean)              # Näyttää ohjeen mean-funktiosta
?mean                   # Sama kuin yllä
example(mean)           # Näyttää esimerkkejä mean-funktion käytöstä
```

### Kuvaajien perusteet
```r
# Peruskuvaajat
plot(x, y)               # Hajontakuvio
plot(x)                  # Jos x on vektori, piirtää arvot järjestyksessä
hist(x)                  # Histogrammi
boxplot(x)               # Laatikkokuvaaja
barplot(table(x))        # Pylväsdiagrammi

# ggplot2 (asennus: install.packages("ggplot2"))
library(ggplot2)
ggplot(data = df, aes(x = x, y = y)) +
  geom_point()           # Hajontakuvio ggplot2:lla
```

### Virheenkorjaus
```r
# Yleisiä virheitä
x <- c(1, 2, 3, 4)
x[5]      # Ei anna virhettä, vaan NA (ei olemassa)
x + "a"   # Antaa virheen: ei voi yhdistää numeerista ja merkkijonoa

# Debuggaus
traceback()  # Näyttää funktion kutsuhierarkian virheen jälkeen
debug(myfunc)  # Asettaa debug-moodin päälle funktiolle
browser()    # Asettaa pysäytyspisteen koodissa
options(error = recover)  # Mahdollistaa virhekohdan tarkastelun
```

## Tärkeimmät pakettien käyttökohteet

### Datan käsittely (dplyr)
```r
# install.packages("dplyr")
library(dplyr)

# Perustoiminnot
df <- data.frame(nimi = c("Matti", "Maija", "Pekka"),
                 ika = c(25, 30, 22),
                 kaupunki = c("Helsinki", "Tampere", "Helsinki"))

filter(df, ika > 25)                 # Suodattaa rivit
select(df, nimi, kaupunki)           # Valitsee sarakkeet
arrange(df, ika)                     # Järjestää iän mukaan
mutate(df, syntymavuosi = 2023 - ika)  # Luo uuden sarakkeen
summarise(df, keski_ika = mean(ika))   # Laskee yhteenvedon

# Putkitus (%>%)
df %>%
  filter(ika > 22) %>%
  select(nimi, ika) %>%
  arrange(desc(ika))
```

### Visualisointi (ggplot2)
```r
# install.packages("ggplot2")
library(ggplot2)

# Peruskuvaaja
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# Kuvaajan muokkaus
ggplot(data = mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point() +
  labs(title = "Auton paino ja kulutus",
       x = "Paino (1000 lbs)",
       y = "Kulutus (mpg)",
       color = "Sylinterit") +
  theme_minimal()
```
