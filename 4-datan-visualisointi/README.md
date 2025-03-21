# 4. Datan visualisointi

Tässä osiossa opimme, miten voimme visualisoida dataa R:n avulla. Visualisointi on tärkeä osa data-analyysiä, sillä se auttaa ymmärtämään dataa paremmin ja löytämään siitä kiinnostavia piirteitä ja malleja. R tarjoaa laajan valikoiman työkaluja erilaisten kuvaajien luomiseen.

## 4.1 Visualisoinnin perusteet R:ssä

### 4.1.1 Miksi visualisoida dataa?

Datan visualisointi on tärkeää useista syistä:

1. **Ymmärtäminen**: Visualisointi auttaa ymmärtämään datan rakennetta ja jakaumaa
2. **Trendien tunnistaminen**: Kuvaajat paljastavat trendejä ja malleja, jotka eivät ole ilmeisiä raa'asta datasta
3. **Poikkeavien havaintojen löytäminen**: Visualisointi auttaa löytämään poikkeamia ja virheitä datasta
4. **Kommunikointi**: Hyvin suunnitellut visualisoinnit ovat tehokas tapa kommunikoida dataan perustuvia löydöksiä
5. **Hypoteesien luominen**: Visualisoinnit voivat antaa ideoita jatkotutkimusta varten

### 4.1.2 R:n visualisointikirjastot

R tarjoaa useita vaihtoehtoja datan visualisointiin:

1. **Base R -grafiikat**: R:n perusvisualisointitoiminnot (`plot()`, `hist()`, jne.)
2. **ggplot2**: Suosittu visualisointikirjasto, joka perustuu "Grammar of Graphics" -filosofiaan
3. **lattice**: Monimutkaisempien kuvaajien tekemiseen soveltuva kirjasto
4. **plotly**: Interaktiivisten kuvaajien luomiseen soveltuva kirjasto
5. **leaflet**: Karttavisualisointien luomiseen soveltuva kirjasto

Tässä osiossa keskitymme ensin R:n perusvisualisointitoimintoihin ja sitten ggplot2-kirjastoon, joka on nykyään suosituin tapa tehdä visualisointeja R:llä.

## 4.2 Base R -visualisoinnit

R:n perustoiminnot tarjoavat laajan valikoiman kuvaajatyyppejä ilman erillisten pakettien asentamista. Nämä ovat hyviä nopeaan visualisointiin ja datan tutkimiseen.

### 4.2.1 Perusvisualisointifunktiot

#### plot() - Yleisfunktio visualisointiin

`plot()` on monipuolinen funktio, jota voi käyttää monenlaisten kuvaajien luomiseen:

```r
# Pistekaavio
x <- 1:10
y <- x^2
plot(x, y)

# Lisätään otsikko ja akselien nimet
plot(x, y, 
     main = "Neliöfunktio", 
     xlab = "x-akseli", 
     ylab = "y-akseli")

# Eri pistesymbolit
plot(x, y, pch = 19)  # Täytetyt ympyrät

# Eri värit
plot(x, y, col = "red")

# Pisteiden koko
plot(x, y, cex = 2)  # Kaksi kertaa normaalikoko

# Viivakuvaaja
plot(x, y, type = "l")

# Pisteet ja viiva
plot(x, y, type = "b")
```

#### hist() - Histogrammi

Histogrammi näyttää muuttujan jakauman:

```r
# Luodaan satunnaislukuja normaaljakaumasta
data <- rnorm(1000)

# Perushistogrammi
hist(data)

# Mukautettu histogrammi
hist(data, 
     breaks = 30,              # Luokkien määrä
     col = "lightblue",        # Pylväiden väri
     main = "Normaalijakauma", # Otsikko
     xlab = "Arvo",            # x-akselin nimi
     ylab = "Frekvenssi")      # y-akselin nimi
```

#### boxplot() - Laatikkokaavio

Laatikkokaavio näyttää muuttujan jakauman viiden tunnusluvun avulla (minimi, alakvartiili, mediaani, yläkvartiili, maksimi):

```r
# Luodaan dataa
data <- list(
  ryhmä1 = rnorm(100, mean = 5, sd = 1),
  ryhmä2 = rnorm(100, mean = 6, sd = 1.2),
  ryhmä3 = rnorm(100, mean = 4.5, sd = 0.8)
)

# Peruslaatikkokaavio
boxplot(data)

# Mukautettu laatikkokaavio
boxplot(data, 
        col = c("lightblue", "lightgreen", "lightpink"),
        main = "Ryhmien vertailu",
        xlab = "Ryhmä",
        ylab = "Arvo")
```

#### barplot() - Pylväsdiagrammi

Pylväsdiagrammi näyttää ryhmien välisiä eroja:

```r
# Luodaan dataa
data <- c(15, 25, 10, 30)
nimet <- c("Ryhmä A", "Ryhmä B", "Ryhmä C", "Ryhmä D")

# Peruspylväsdiagrammi
barplot(data, names.arg = nimet)

# Mukautettu pylväsdiagrammi
barplot(data, 
        names.arg = nimet,
        col = "steelblue",
        main = "Ryhmien vertailu",
        xlab = "Ryhmä",
        ylab = "Arvo",
        border = NA)  # Ei reunaviivoja
```

#### pie() - Piirakkakaavio

Piirakkakaavio näyttää osien suhteellisen koon kokonaisuudesta:

```r
# Luodaan dataa
data <- c(20, 30, 15, 35)
nimet <- c("Osa A", "Osa B", "Osa C", "Osa D")

# Peruspiirakkakaavio
pie(data, labels = nimet)

# Mukautettu piirakkakaavio
pie(data, 
    labels = nimet,
    col = c("red", "blue", "green", "yellow"),
    main = "Osuudet kokonaisuudesta")
```

> **Huomautus:** Piirakkakaaviota ei yleensä suositella datan visualisointiin, sillä ihmisten on vaikea vertailla tarkasti kulmia tai alueita. Pylväsdiagrammi on usein parempi vaihtoehto.

### 4.2.2 Kuvaajien muokkaaminen

Base R -kuvaajia voi muokata monin tavoin:

```r
# Luodaan kuvaaja
plot(x, y, type = "l", 
     main = "Muokattu kuvaaja",
     xlab = "x-akseli", 
     ylab = "y-akseli",
     col = "blue",
     lwd = 2)  # Viivan paksuus

# Lisätään toinen viiva samaan kuvaajaan
lines(x, y/2, col = "red", lty = 2)  # Punainen katkoviiva

# Lisätään pisteitä
points(x, y*0.7, col = "green", pch = 19)

# Lisätään selite
legend("topleft",              # Sijainti
       legend = c("Data 1", "Data 2", "Data 3"),
       col = c("blue", "red", "green"),
       lty = c(1, 2, NA),      # Viivan tyyppi (NA = ei viivaa)
       pch = c(NA, NA, 19))    # Pisteen symboli (NA = ei pistettä)

# Lisätään teksti kuvaajaan
text(5, 60, "Huomaa tämä piste!", col = "purple")

# Lisätään otsikko marginaaleihin
mtext("Alakuvausteksti", side = 1, line = 4)

# Muokataan akselien asteikkoa
plot(x, y, ylim = c(0, 150), xlim = c(0, 12))
```

### 4.2.3 Useiden kuvaajien yhdistäminen

R:ssä voi luoda useita kuvaajia samaan ikkunaan `par()` funktion avulla:

```r
# Luo 2x2 ruudukko kuvaajia
par(mfrow = c(2, 2))

# Nyt seuraavat neljä kuvaajaa menevät omiin ruutuihinsa
plot(x, y, main = "Kuvaaja 1")
plot(x, log(y), main = "Kuvaaja 2")
hist(y, main = "Kuvaaja 3")
boxplot(y, main = "Kuvaaja 4")

# Palautetaan normaalitila (1x1)
par(mfrow = c(1, 1))
```

## 4.3 ggplot2-visualisoinnit

ggplot2 on Hadley Wickhamin kehittämä visualisointikirjasto, joka perustuu "Grammar of Graphics" -filosofiaan. Sen idea on rakentaa kuvaajat kerroksittain määrittelemällä ensin data ja koordinaatisto, sitten visuaaliset elementit ja lopuksi muotoilut.

### 4.3.1 ggplot2:n perusperiaatteet

ggplot2 toimii eri logiikalla kuin Base R -visualisoinnit. Kuvaajat rakennetaan kerros kerrokselta käyttäen `+` operaattoria.

```r
# Asennetaan ja ladataan ggplot2
install.packages("ggplot2")  # Tarvitsee tehdä vain kerran
library(ggplot2)

# Luodaan esimerkki data.frame
df <- data.frame(
  x = 1:10,
  y = 1:10 * 2,
  ryhmä = rep(c("A", "B"), each = 5)
)

# Perus ggplot-kuvaaja
ggplot(data = df, aes(x = x, y = y)) +
  geom_point()
```

Perusosat ggplot2-kuvaajassa:

1. **Data**: `ggplot(data = df, ...)`
2. **Estetiikka (aesthetics)**: `aes(x = x, y = y, ...)`
3. **Geometria**: `geom_point()`, `geom_line()`, jne.

### 4.3.2 Yleisimmät geometriat ggplot2:ssa

ggplot2 tarjoaa monia eri "geometrioita" (kuvaajatyyppejä):

#### geom_point() - Pistekaavio

```r
# Peruspistekaavio
ggplot(df, aes(x = x, y = y)) +
  geom_point()

# Pistekaavio ryhmittelyllä
ggplot(df, aes(x = x, y = y, color = ryhmä)) +
  geom_point(size = 3)
```

#### geom_line() - Viivakuvaaja

```r
# Perusviivakuvaaja
ggplot(df, aes(x = x, y = y)) +
  geom_line()

# Viivakuvaaja ryhmittelyllä
ggplot(df, aes(x = x, y = y, color = ryhmä)) +
  geom_line(linewidth = 1)
```

#### geom_bar() - Pylväsdiagrammi

```r
# Yksinkertainen laskeva pylväsdiagrammi
ggplot(df, aes(x = ryhmä)) +
  geom_bar()

# Pylväsdiagrammi valmiilla arvoilla
ggplot(df, aes(x = ryhmä, y = y)) +
  geom_col(fill = "steelblue")

# Ryhmitelty pylväsdiagrammi
ggplot(df, aes(x = ryhmä, y = y, fill = factor(x))) +
  geom_col(position = "dodge")
```

#### geom_histogram() - Histogrammi

```r
# Luodaan satunnaisluvut
set.seed(123)
df_hist <- data.frame(
  arvo = rnorm(1000, mean = 5, sd = 1.5)
)

# Perushistogrammi
ggplot(df_hist, aes(x = arvo)) +
  geom_histogram()

# Mukautettu histogrammi
ggplot(df_hist, aes(x = arvo)) +
  geom_histogram(bins = 30, fill = "lightblue", color = "black") +
  labs(title = "Histogrammi", x = "Arvo", y = "Frekvenssi")
```

#### geom_boxplot() - Laatikkokaavio

```r
# Luodaan esimerkkidata
df_box <- data.frame(
  ryhmä = rep(c("A", "B", "C"), each = 100),
  arvo = c(rnorm(100, 5, 1), rnorm(100, 7, 1.5), rnorm(100, 4, 0.8))
)

# Perus laatikkokaavio
ggplot(df_box, aes(x = ryhmä, y = arvo)) +
  geom_boxplot()

# Mukautettu laatikkokaavio
ggplot(df_box, aes(x = ryhmä, y = arvo, fill = ryhmä)) +
  geom_boxplot() +
  labs(title = "Laatikkokaavio ryhmittäin",
       x = "Ryhmä",
       y = "Arvo")
```

#### geom_violin() - Viulukuvaaja (violin plot)

Viulukuvaaja näyttää datan jakauman kuten laatikkokaavio, mutta tarkemmin:

```r
ggplot(df_box, aes(x = ryhmä, y = arvo, fill = ryhmä)) +
  geom_violin() +
  labs(title = "Viulukuvaaja ryhmittäin")
```

### 4.3.3 Kuvaajien muokkaaminen ggplot2:lla

ggplot2 tarjoaa monia tapoja muokata kuvaajien ulkoasua:

```r
# Peruspistekaavio muokattuna
ggplot(df, aes(x = x, y = y, color = ryhmä)) +
  geom_point(size = 3) +
  labs(title = "Muokattu pistekaavio",
       subtitle = "Esimerkki ggplot2-muokkauksista",
       x = "X-akseli",
       y = "Y-akseli",
       color = "Ryhmä") +
  theme_minimal() +
  scale_color_brewer(palette = "Set1")
```

#### Teemat (themes)

ggplot2 sisältää valmiita teemoja, jotka muuttavat kuvaajan ulkoasua:

```r
# Erilaisia teemoja
ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  theme_bw()  # Mustavalkoinen teema

ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  theme_minimal()  # Minimalistinen teema

ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  theme_classic()  # Klassinen teema
```

#### Väripaletit

ggplot2 tarjoaa useita väripaletteja:

```r
# RColorBrewer-paletit
ggplot(df, aes(x = x, y = y, color = ryhmä)) +
  geom_point(size = 3) +
  scale_color_brewer(palette = "Set1")

# Jatkuva väriskaala
ggplot(df, aes(x = x, y = y, color = x)) +
  geom_point(size = 3) +
  scale_color_gradient(low = "blue", high = "red")
```

#### Faceting (jaetut kuvaajat)

Faceting jakaa datan osajoukoiksi ja luo kullekin oman kuvaajan:

```r
# Luodaan isompi datajoukko
df_laaja <- data.frame(
  x = rep(1:10, 3),
  y = c(1:10 * 2, 1:10 * 3, 1:10 * 1.5),
  ryhmä = rep(c("A", "B", "C"), each = 10)
)

# Jaetaan kuvaajat ryhmittäin
ggplot(df_laaja, aes(x = x, y = y)) +
  geom_point() +
  geom_line() +
  facet_wrap(~ ryhmä)

# Ruudukko faceting
ggplot(df_laaja, aes(x = x, y = y)) +
  geom_point() +
  facet_grid(rows = vars(ryhmä))
```

### 4.3.4 Edistyneet ggplot2-tekniikat

#### Useita geometrioita samassa kuvaajassa

```r
ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "blue", size = 3) +
  geom_line(color = "red", linewidth = 1) +
  geom_smooth(method = "lm", color = "green", se = FALSE)  # Lineaarinen regressio
```

#### Kuvaajien tallentaminen

```r
# Luodaan kuvaaja
p <- ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  theme_minimal()

# Tallennetaan kuvaaja
ggsave("kuvaaja.png", p, width = 6, height = 4, dpi = 300)
ggsave("kuvaaja.pdf", p, width = 6, height = 4)
```

## 4.4 Interaktiiviset visualisoinnit

R tarjoaa myös mahdollisuuden luoda interaktiivisia visualisointeja, erityisesti `plotly` ja `shiny` -pakettien avulla.

### 4.4.1 Plotly-kuvaajat

Plotly muuntaa staattisen ggplot2-kuvaajan interaktiiviseksi:

```r
# Asennetaan ja ladataan plotly
install.packages("plotly")  # Tarvitsee tehdä vain kerran
library(plotly)

# Luodaan ggplot2-kuvaaja
p <- ggplot(df, aes(x = x, y = y, color = ryhmä)) +
  geom_point(size = 3) +
  theme_minimal()

# Muunnetaan interaktiiviseksi
ggplotly(p)
```

### 4.4.2 Muut interaktiiviset kirjastot

R:ssä on muitakin interaktiivisia visualisointikirjastoja:

- **highcharter**: Perustuu Highcharts JavaScript -kirjastoon
- **dygraphs**: Aikasarjavisualisointeihin
- **leaflet**: Interaktiivisiin karttoihin
- **networkD3**: Verkostovisualisointeihin

## 4.5 Visualisointien parhaat käytännöt

### 4.5.1 Visualisointien suunnitteluperiaatteet

Hyvät visualisoinnit noudattavat tiettyjä periaatteita:

1. **Selkeys**: Visualisoinnin tulisi olla helppo ymmärtää
2. **Totuudenmukaisuus**: Visualisointi ei saa johtaa harhaan
3. **Tehokkuus**: Visualisoinnin tulisi välittää tietoa tehokkaasti
4. **Esteettisyys**: Miellyttävä ulkoasu lisää vaikuttavuutta

### 4.5.2 Visualisointityypin valitseminen

Eri visualisointityypit sopivat eri tarkoituksiin:

- **Pistekaavio**: Kahden jatkuvan muuttujan suhteen tarkasteluun
- **Viivakuvaaja**: Trendien ja muutosten näyttämiseen ajan myötä
- **Pylväsdiagrammi**: Kategorioiden vertailuun
- **Histogrammi**: Jakauman tarkasteluun
- **Laatikkokaavio**: Jakaumien vertailuun ja poikkeavien havaintojen etsimiseen
- **Heatmap**: Moniulotteisen datan esittämiseen

### 4.5.3 Yleisiä virheitä visualisoinnissa

Vältä näitä yleisiä virheitä:

1. **Y-akselin manipulointi**: Y-akselin ei pitäisi alkaa muualta kuin nollasta pylväsdiagrammeissa
2. **Vääristyneet suhteet**: 3D-kuvaajat voivat vääristää suhteita
3. **Liikaa informaatiota**: Yksinkertaisuus on valttia
4. **Huono värien käyttö**: Värien tulisi auttaa ymmärtämään dataa, ei häiritä
5. **Epäselvät otsikot ja selitteet**: Otsikkojen ja selitteiden tulisi olla selkeitä

## 4.6 Harjoituksia

1. Luo pistekaavio, joka näyttää kahden muuttujan välisen suhteen
2. Tee histogrammi, joka näyttää yhden muuttujan jakauman
3. Luo pylväsdiagrammi, joka vertailee kategorisia arvoja
4. Tee laatikkokaavio, joka vertailee ryhmien jakaumia
5. Yhdistä useita visualisointeja samaan kuvaan
6. Luo visualisointi käyttäen ggplot2-kirjastoa
7. Muokkaa ggplot2-visualisoinnin ulkoasua (värit, teemat, jne.)
8. Luo interaktiivinen visualisointi käyttäen plotly-kirjastoa

## 4.7 Yhteenveto

Tässä osiossa opimme R:n visualisointiin liittyviä tekniikoita:

- Base R -visualisointifunktiot (plot, hist, boxplot, jne.)
- ggplot2-kirjaston käyttö
- Kuvaajien muokkaaminen ja hienosäätö
- Interaktiivisten visualisointien luominen
- Visualisointien parhaat käytännöt

Visualisointi on keskeinen osa data-analyysia. Hyvin suunnitellut visualisoinnit auttavat ymmärtämään dataa paremmin ja kommunikoimaan löydöksiä tehokkaasti. Seuraavassa osiossa tutustutaan tilastollisiin analyyseihin R:llä.
