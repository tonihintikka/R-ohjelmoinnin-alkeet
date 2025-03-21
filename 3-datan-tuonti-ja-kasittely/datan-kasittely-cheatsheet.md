# R Datan käsittelyn cheatsheet

## Datan tuonti

### CSV-tiedostot

```r
# Peruslukeminen
data <- read.csv("tiedosto.csv")

# Lisäasetuksilla
data <- read.csv("tiedosto.csv", 
                 header = TRUE,              # Ensimmäinen rivi on otsikkorivi
                 sep = ",",                  # Erotin (CSV-tiedostoissa pilkku)
                 dec = ".",                  # Desimaalien erotin
                 na.strings = c("NA", ""),   # Mitkä arvot tulkitaan NA:ksi
                 stringsAsFactors = FALSE)   # Älä muunna merkkijonoja factoreiksi

# Eurooppalainen tyyli (puolipiste erottimena, pilkku desimaalierottimena)
data <- read.csv2("tiedosto.csv")
```

### Excel-tiedostot

```r
library(readxl)

# Peruslukeminen
data <- read_excel("tiedosto.xlsx")

# Tietty välilehti
data <- read_excel("tiedosto.xlsx", sheet = "Taulukko1")
data <- read_excel("tiedosto.xlsx", sheet = 2)  # Indeksillä (1-pohjainen)

# Tietty alue
data <- read_excel("tiedosto.xlsx", range = "A1:D10")
```

### Tekstitiedostot

```r
# Perusmuotoinen tekstitiedosto
data <- read.table("tiedosto.txt", header = TRUE)

# Välilehdellä erotettu
data <- read.table("tiedosto.tsv", header = TRUE, sep = "\t")

# Mukautettu erotin
data <- read.table("tiedosto.txt", header = TRUE, sep = ";")
```

### R-datatiedostot

```r
# Lukeminen
load("data.RData")             # Lataa objektit alkuperäisillä nimillä
data <- readRDS("data.rds")    # Lataa yhden objektin

# Tallentaminen
save(data1, data2, file = "data.RData")  # Tallentaa useita objekteja
saveRDS(data, file = "data.rds")         # Tallentaa yhden objektin
```

### Muut tiedostomuodot

```r
# JSON
library(jsonlite)
data <- fromJSON("tiedosto.json")

# XML
library(XML)
data <- xmlParse("tiedosto.xml")

# SPSS, SAS, Stata
library(haven)
data <- read_spss("tiedosto.sav")
data <- read_sas("tiedosto.sas7bdat")
data <- read_stata("tiedosto.dta")
```

## Datan rakenne ja tarkastelu

```r
# Perustarkastelut
head(data)       # Ensimmäiset 6 riviä
tail(data)       # Viimeiset 6 riviä
str(data)        # Rakenteen tarkastelu
summary(data)    # Yhteenveto datasta
dim(data)        # Rivien ja sarakkeiden määrä (taulukkomuodossa)
nrow(data)       # Rivien määrä
ncol(data)       # Sarakkeiden määrä
colnames(data)   # Sarakkeiden nimet
names(data)      # Sama kuin yllä

# Puuttuvien arvojen tarkastelu
is.na(data)                 # Palauttaa TRUE/FALSE matriisin
sum(is.na(data))            # Puuttuvien arvojen kokonaismäärä
colSums(is.na(data))        # Puuttuvien arvojen määrä sarakkeittain
rowSums(is.na(data))        # Puuttuvien arvojen määrä riveittäin
complete.cases(data)        # Palauttaa TRUE jokaiselle riville, jolla ei ole NA-arvoja
```

## Datan tyyppien muuntaminen

```r
# Perustyypit
as.numeric(x)       # Muunna numeeriseksi
as.character(x)     # Muunna merkkijonoksi
as.logical(x)       # Muunna loogiseksi (TRUE/FALSE)
as.factor(x)        # Muunna faktoriksi (kategoriseksi)
as.Date(x)          # Muunna päivämääräksi

# Päivämäärät
as.Date("2023-05-15")                   # ISO-muoto toimii oletuksena
as.Date("15.5.2023", format = "%d.%m.%Y")  # Mukautettu muoto
as.Date("05/15/2023", format = "%m/%d/%Y") # Amerikkalainen muoto
```

## Datan suodattaminen

```r
# Yksinkertainen suodatus
naiset <- data[data$sukupuoli == "nainen", ]

# Useita ehtoja (AND-operaattori)
nuoret_naiset <- data[data$sukupuoli == "nainen" & data$ikä < 30, ]

# Useita ehtoja (OR-operaattori)
nuoret_tai_vanhat <- data[data$ikä < 30 | data$ikä > 60, ]

# Arvo kuuluu joukkoon
tietyt_kaupungit <- data[data$kaupunki %in% c("Helsinki", "Tampere", "Turku"), ]

# Sarakkeiden valinta
vain_nimi_ikä <- data[, c("nimi", "ikä")]

# Rivien ja sarakkeiden valinta
nuoret_nimi_ikä <- data[data$ikä < 30, c("nimi", "ikä")]

# Negatiivinen indeksointi (poissulkeminen)
ilman_idt <- data[, -which(names(data) == "id")]
```

## Puuttuvien arvojen käsittely

```r
# Rivien poistaminen, joissa on puuttuvia arvoja
data_complete <- na.omit(data)

# Korvaaminen keskiarvolla (numeeriset sarakkeet)
data$ikä[is.na(data$ikä)] <- mean(data$ikä, na.rm = TRUE)

# Korvaaminen mediaanilla
data$tulot[is.na(data$tulot)] <- median(data$tulot, na.rm = TRUE)

# Korvaaminen moodilla (yleisin arvo)
moodi <- function(x) {
  tbl <- table(x)
  names(tbl)[which.max(tbl)]
}
data$kaupunki[is.na(data$kaupunki)] <- moodi(data$kaupunki)

# Edistynyt imputointi mice-paketilla
library(mice)
imp <- mice(data, method = "pmm")
data_imp <- complete(imp)
```

## Uusien muuttujien luominen

```r
# Aritmeettinen laskutoimitus
data$tulot_kk <- data$tulot_vuosi / 12

# Ehdollinen uusi muuttuja
data$ikäluokka <- ifelse(data$ikä < 18, "Alaikäinen", 
                        ifelse(data$ikä < 65, "Työikäinen", "Eläkeläinen"))

# Luokitteleva muuttuja
data$tuloluokka <- cut(data$tulot, 
                      breaks = c(0, 2000, 4000, Inf), 
                      labels = c("Matala", "Keskitaso", "Korkea"))

# Merkkijonojen yhdistäminen
data$koko_nimi <- paste(data$etunimi, data$sukunimi)

# Päivämääristä johdetut muuttujat
data$vuosi <- format(data$päivämäärä, "%Y")
data$kuukausi <- format(data$päivämäärä, "%m")
data$viikonpäivä <- weekdays(data$päivämäärä)

# Aikaero
data$ikä <- as.numeric(difftime(Sys.Date(), data$syntymäpäivä, units = "days") / 365.25)
```

## Datan järjestäminen

```r
# Järjestä yhden sarakkeen mukaan (nousevasti)
data_järjestetty <- data[order(data$ikä), ]

# Järjestä laskevasti
data_järjestetty <- data[order(-data$ikä), ]

# Järjestä usean sarakkeen mukaan
data_järjestetty <- data[order(data$sukupuoli, -data$ikä), ]
```

## Datan yhdistäminen

```r
# Rivien yhdistäminen (sama rakenne)
kaikki_data <- rbind(data1, data2)

# Sarakkeiden yhdistäminen (sama pituus)
laaja_data <- cbind(data1, data2)

# Yhdistäminen yhteisen avaimen perusteella

# Inner join - vain matchaavat rivit
yhdistetty <- merge(data1, data2, by = "id")

# Left join - kaikki data1:n rivit
yhdistetty <- merge(data1, data2, by = "id", all.x = TRUE)

# Right join - kaikki data2:n rivit
yhdistetty <- merge(data1, data2, by = "id", all.y = TRUE)

# Full join - kaikki rivit molemmista
yhdistetty <- merge(data1, data2, by = "id", all = TRUE)

# Yhdistäminen usean avaimen perusteella
yhdistetty <- merge(data1, data2, by = c("id", "vuosi"))

# Yhdistäminen, kun avainten nimet eroavat
yhdistetty <- merge(data1, data2, by.x = "data1_id", by.y = "data2_id")
```

## Datan muuntaminen (Reshape)

### Leveästä pitkään muotoon

```r
# Base R:n reshape
pitkä_data <- reshape(leveä_data, 
                      direction = "long",
                      varying = list(c("tammi", "helmi", "maalis")),
                      v.names = "arvo",
                      idvar = c("id", "nimi"),
                      timevar = "kuukausi",
                      times = c("tammi", "helmi", "maalis"))

# reshape2-paketti
library(reshape2)
pitkä_data <- melt(leveä_data, 
                  id.vars = c("id", "nimi"),
                  measure.vars = c("tammi", "helmi", "maalis"),
                  variable.name = "kuukausi",
                  value.name = "arvo")

# tidyr-paketti
library(tidyr)
pitkä_data <- pivot_longer(leveä_data,
                          cols = c(tammi, helmi, maalis),
                          names_to = "kuukausi",
                          values_to = "arvo")
```

### Pitkästä leveään muotoon

```r
# Base R:n reshape
leveä_data <- reshape(pitkä_data, 
                      direction = "wide",
                      idvar = c("id", "nimi"),
                      timevar = "kuukausi")

# reshape2-paketti
library(reshape2)
leveä_data <- dcast(pitkä_data, 
                   id + nimi ~ kuukausi, 
                   value.var = "arvo")

# tidyr-paketti
library(tidyr)
leveä_data <- pivot_wider(pitkä_data,
                         names_from = "kuukausi",
                         values_from = "arvo")
```

## Ryhmittely ja aggregointi

```r
# Yksinkertainen aggregointi
keskiarvot <- aggregate(ikä ~ sukupuoli, data = data, FUN = mean)

# Useita laskutoimituksia samalla kertaa
yhteenveto <- aggregate(cbind(ikä, tulot) ~ sukupuoli, 
                       data = data, 
                       FUN = function(x) c(keskiarvo = mean(x), mediaani = median(x)))

# Useita yhdistettyjä ryhmittelyehtoja
alueittain_sukupuolittain <- aggregate(tulot ~ alue + sukupuoli, 
                                      data = data, 
                                      FUN = mean)

# Useita funktioita tapply:n avulla
tapply(data$tulot, data$sukupuoli, function(x) c(mediaani = median(x), keskiarvo = mean(x)))
```

## Ristiintaulukointi

```r
# Perus ristiintaulukko
taulukko <- table(data$sukupuoli, data$ikäluokka)

# Kontingenssitaulun suhteelliset frekvenssit
prop.table(taulukko)                # Kaikista
prop.table(taulukko, margin = 1)    # Riveittäin
prop.table(taulukko, margin = 2)    # Sarakkeittain

# xtabs-funktio
xtabs(~ sukupuoli + ikäluokka, data = data)
```

## Datan tallentaminen

```r
# CSV-tiedostoksi
write.csv(data, "tiedosto.csv", row.names = FALSE)

# Tab-erotetuksi tekstitiedostoksi
write.table(data, "tiedosto.txt", sep = "\t", row.names = FALSE)

# Excel-tiedostoksi
library(writexl)
write_xlsx(data, "tiedosto.xlsx")

# R-tiedostomuodoksi
saveRDS(data, "data.rds")
save(data, file = "data.RData")
```

## Merkkijonojen käsittely

```r
# Merkkijonojen yhdistäminen
paste("Hello", "World")               # "Hello World"
paste("Hello", "World", sep = "-")    # "Hello-World"
paste0("Hello", "World")              # "HelloWorld"

# Osajonon poimiminen
substr("HelloWorld", 1, 5)            # "Hello"

# Kirjainkoon muuttaminen
toupper("hello")                      # "HELLO"
tolower("HELLO")                      # "hello"

# Välilyöntien poistaminen
trimws("  hello  ")                   # "hello"

# Merkkien korvaaminen
gsub("l", "x", "hello")               # "hexxo"

# Merkkijonon jakaminen osiin
strsplit("hello,world", ",")          # lista: "hello" "world"

# Merkkijonon pituus
nchar("hello")                        # 5
```

## Päivämäärien käsittely

```r
# Päivämäärän muuntaminen merkkijonoksi
format(Sys.Date(), "%d.%m.%Y")        # esim. "21.03.2023"

# Päivämäärän osat
format(Sys.Date(), "%Y")              # Vuosi, esim. "2023"
format(Sys.Date(), "%m")              # Kuukausi, esim. "03"
format(Sys.Date(), "%d")              # Päivä, esim. "21"
format(Sys.Date(), "%A")              # Viikonpäivä, esim. "maanantai"

# Päivämäärien vertailu
as.Date("2023-03-21") > as.Date("2023-03-15")  # TRUE

# Päivämäärän laskutoimitukset
as.Date("2023-03-21") - as.Date("2023-03-15")  # Time difference of 6 days
as.Date("2023-03-21") + 7                      # "2023-03-28"

# POSIXct ja POSIXlt muodot (päivämäärä + aika)
aika <- as.POSIXct("2023-03-21 14:30:00")      # Päivämäärä ja kellonaika
format(aika, "%H:%M:%S")                       # "14:30:00"
```

## dplyr-paketti (tidyverse)

```r
library(dplyr)

# Filter - suodatus
tulos <- data %>% filter(ikä >= 18, sukupuoli == "nainen")

# Select - sarakkeiden valinta
tulos <- data %>% select(nimi, ikä, sukupuoli)

# Mutate - uusien sarakkeiden luominen
tulos <- data %>% mutate(tulot_kk = tulot_vuosi / 12)

# Arrange - järjestäminen
tulos <- data %>% arrange(desc(ikä))

# Group_by - ryhmittely
tulos <- data %>% group_by(sukupuoli)

# Summarise - yhteenveto
tulos <- data %>% 
  group_by(sukupuoli) %>%
  summarise(keski_ikä = mean(ikä), 
            mediaani_tulot = median(tulot))

# Join - datan yhdistäminen
tulos <- data1 %>% left_join(data2, by = "id")
```

## tidyr-paketti (tidyverse)

```r
library(tidyr)

# Pitkästä leveään (pivot_wider)
tulos <- data %>% 
  pivot_wider(names_from = kuukausi, values_from = arvo)

# Leveästä pitkään (pivot_longer)
tulos <- data %>% 
  pivot_longer(cols = c(tammi, helmi, maalis), 
               names_to = "kuukausi", 
               values_to = "arvo")

# Käsittele puuttuvia arvoja
tulos <- data %>% drop_na()              # Poista NA-rivit
tulos <- data %>% fill(x)                # Täytä NA-arvot edellisellä ei-NA arvolla
```

## data.table-paketti

```r
library(data.table)

# Muunna data.table-muotoon
DT <- as.data.table(data)

# Perussyntaksi: DT[i, j, by], missä:
# i = mitä rivejä valitaan
# j = mitä tehdään valituille riveille
# by = ryhmittely

# Esimerkkejä:
DT[ikä > 30]                                  # Suodatus
DT[, .(nimi, ikä)]                            # Sarakkeiden valinta
DT[, uusi_sarake := ikä * 2]                  # Uusi sarake
DT[, .(keski_ikä = mean(ikä)), by = sukupuoli] # Ryhmittely ja aggregointi
```

## Muita hyödyllisiä vinkkejä

```r
# Duplikaattien tunnistaminen ja poistaminen
duplicated(data)         # TRUE/FALSE vektori duplikaattiriveistä
!duplicated(data)        # TRUE/FALSE vektori uniikkiriveistä
unique(data)             # Vain uniikit rivit

# Satunnainen otanta
set.seed(123)            # Aseta siemen toistettavuuden vuoksi
sample(data$ikä, 5)      # 5 satunnaista ikää
sample(1:nrow(data), 10) # 10 satunnaisen rivin indeksit
data[sample(1:nrow(data), 10), ]  # 10 satunnaista riviä

# Lukujen pyöristäminen
round(3.14159, 2)        # 3.14
floor(3.7)               # 3 (pyöristys alaspäin)
ceiling(3.2)             # 4 (pyöristys ylöspäin)
```
