# 3. R-kielen perusteet

Tässä osiossa tutustutaan R-kielen perusrakenteisiin ja -käsitteisiin, jotka ovat olennaisia R-ohjelmoinnin oppimisessa. Käymme läpi muuttujia, perustietotyyppejä, operaattoreita ja muita keskeisiä R-kielen ominaisuuksia.

## Muuttujat ja arvon asettaminen

Muuttujat ovat nimettyä tallennustilaa, johon voit tallentaa dataa myöhempää käyttöä varten. R-kielessä muuttujan nimessä voi olla kirjaimia, numeroita, pisteitä (.) ja alaviivoja (_), mutta se ei voi alkaa numerolla.

### Muuttujan luominen

Muuttuja luodaan antamalla sille nimi ja asettamalla sille arvo. R-kielessä arvo asetetaan yleensä käyttämällä `<-` operaattoria:

```r
# Luodaan muuttuja x ja asetetaan sen arvoksi 5
x <- 5

# Tulostetaan muuttujan arvo
print(x)  # tai yksinkertaisesti x

# Vaihtoehtoiset tavat arvon asettamiseen
x = 5     # Toimii, mutta <- on suositellumpi
5 -> x    # Toimii myös, mutta harvemmin käytetty
```

### Muuttujien nimeäminen

Hyvät muuttujien nimet ovat kuvaavia ja johdonmukaisia:

```r
# Hyviä muuttujien nimiä
ikä <- 30
henkilön_nimi <- "Matti"
keskiarvo_testi1 <- 85.5

# Huonompia muuttujien nimiä
a <- 30                   # Ei kuvaava
HenkilönNimi <- "Matti"   # Epäjohdonmukainen tyyli
keskiarvo.testi.1 <- 85.5 # Pisteet voivat joskus aiheuttaa sekaannusta
```

R on merkkikokoriippuvainen (case-sensitive) kieli, joten `ikä` ja `Ikä` ovat eri muuttujia.

## Perustietotyypit

R-kielessä on useita perustietotyyppejä:

### 1. Numeeriset tietotyypit

#### Kokonaisluvut (integer)
```r
x <- 5L       # L-kirjain kertoo, että kyseessä on kokonaisluku
typeof(x)     # "integer"
```

#### Desimaaliluvut (double)
```r
y <- 5.5      # Desimaaliluvut ovat oletuksena double-tyyppiä
typeof(y)     # "double"
```

### 2. Merkkijonot (character)
```r
nimi <- "Matti"
sukunimi <- 'Virtanen'  # Voit käyttää joko " tai ' merkkejä
typeof(nimi)           # "character"

# Merkkijonojen yhdistäminen
koko_nimi <- paste(nimi, sukunimi)
koko_nimi              # "Matti Virtanen"

# Vaihtoehtoinen tapa
koko_nimi <- paste(nimi, sukunimi, sep = " ")  # Määritellään välilyönti erottimeksi
```

### 3. Loogiset arvot (logical)
```r
on_totta <- TRUE      # Huomaa isot kirjaimet
on_väärin <- FALSE
typeof(on_totta)      # "logical"

# Voit käyttää myös lyhenteitä
on_totta <- T         # Sama kuin TRUE
on_väärin <- F        # Sama kuin FALSE
```

### 4. Kompleksiluvut (complex)
```r
z <- 3 + 2i
typeof(z)            # "complex"
```

### 5. Puuttuva arvo (NA)
```r
# NA (Not Available) kuvaa puuttuvaa arvoa
ikä <- NA
is.na(ikä)           # TRUE, tarkistaa onko arvo NA
```

### Tietotyypin tarkistaminen ja muuntaminen

R-kielessä voit tarkistaa muuttujan tietotyypin:

```r
# Tietotyypin tarkistus
x <- 5
typeof(x)            # "double"

# Tarkemmat tarkistukset
is.numeric(x)        # TRUE, tarkistaa onko numero
is.character(x)      # FALSE, tarkistaa onko merkkijono
is.logical(x)        # FALSE, tarkistaa onko looginen arvo
```

Voit myös muuntaa tietotyyppejä:

```r
# Muunnetaan numero merkkijonoksi
x <- 5
x_teksti <- as.character(x)
typeof(x_teksti)     # "character"

# Muunnetaan merkkijono numeroksi
y <- "10"
y_numero <- as.numeric(y)
typeof(y_numero)     # "double"

# Muunnetaan looginen arvo numeroksi (TRUE = 1, FALSE = 0)
z <- TRUE
z_numero <- as.numeric(z)
z_numero             # 1
```

## Vektorit

Vektorit ovat yksi R:n perusrakenteista. Ne ovat yksiulotteisia taulukoita, jotka sisältävät samantyyppisiä elementtejä.

### Vektorin luominen

Vektorit luodaan yleensä `c()`-funktion avulla (c = combine):

```r
# Numeerinen vektori
numerot <- c(1, 2, 3, 4, 5)
numerot

# Merkkijonovektori
nimet <- c("Matti", "Maija", "Pekka")
nimet

# Looginen vektori
totuusarvot <- c(TRUE, FALSE, TRUE)
totuusarvot
```

### Sekvenssi-vektorit

R:ssä on useita tapoja luoda sekvenssejä:

```r
# Kaksoispisteoperaattori
luvut_1_10 <- 1:10
luvut_1_10             # 1 2 3 4 5 6 7 8 9 10

# seq()-funktio
luvut_0_1 <- seq(from = 0, to = 1, by = 0.1)
luvut_0_1              # 0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0

# Halutuilla väleillä
luvut <- seq(0, 1, length.out = 5)
luvut                  # 0.00 0.25 0.50 0.75 1.00
```

### Vektorin toistaminen

```r
# rep()-funktio toistaa arvoja
rep(1, times = 5)                  # 1 1 1 1 1
rep(c(1, 2), times = 3)            # 1 2 1 2 1 2
rep(c(1, 2), each = 3)             # 1 1 1 2 2 2
rep(c(1, 2), times = c(2, 3))      # 1 1 2 2 2
```

### Vektorin elementtien käsittely

Vektorin elementtejä voi käsitellä indeksien avulla:

```r
# Indeksointi R:ssä alkaa numerosta 1, ei 0:sta kuten monissa muissa kielissä
x <- c(10, 20, 30, 40, 50)

# Yksittäisen elementin hakeminen
x[1]                   # 10 (ensimmäinen elementti)

# Useamman elementin hakeminen
x[c(1, 3, 5)]          # 10 30 50

# Jatkuvan alueen hakeminen
x[2:4]                 # 20 30 40

# Negatiivinen indeksi poistaa elementin
x[-1]                  # 20 30 40 50 (kaikki paitsi ensimmäinen)
x[-c(1, 3)]            # 20 40 50 (kaikki paitsi ensimmäinen ja kolmas)

# Looginen indeksointi
x[x > 30]              # 40 50 (kaikki elementit, jotka ovat suurempia kuin 30)
```

### Vektorin elementtien muokkaaminen

```r
x <- c(10, 20, 30, 40, 50)

# Yksittäisen elementin muokkaaminen
x[1] <- 15
x                      # 15 20 30 40 50

# Useamman elementin muokkaaminen
x[c(1, 3)] <- c(100, 300)
x                      # 100 20 300 40 50

# Ehdollinen muokkaaminen
x[x < 50] <- 0
x                      # 0 0 300 0 50
```

### Vektorin operaatiot

```r
x <- c(1, 2, 3)
y <- c(10, 20, 30)

# Vektorien yhdistäminen
c(x, y)                # 1 2 3 10 20 30

# Vektorien aritmetiikka (tapahtuu alkioittain)
x + y                  # 11 22 33
x * y                  # 10 40 90
x + 1                  # 2 3 4 (lisätään 1 jokaiseen alkioon)

# Vektorin funktiot
sum(x)                 # 6 (summa)
mean(x)                # 2 (keskiarvo)
median(x)              # 2 (mediaani)
min(x)                 # 1 (minimi)
max(x)                 # 3 (maksimi)
length(x)              # 3 (pituus)
sort(x)                # 1 2 3 (järjestys)
rev(x)                 # 3 2 1 (käänteinen järjestys)
```

## Matriisit

Matriisit ovat kaksiulotteisia taulukoita, jotka sisältävät samantyyppisiä elementtejä.

### Matriisin luominen

```r
# Luodaan 3x3 matriisi
m <- matrix(1:9, nrow = 3, ncol = 3)
m
#      [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

# Matriisi täytetään oletuksena sarakkeittain
# Voit muuttaa täyttöjärjestyksen riveittäin
m2 <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
m2
#      [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6
# [3,]    7    8    9
```

### Matriisin elementtien käsittely

```r
# Indeksointi tapahtuu [rivi, sarake]
m[1, 1]               # 1 (ensimmäinen rivi, ensimmäinen sarake)
m[2, 3]               # 8 (toinen rivi, kolmas sarake)

# Koko rivi tai sarake
m[1, ]                # 1 4 7 (koko ensimmäinen rivi)
m[, 2]                # 4 5 6 (koko toinen sarake)

# Osamatriisi
m[1:2, 2:3]           # 2x2 osamatriisi
```

### Matriisin funktiot

```r
# Matriisin dimensiot
dim(m)                # 3 3 (rivit ja sarakkeet)
nrow(m)               # 3 (rivien määrä)
ncol(m)               # 3 (sarakkeiden määrä)

# Matriisin transpoosi
t(m)                  # Vaihtaa rivit ja sarakkeet

# Rivien ja sarakkeiden summat
rowSums(m)            # Rivien summat
colSums(m)            # Sarakkeiden summat
rowMeans(m)           # Rivien keskiarvot
colMeans(m)           # Sarakkeiden keskiarvot
```

## Data Frame

Data frame on taulukkorakenne, joka on suunniteltu erityisesti datan käsittelyyn. Se on kuin taulukko, jossa jokaisella sarakkeella voi olla oma tietotyyppi.

### Data Framen luominen

```r
# Luodaan data frame
opiskelijat <- data.frame(
  nimi = c("Matti", "Maija", "Pekka"),
  ikä = c(25, 22, 30),
  arvosana = c(4, 5, 3)
)

opiskelijat
#     nimi  ikä arvosana
# 1  Matti   25        4
# 2  Maija   22        5
# 3  Pekka   30        3

# Tarkistetaan rakenne
str(opiskelijat)
```

### Data Framen elementtien käsittely

```r
# Sarakkeen valinta $-operaattorilla
opiskelijat$nimi              # "Matti" "Maija" "Pekka"

# Sarakkeen valinta indeksillä
opiskelijat[, "nimi"]         # "Matti" "Maija" "Pekka"
opiskelijat[, 1]              # "Matti" "Maija" "Pekka" (ensimmäinen sarake)

# Rivin valinta
opiskelijat[1, ]              # Ensimmäinen rivi
opiskelijat[opiskelijat$ikä > 25, ]  # Rivit, joissa ikä > 25

# Yksittäisen arvon valinta
opiskelijat$nimi[1]           # "Matti"
opiskelijat[1, "nimi"]        # "Matti"
```

### Data Framen muokkaaminen

```r
# Uuden sarakkeen lisääminen
opiskelijat$kurssi <- c("Matematiikka", "Fysiikka", "Historia")
opiskelijat

# Rivin lisääminen
uusi_opiskelija <- data.frame(
  nimi = "Liisa",
  ikä = 28,
  arvosana = 4,
  kurssi = "Kemia"
)
opiskelijat <- rbind(opiskelijat, uusi_opiskelija)
opiskelijat

# Data Framen suodattaminen
nuoret <- opiskelijat[opiskelijat$ikä < 25, ]
nuoret
```

### Data Framen funktiot

```r
# Perustiedot data framesta
head(opiskelijat)      # Ensimmäiset rivit
tail(opiskelijat)      # Viimeiset rivit
summary(opiskelijat)   # Yhteenveto
nrow(opiskelijat)      # Rivien määrä
ncol(opiskelijat)      # Sarakkeiden määrä
names(opiskelijat)     # Sarakkeiden nimet
```

## Listat

Lista on R:n monipuolisin tietorakenne. Se voi sisältää eri tyyppisiä elementtejä, mukaan lukien muita listoja.

### Listan luominen

```r
# Luodaan lista
opiskelija_tiedot <- list(
  nimi = "Matti",
  ikä = 25,
  arvosanat = c(4, 5, 3),
  kurssit = c("Matematiikka", "Fysiikka", "Historia"),
  yhteystiedot = list(
    puhelin = "040-1234567",
    sähköposti = "matti@example.com"
  )
)

opiskelija_tiedot
```

### Listan elementtien käsittely

```r
# Elementin hakeminen $-operaattorilla
opiskelija_tiedot$nimi                # "Matti"

# Elementin hakeminen [[]]-operaattorilla
opiskelija_tiedot[["nimi"]]           # "Matti"

# Elementin hakeminen indeksillä
opiskelija_tiedot[[1]]                # "Matti" (ensimmäinen elementti)

# Osalistan hakeminen
opiskelija_tiedot["nimi"]             # Lista, joka sisältää vain nimen
opiskelija_tiedot[c("nimi", "ikä")]   # Lista, joka sisältää nimen ja iän

# Sisäkkäiset elementit
opiskelija_tiedot$yhteystiedot$puhelin  # "040-1234567"
opiskelija_tiedot[["yhteystiedot"]][["puhelin"]]  # "040-1234567"
```

### Listan muokkaaminen

```r
# Elementin muokkaaminen
opiskelija_tiedot$ikä <- 26
opiskelija_tiedot

# Uuden elementin lisääminen
opiskelija_tiedot$valmistumisvuosi <- 2023
opiskelija_tiedot

# Elementin poistaminen
opiskelija_tiedot$valmistumisvuosi <- NULL
opiskelija_tiedot
```

## Aritmeettiset operaattorit

R-kielessä on standardit aritmeettiset operaattorit:

```r
# Peruslaskutoimitukset
5 + 3        # 8 (yhteenlasku)
5 - 3        # 2 (vähennyslasku)
5 * 3        # 15 (kertolasku)
5 / 3        # 1.666667 (jakolasku)
5 ^ 2        # 25 (potenssi)
5 ** 2       # 25 (vaihtoehtoinen potenssi)

# Kokonaislukujakolasku ja jakojäännös
5 %/% 3      # 1 (kokonaislukujakolasku)
5 %% 3       # 2 (jakojäännös)
```

Näitä operaattoreita voi käyttää myös vektoreilla, jolloin operaatio suoritetaan alkioittain:

```r
x <- c(1, 2, 3)
y <- c(10, 20, 30)

x + y        # 11 22 33
x * y        # 10 40 90
```

## Loogiset operaattorit

Loogisia operaattoreita käytetään ehtojen luomiseen:

```r
# Vertailuoperaattorit
5 < 10       # TRUE (pienempi kuin)
5 > 10       # FALSE (suurempi kuin)
5 <= 5       # TRUE (pienempi tai yhtä suuri kuin)
5 >= 10      # FALSE (suurempi tai yhtä suuri kuin)
5 == 5       # TRUE (yhtä suuri kuin)
5 != 10      # TRUE (eri suuri kuin)

# Loogiset operaattorit
TRUE & FALSE  # FALSE (looginen JA)
TRUE | FALSE  # TRUE (looginen TAI)
!TRUE         # FALSE (looginen EI)

# Vertailu vektoreilla
x <- c(1, 2, 3, 4, 5)
x > 3         # FALSE FALSE FALSE TRUE TRUE
x == 3        # FALSE FALSE TRUE FALSE FALSE
x %in% c(1, 3, 5)  # TRUE FALSE TRUE FALSE TRUE (onko x:n alkio kokoelmassa)
```

### Ehtorakenteet

Loogisia operaattoreita käytetään usein ehtorakenteissa:

```r
# If-else rakenne
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

# Vektoroitu if-else
y <- c(-2, 0, 3, 5)
ifelse(y > 0, "positiivinen", "ei-positiivinen")
# "ei-positiivinen" "ei-positiivinen" "positiivinen" "positiivinen"
```

## Funktiot ja niiden käyttö

Funktiot ovat R-ohjelmoinnin keskeinen osa. R:ssä on paljon valmiita funktioita, ja voit myös luoda omia funktioita.

### Valmiiden funktioiden käyttö

```r
# Matemaattisia funktioita
sqrt(16)            # 4 (neliöjuuri)
abs(-10)            # 10 (itseisarvo)
round(3.14159, 2)   # 3.14 (pyöristys 2 desimaaliin)
floor(3.7)          # 3 (pyöristys alaspäin)
ceiling(3.2)        # 4 (pyöristys ylöspäin)

# Tilastollisia funktioita
x <- c(1, 2, 3, 4, 5)
mean(x)              # 3 (keskiarvo)
median(x)            # 3 (mediaani)
sd(x)                # 1.581139 (keskihajonta)
var(x)               # 2.5 (varianssi)
min(x)               # 1 (minimi)
max(x)               # 5 (maksimi)
range(x)             # 1 5 (minimi ja maksimi)
sum(x)               # 15 (summa)
prod(x)              # 120 (tulo)
```

### Omien funktioiden luominen

Voit luoda omia funktioita `function`-avainsanan avulla:

```r
# Yksinkertainen funktio
tervehdys <- function(nimi) {
  paste("Hei", nimi, "!")
}

tervehdys("Matti")   # "Hei Matti !"

# Funktio oletusarvoilla
tervehdys2 <- function(nimi = "maailma") {
  paste("Hei", nimi, "!")
}

tervehdys2()         # "Hei maailma !"
tervehdys2("Maija")  # "Hei Maija !"

# Useamman argumentin funktio
laske_bmi <- function(paino, pituus) {
  bmi <- paino / (pituus/100)^2
  return(bmi)
}

laske_bmi(70, 175)   # 22.86
```

### Funktioiden palauttamat arvot

R-funktiot palauttavat oletuksena viimeisen lausekkeen arvon, mutta voit myös käyttää `return()`-funktiota:

```r
# Implisiittinen palautus
kertoma <- function(n) {
  if (n <= 1) {
    1
  } else {
    n * kertoma(n - 1)
  }
}

kertoma(5)           # 120

# Eksplisiittinen palautus
luokittele_ikä <- function(ikä) {
  if (ikä < 18) {
    return("Alaikäinen")
  } else if (ikä < 65) {
    return("Työikäinen")
  } else {
    return("Eläkeläinen")
  }
}

luokittele_ikä(25)   # "Työikäinen"
```

### Moniarvoiset palautukset

Funktio voi palauttaa useita arvoja listan avulla:

```r
tilastot <- function(x) {
  list(
    keskiarvo = mean(x),
    mediaani = median(x),
    min = min(x),
    max = max(x),
    lukumäärä = length(x)
  )
}

arvot <- c(10, 20, 30, 40, 50)
tulos <- tilastot(arvot)
tulos$keskiarvo      # 30
tulos$min            # 10
```

## Kommentointi koodissa

Kommentit ovat tärkeitä koodin dokumentointiin. R:ssä kommentit alkavat #-merkillä:

```r
# Tämä on yhden rivin kommentti
x <- 5  # Tämä kommentti on koodiviivan jälkeen

# Usean rivin kommenttia varten käytetään monta #-merkkiä
# Tämä on ensimmäinen rivi
# Tämä on toinen rivi
# jne.
```

### Hyvät kommentointikäytännöt

1. **Selitä miksi, ei miten** - Koodi itsessään kertoo mitä se tekee, kommenttien tulisi selittää miksi se tehdään.
2. **Kommentoi monimutkaiset osat** - Erityisesti monimutkaiset algoritmit tai epätavalliset ratkaisut.
3. **Käytä funktioiden dokumentointia** - Erityisesti omien funktioiden osalta:

```r
#' Laskee painoindeksin (BMI)
#'
#' @param paino Paino kilogrammoissa
#' @param pituus Pituus senttimetreissä
#' @return BMI-arvo (kg/m^2)
#' @examples
#' laske_bmi(70, 175)
laske_bmi <- function(paino, pituus) {
  bmi <- paino / (pituus/100)^2
  return(bmi)
}
```

## Harjoituksia

Tässä on muutamia harjoituksia, joiden avulla voit testata oppimaasi:

1. Luo vektori, joka sisältää luvut 2, 4, 6, 8 ja 10. Laske vektorin summa ja keskiarvo.

2. Luo 3x3 matriisi, joka sisältää luvut 1-9 riveittäin. Laske jokaisen rivin summa ja sarakkeen keskiarvo.

3. Luo data frame, joka sisältää viiden henkilön nimet, iät ja painot. Lisää uusi sarake, joka kertoo onko henkilö täysi-ikäinen (ikä >= 18).

4. Kirjoita funktio, joka ottaa parametrina vektorin ja palauttaa listassa sen pienimmän ja suurimman arvon sekä niiden indeksit.

5. Luo lista, joka sisältää tietoja henkilöstä (nimi, ikä, osoite, harrastukset listana). Tulosta henkilön toinen harrastus.

## Yhteenveto

Tässä osiossa olemme käsitelleet R-kielen perusteita:

- Muuttujat ja arvon asettaminen
- Perustietotyypit (numeerinen, merkkijono, looginen)
- Vektorit ja niiden käsittely
- Matriisit ja niiden operaatiot
- Data framet datan käsittelyyn
- Listat monipuolisina tietorakenteina
- Aritmeettiset ja loogiset operaattorit
- Funktiot ja niiden käyttö
- Kommentointi koodissa

Nämä perusteet luovat pohjan, jonka päälle voit rakentaa R-osaamistasi. Seuraavissa osioissa jatkamme datan tuonnin, käsittelyn ja visualisoinnin parissa, hyödyntäen näitä perustaitoja.
