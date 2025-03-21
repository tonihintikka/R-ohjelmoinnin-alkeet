# 3. Datan tuonti ja käsittely

Tässä osiossa käsittelemme tietojen tuontia R-ympäristöön eri tiedostomuodoista sekä datan käsittelyyn ja muokkaamiseen liittyviä tekniikoita. Nämä taidot ovat olennainen osa data-analyysiä, sillä usein data vaatii esikäsittelyä ja puhdistusta ennen varsinaista analyysiä.

## 3.1 Datan lukeminen eri tiedostomuodoista

R mahdollistaa datan lukemisen useista eri tiedostomuodoista. Tässä käymme läpi yleisimmät tiedostomuodot ja miten ne luetaan R:ään.

### 3.1.1 CSV-tiedostot (Comma Separated Values)

CSV-tiedostot ovat yleisimpiä tiedostomuotoja datan tallentamiseen. Ne ovat tekstitiedostoja, joissa arvot on erotettu toisistaan pilkuilla.

```r
# Peruslukeminen CSV-tiedostosta
data <- read.csv("tiedosto.csv")

# Parametreja, joita usein tarvitaan:
data <- read.csv("tiedosto.csv", 
                 header = TRUE,     # Ensimmäinen rivi on otsikkorivi
                 sep = ",",         # Erotin (CSV-tiedostoissa pilkku)
                 dec = ".",         # Desimaalien erotin
                 stringsAsFactors = FALSE)  # Älä muunna merkkijonoja factoreiksi

# Jos tiedosto käyttää puolipistettä erottimena (yleistä Euroopassa)
data <- read.csv2("tiedosto.csv")  # Käyttää puolipistettä erottimena ja pilkkua desimaalierottimena
```

Vaihtoehtoisia tapoja lukea CSV-tiedostoja ovat:

```r
# Base R -vaihtoehtoja
data <- read.table("tiedosto.csv", header = TRUE, sep = ",")

# readr-paketin read_csv on nopeampi vaihtoehto
library(readr)
data <- read_csv("tiedosto.csv")
```

### 3.1.2 Excel-tiedostot

Excel-tiedostojen lukemiseen tarvitaan erillinen paketti, kuten `readxl`.

```r
# Asennetaan readxl-paketti (tarvitsee tehdä vain kerran)
install.packages("readxl")

# Ladataan paketti
library(readxl)

# Luetaan Excel-tiedosto
data <- read_excel("tiedosto.xlsx")

# Voit määrittää luettavan välilehden nimellä
data <- read_excel("tiedosto.xlsx", sheet = "Taulukko1")

# ...tai numerolla
data <- read_excel("tiedosto.xlsx", sheet = 1)

# Voit myös määrittää luettavan alueen
data <- read_excel("tiedosto.xlsx", range = "A1:C10")
```

### 3.1.3 Tekstitiedostot

Tekstitiedostojen lukemiseen voidaan käyttää `read.table()`-funktiota.

```r
# Perusmuotoinen tekstitiedosto (välilyönnillä erotettu)
data <- read.table("tiedosto.txt", header = TRUE)

# Välilehdellä erotettu tekstitiedosto (TSV)
data <- read.table("tiedosto.tsv", header = TRUE, sep = "\t")

# Mukautetut erottimet
data <- read.table("tiedosto.txt", header = TRUE, sep = ";")
```

### 3.1.4 R-datatiedostot (.RData, .rds)

R-datatiedostot ovat R:n omia tiedostomuotoja, jotka säilyttävät R-objektien rakenteen.

```r
# Tallentaminen
save(data, file = "data.RData")  # Tallentaa yhden tai useamman objektin
saveRDS(data, file = "data.rds")  # Tallentaa yhden objektin

# Lataaminen
load("data.RData")  # Lataa objektit niiden alkuperäisillä nimillä
data <- readRDS("data.rds")  # Lataa objektin ja voit antaa sille uuden nimen
```

### 3.1.5 Muut tiedostomuodot

R-yhteisö on kehittänyt paketteja lähes kaikille tiedostomuodoille:

```r
# JSON-tiedostot
library(jsonlite)
data <- fromJSON("tiedosto.json")

# XML-tiedostot
library(XML)
data <- xmlParse("tiedosto.xml")

# SPSS, SAS, Stata -tiedostot
library(haven)
data <- read_spss("tiedosto.sav")
data <- read_sas("tiedosto.sas7bdat")
data <- read_stata("tiedosto.dta")

# Tietokantayhteydet
library(DBI)
library(RSQLite)
con <- dbConnect(SQLite(), "tietokanta.db")
data <- dbGetQuery(con, "SELECT * FROM taulu")
dbDisconnect(con)
```

### 3.1.6 Datan lukeminen verkosta

Voit lukea dataa suoraan verkko-osoitteesta:

```r
# CSV-tiedosto verkosta
data <- read.csv("https://example.com/data.csv")

# Excel-tiedosto verkosta (täytyy ensin ladata)
temp <- tempfile()
download.file("https://example.com/data.xlsx", temp)
data <- read_excel(temp)
unlink(temp)  # Poistetaan väliaikaistiedosto
```

## 3.2 Datan esikäsittely ja puhdistus

Usein data vaatii esikäsittelyä ja puhdistusta ennen analyysiä. Tässä yleisimpiä toimenpiteitä:

### 3.2.1 Datan rakenteen tarkastelu

Ennen käsittelyä on hyvä tarkastella datan rakennetta.

```r
# Perustarkasteluita
head(data)  # Näyttää ensimmäiset 6 riviä
tail(data)  # Näyttää viimeiset 6 riviä
str(data)   # Näyttää muuttujien tyypit ja rakenteen
summary(data)  # Tilastollinen yhteenveto datasta
dim(data)   # Rivien ja sarakkeiden määrä

# Sarakkeiden nimet
names(data)  # Näyttää sarakkeiden nimet
colnames(data)  # Sama kuin yllä

# Tarkistetaan puuttuvat arvot
sum(is.na(data))  # Puuttuvien arvojen kokonaismäärä
colSums(is.na(data))  # Puuttuvien arvojen määrä sarakkeittain
```

### 3.2.2 Datan tyyppien muuntaminen

Usein dataa lukiessa muuttujien tyypit eivät ole optimaalisia.

```r
# Muunnetaan sarake numeeriseksi
data$ikä <- as.numeric(data$ikä)

# Muunnetaan sarake tekstiksi
data$nimi <- as.character(data$nimi)

# Muunnetaan sarake päivämääräksi
data$päivämäärä <- as.Date(data$päivämäärä, format = "%Y-%m-%d")

# Luokkamuuttujien käsittely
data$sukupuoli <- as.factor(data$sukupuoli)
data$ryhmä <- factor(data$ryhmä, levels = c("Alhainen", "Keskitaso", "Korkea"), 
                    ordered = TRUE)
```

### 3.2.3 Tietojen tarkistus ja validointi

Tarkistetaan epäjohdonmukaisuuksia ja virheitä:

```r
# Tarkistetaan arvoja
range(data$ikä, na.rm = TRUE)  # Min ja max
unique(data$sukupuoli)  # Uniikit arvot
table(data$sukupuoli)   # Frekvenssijakauma

# Tarkistetaan epäjohdonmukaisuuksia
summary(data$tulot)  # Onko tulot järkevissä rajoissa?
boxplot(data$tulot)  # Visualisoidaan jakauma poikkeavien havaintojen löytämiseksi

# Tarkistetaan duplikaatit
sum(duplicated(data))  # Duplikaattirivien määrä
```

### 3.2.4 Tietojen siistiminen ja standardointi

```r
# Poistetaan ylimääräiset välilyönnit tekstistä
data$nimi <- trimws(data$nimi)

# Muunnetaan teksti pieneksi kirjaimiksi
data$nimi <- tolower(data$nimi)

# Standardoidaan jatkuvat muuttujat (keskiarvo 0, keskihajonta 1)
data$tulot_std <- scale(data$tulot)

# Poistetaan duplikaatit
data_unique <- unique(data)  # Poistetaan täydelliset duplikaatit
```

## 3.3 Puuttuvien arvojen käsittely

Puuttuvat arvot (NA) ovat yleinen ongelma data-analyysissä.

### 3.3.1 Puuttuvien arvojen tunnistaminen

```r
# Tarkistetaan puuttuvat arvot
is.na(data)  # Palauttaa TRUE/FALSE -matriisin
sum(is.na(data))  # Puuttuvien arvojen kokonaismäärä
colSums(is.na(data))  # Puuttuvien arvojen määrä sarakkeittain

# Visualisoidaan puuttuvat arvot (tarvitsee mice-paketin)
library(mice)
md.pattern(data)

# Tai visuaalisesti VIM-paketilla
library(VIM)
aggr(data)
```

### 3.3.2 Rivien tai sarakkeiden poistaminen puuttuvien arvojen perusteella

```r
# Poistetaan rivit, joissa on puuttuvia arvoja (vain täydelliset rivit)
data_complete <- na.omit(data)

# Poistetaan tietyt sarakkeet, joissa on liian paljon puuttuvia arvoja
drop_cols <- names(data)[colSums(is.na(data))/nrow(data) > 0.5]  # Sarakkeet, joissa yli 50% puuttuu
data_filtered <- data[, !names(data) %in% drop_cols]
```

### 3.3.3 Puuttuvien arvojen korvaaminen (imputointi)

```r
# Yksinkertainen korvaaminen keskiarvolla
data$ikä[is.na(data$ikä)] <- mean(data$ikä, na.rm = TRUE)

# Mediaanilla korvaaminen
data$tulot[is.na(data$tulot)] <- median(data$tulot, na.rm = TRUE)

# Luokkamuuttujien korvaaminen moodilla
most_frequent <- names(sort(table(data$sukupuoli), decreasing = TRUE))[1]
data$sukupuoli[is.na(data$sukupuoli)] <- most_frequent

# Kehittyneempi imputointi mice-paketilla
library(mice)
imputed_data <- mice(data, m = 5, method = "pmm")
data_complete <- complete(imputed_data)
```

## 3.4 Datan suodattaminen

Datan suodattaminen on keskeinen osa analyysiä, kun halutaan keskittyä tiettyyn osajoukkoon.

### 3.4.1 Rivien suodattaminen ehtojen perusteella

```r
# Perussuodatus yhden ehdon perusteella
nuoret <- data[data$ikä < 30, ]

# Useamman ehdon yhdistäminen
nuoret_naiset <- data[data$ikä < 30 & data$sukupuoli == "nainen", ]

# TAI-operaatio
helsinki_turku <- data[data$kaupunki == "Helsinki" | data$kaupunki == "Turku", ]

# Suodatus IN-tyyppisesti
tietyt_kaupungit <- data[data$kaupunki %in% c("Helsinki", "Turku", "Tampere"), ]

# Suodatus funktioilla
korkeatuloiset <- data[data$tulot > median(data$tulot, na.rm = TRUE), ]
```

### 3.4.2 Sarakkeiden valinta ja poisto

```r
# Valitaan tietyt sarakkeet
vain_tiedot <- data[, c("nimi", "ikä", "sukupuoli")]

# Poistetaan sarake
data$turha_sarake <- NULL

# Valitaan sarakkeet nimien perusteella
valitaan_kaikki_paitsi <- data[, !names(data) %in% c("turha_sarake", "toinen_turha")]
```

### 3.4.3 Sarakkeiden uudelleennimeäminen

```r
# Yksittäisen sarakkeen uudelleennimeäminen
names(data)[names(data) == "vanha_nimi"] <- "uusi_nimi"

# Useiden sarakkeiden uudelleennimeäminen
vanha_uusi <- c("nimi" = "koko_nimi", "ikä" = "ikä_vuosina")
names(data)[match(names(vanha_uusi), names(data))] <- vanha_uusi
```

## 3.5 Uusien muuttujien luominen

Usein analyysissa tarvitaan alkuperäisestä datasta johdettuja muuttujia.

### 3.5.1 Yksinkertaisten muuttujien luominen

```r
# Luodaan uusi muuttuja laskutoimituksella
data$ikä_kuukausina <- data$ikä * 12

# Luodaan luokiteltu muuttuja
data$ikäluokka <- cut(data$ikä, 
                     breaks = c(0, 18, 30, 50, 100),
                     labels = c("Alaikäinen", "Nuori aikuinen", "Keski-ikäinen", "Seniori"))

# Luodaan dummy-muuttuja (0/1)
data$on_alaikäinen <- ifelse(data$ikä < 18, 1, 0)
```

### 3.5.2 Merkkijonojen käsittely

```r
# Yhdistetään kaksi saraketta
data$koko_nimi <- paste(data$etunimi, data$sukunimi, sep = " ")

# Erotellaan merkkijono osiin
nimi_osat <- strsplit(data$koko_nimi, " ")

# Otetaan osa merkkijonosta
data$nimikirjaimet <- substr(data$etunimi, 1, 1)

# Etsitään merkkijonoja
data$on_gmail <- grepl("@gmail.com", data$sähköposti)
```

### 3.5.3 Päivämäärien käsittely

```r
# Luodaan ikä syntymäajasta
data$syntymäaika <- as.Date(data$syntymäaika)
data$ikä <- as.numeric(difftime(Sys.Date(), data$syntymäaika, units = "days") / 365.25)

# Erotellaan päivämäärän osat
data$vuosi <- format(data$päivämäärä, "%Y")
data$kuukausi <- format(data$päivämäärä, "%m")
data$päivä <- format(data$päivämäärä, "%d")
data$viikonpäivä <- weekdays(data$päivämäärä)

# Lasketaan päivien lukumäärä kahden päivämäärän välillä
data$päiviä_välissä <- as.numeric(difftime(data$loppupvm, data$alkupvm, units = "days"))
```

### 3.5.4 Ryhmittäiset laskelmat

```r
# Lasketaan keskiarvo ryhmittäin
keskiarvot <- aggregate(data$tulot, by = list(data$sukupuoli), FUN = mean, na.rm = TRUE)

# Useampi laskutoimitus kerralla
yhteenvedot <- aggregate(. ~ sukupuoli, data = data[, c("tulot", "ikä", "sukupuoli")], 
                        FUN = function(x) c(keskiarvo = mean(x, na.rm = TRUE), 
                                           mediaani = median(x, na.rm = TRUE)))
```

## 3.6 Datan yhdistäminen ja muuntaminen

### 3.6.1 Dataframien yhdistäminen

```r
# Rivien yhdistäminen (tarvitsee samat sarakkeet)
yhdistetty <- rbind(data1, data2)

# Sarakkeiden yhdistäminen (tarvitsee saman määrän rivejä)
yhdistetty <- cbind(data1, data2)

# Yhdistäminen (join) yhteisen avaimen perusteella
# Inner join - vain matchaavat rivit
yhdistetty <- merge(data1, data2, by = "id")

# Left join - kaikki data1:n rivit
yhdistetty <- merge(data1, data2, by = "id", all.x = TRUE)

# Right join - kaikki data2:n rivit
yhdistetty <- merge(data1, data2, by = "id", all.y = TRUE)

# Full join - kaikki rivit molemmista
yhdistetty <- merge(data1, data2, by = "id", all = TRUE)

# Jos avainten nimet eroavat taulukoissa
yhdistetty <- merge(data1, data2, by.x = "id1", by.y = "id2")
```

### 3.6.2 Datan muuntaminen pitkästä leveään muotoon ja takaisin

```r
# Asennetaan reshape2-paketti
install.packages("reshape2")
library(reshape2)

# Leveästä pitkään (wide to long)
data_long <- melt(data_wide, 
                 id.vars = c("id", "sukupuoli"),  # Nämä pysyvät samoina
                 measure.vars = c("testi1", "testi2", "testi3"),  # Nämä muuttuvat
                 variable.name = "testi",
                 value.name = "tulos")

# Pitkästä leveään (long to wide)
data_wide <- dcast(data_long, id + sukupuoli ~ testi, value.var = "tulos")
```

### 3.6.3 Datan järjestäminen

```r
# Järjestetään yhden sarakkeen perusteella (nousevasti)
data_sorted <- data[order(data$ikä), ]

# Järjestetään laskevasti
data_sorted <- data[order(-data$ikä), ]

# Järjestetään useamman sarakkeen perusteella
data_sorted <- data[order(data$sukupuoli, -data$tulot), ]
```

## 3.7 Datan tallentaminen

Käsitelty data voidaan tallentaa eri muodoissa:

```r
# CSV-tiedostoksi
write.csv(data, "käsitelty_data.csv", row.names = FALSE)

# Tab-erotetuksi tekstitiedostoksi
write.table(data, "käsitelty_data.txt", sep = "\t", row.names = FALSE)

# Excel-tiedostoksi
library(writexl)
write_xlsx(data, "käsitelty_data.xlsx")

# R-tiedostomuodoksi (säilyttää kaikki datarakenteet)
saveRDS(data, "käsitelty_data.rds")
save(data, file = "käsitelty_data.RData")
```

## 3.8 Kehittyneemmät paketit datan käsittelyyn

### 3.8.1 dplyr-paketti (osa tidyverse-kokoelmaa)

```r
# Asennetaan ja ladataan paketti
install.packages("dplyr")
library(dplyr)

# Perustoiminnot dplyr:llä
data %>%
  filter(ikä >= 18) %>%  # Suodatus
  select(nimi, ikä, sukupuoli) %>%  # Sarakkeiden valinta
  mutate(ikä_kk = ikä * 12) %>%  # Uuden sarakkeen luonti
  arrange(desc(ikä)) %>%  # Järjestäminen
  group_by(sukupuoli) %>%  # Ryhmittely
  summarise(keski_ikä = mean(ikä), mediaani_ikä = median(ikä))  # Yhteenveto
```

### 3.8.2 data.table-paketti

```r
# Asennetaan ja ladataan paketti
install.packages("data.table")
library(data.table)

# Muunnetaan data.table-muotoon
DT <- as.data.table(data)

# Perustoiminnot data.table-syntaksilla
DT[ikä >= 18,  # Suodatus (i)
   .(nimi, ikä, ikä_kk = ikä * 12),  # Valinta ja uusi sarake (j)
   by = sukupuoli]  # Ryhmittely (by)
```

## 3.9 Harjoituksia

1. Lataa esimerkkitiedosto ja tarkastele sen rakennetta ja sisältöä.
2. Tarkista onko datassa puuttuvia arvoja ja käsittele ne sopivalla tavalla.
3. Luo esimerkkidataan 2-3 uutta muuttujaa alkuperäisten perusteella.
4. Suodata datasta tietty osajoukko ja tee sille yhteenvetolaskelmia.
5. Tallenna käsitelty data uuteen tiedostoon.

## 3.10 Yhteenveto

Tässä osiossa olemme oppineet:

- Lukemaan dataa eri tiedostomuodoista R:ään
- Tarkastelemaan ja puhdistamaan dataa
- Käsittelemään puuttuvia arvoja
- Suodattamaan dataa eri kriteerien perusteella
- Luomaan uusia muuttujia
- Yhdistämään ja muuntamaan dataa
- Tallentamaan käsitellyn datan

Nämä taidot muodostavat perustan tehokkaalle data-analyysille R-ympäristössä. Seuraavissa osioissa jatkamme datan visualisointiin ja tilastollisiin analyyseihin.
