# Datan visualisoinnin harjoitukset
# Tämä tiedosto sisältää harjoituksia liittyen datan visualisointiin R:llä

# ======== HARJOITUS 1: Peruskuvaajat Base R:llä ========

# Tehtävä 1.1: Pistekuvaaja (Scatter Plot)
# Luo pistekuvaaja, joka visualisoi iris-aineiston Sepal.Length ja Petal.Length muuttujien välistä suhdetta.
# Käytä eri värejä eri lajien (Species) erottamiseen. Lisää otsikko ja akselien nimet.

# Vinkki: data(iris) lataa iris-aineiston


# Tehtävä 1.2: Histogrammi
# Luo histogrammi, joka näyttää iris-aineiston Sepal.Width-muuttujan jakauman.
# Aseta sopiva luokkien määrä. Lisää otsikko ja akselien nimet.


# Tehtävä 1.3: Laatikkokaavio (Box Plot)
# Luo laatikkokaavio, joka vertailee iris-aineiston Petal.Width-muuttujan jakaumaa eri lajien välillä.
# Lisää otsikko ja akselien nimet.


# Tehtävä 1.4: Viivakuvaaja
# Luo viivakuvaaja käyttäen seuraavaa dataa:
vuosi <- 2010:2020
arvo <- c(15, 18, 22, 20, 23, 25, 28, 30, 35, 33, 40)

# Lisää kuvaajaan otsikko, akselien nimet ja muuta viivan tyyliä (väri, paksuus).


# Tehtävä 1.5: Pylväsdiagrammi (Bar Plot)
# Luo pylväsdiagrammi, joka näyttää seuraavien kategorioiden arvot:
kategoria <- c("A", "B", "C", "D", "E")
määrä <- c(25, 32, 16, 29, 22)

# Muuta pylväiden väriä ja lisää otsikko ja akselien nimet.


# ======== HARJOITUS 2: ggplot2-visualisoinnit ========

# Tehtävä 2.1: Asenna ja lataa ggplot2-kirjasto
# install.packages("ggplot2")  # Suorita tämä rivi, jos ggplot2 ei ole vielä asennettu
library(ggplot2)

# Tehtävä 2.2: Pistekuvaaja ggplot2:lla
# Luo pistekuvaaja mtcars-aineistosta, joka vertailee wt (paino) ja mpg (polttoaineenkulutus) muuttujia.
# Väritä pisteet sylinterien määrän (cyl) mukaan.


# Tehtävä 2.3: Histogrammi ggplot2:lla
# Luo histogrammi mtcars-aineiston drat-muuttujasta. Mukauta binien määrää ja väritystä.
# Lisää otsikko ja akselien nimet.


# Tehtävä 2.4: Laatikkokaavio ggplot2:lla
# Luo laatikkokaavio mtcars-aineistosta, joka vertailee mpg-arvoja sylinterien määrän (cyl) mukaan.
# Väritä laatikot cyl-muuttujan mukaan.


# Tehtävä 2.5: Viulukuvaaja (Violin Plot)
# Luo viulukuvaaja iris-aineistosta, joka näyttää Sepal.Length-muuttujan jakauman lajeittain.
# Lisää laatikkokaavio viulukuvaajan sisälle.


# Tehtävä 2.6: Pylväsdiagrammi ggplot2:lla
# Luo pylväsdiagrammi, joka näyttää mtcars-aineistossa vaihteistojen määrän (am) sylinterien (cyl) mukaan.
# Vinkki: Käytä geom_bar(position = "dodge").


# ======== HARJOITUS 3: Kuvaajien muokkaaminen ========

# Tehtävä 3.1: Teemat
# Luo pistekuvaaja mtcars-aineistosta (mpg vs hp), ja kokeile erilaisia teemoja:
# theme_minimal(), theme_classic(), theme_dark(), theme_bw()


# Tehtävä 3.2: Värit ja fontit
# Luo pylväsdiagrammi, joka näyttää mpg-keskiarvon cyl-ryhmissä. Mukauta värejä,
# fontteja ja akselitekstejä.
# Vinkki: Käytä mean-funktiota ja aggregate() tai group_by() + summarise()


# Tehtävä 3.3: Akselien muokkaaminen
# Luo pistekuvaaja mpg vs hp, ja muokkaa x- ja y-akselin asteikkoja.
# Kokeile erilaisia skaaloja: scale_x_log10(), scale_y_continuous(limits = c(..., ...))


# Tehtävä 3.4: Kuvaajien jakaminen (Faceting)
# Luo pistekuvaaja mtcars-aineistosta (mpg vs wt) ja jaa kuvaaja vaihteistotyypin (am) 
# ja sylinterimäärän (cyl) mukaan käyttäen facet_grid() tai facet_wrap().


# ======== HARJOITUS 4: Edistyneemmät visualisoinnit ========

# Tehtävä 4.1: Useiden muuttujien visualisointi
# Luo kattava visualisointi mtcars-aineistosta, joka näyttää mpg vs wt -suhteen,
# käyttäen pisteiden väriä (cyl), kokoa (hp) ja muotoa (am) lisämuuttujien visualisointiin.


# Tehtävä 4.2: Lämpökartta
# Jos olet asentanut tarvittavat paketit (reshape2 tai tidyr):
# Luo lämpökartta mtcars-aineiston numeeristen muuttujien välisistä korrelaatioista.


# Tehtävä 4.3: Interaktiivinen kuvaaja
# Jos olet asentanut plotly-paketin:
# Luo interaktiivinen pistekuvaaja (mpg vs hp) käyttäen ggplotly()-funktiota.


# ======== HARJOITUS 5: Käytännön esimerkkiprojekti ========

# Tehtävä 5.1: Visualisoi diamonds-aineistoa (osa ggplot2-pakettia)

# a) Luo histogrammi, joka näyttää timanttien hintojen jakauman


# b) Luo pistekuvaaja, joka näyttää carat (koko) vs price (hinta) -suhteen.
#    Väritä pisteet cut (leikkaus) -muuttujan mukaan.


# c) Luo laatikkokaaviot, jotka näyttävät hintojen jakautumisen eri laatuluokissa (cut).


# d) Luo kuvaaja, joka näyttää koon (carat) ja hinnan (price) suhteen eri väreille (color) ja
#    leikkaustyypeille (cut). Käytä facet_grid()-funktiota.


# ======== VASTAUKSET ========

# -------- HARJOITUS 1: Peruskuvaajat Base R:llä --------

# Tehtävä 1.1: Pistekuvaaja
data(iris)
plot(iris$Sepal.Length, iris$Petal.Length,
     main = "Iris-kukkien terälehtien ja verholehteien pituuksien suhde",
     xlab = "Verholehden pituus (cm)", 
     ylab = "Terälehden pituus (cm)",
     col = as.numeric(iris$Species),  # Väri lajin mukaan
     pch = 19)  # Täytetyt ympyrät pistesymbolina

# Lisätään selite
legend("topleft", 
       legend = levels(iris$Species), 
       col = 1:3, 
       pch = 19,
       title = "Laji")

# Tehtävä 1.2: Histogrammi
hist(iris$Sepal.Width,
     breaks = 12,  # Luokkien määrä
     main = "Iris-kukkien verholehden leveyden jakauma",
     xlab = "Verholehden leveys (cm)",
     ylab = "Frekvenssi",
     col = "lightblue",
     border = "darkblue")

# Tehtävä 1.3: Laatikkokaavio
boxplot(Petal.Width ~ Species, data = iris,
        main = "Terälehden leveys eri Iris-lajeilla",
        xlab = "Laji",
        ylab = "Terälehden leveys (cm)",
        col = c("lightpink", "lightblue", "lightgreen"))

# Tehtävä 1.4: Viivakuvaaja
plot(vuosi, arvo, 
     type = "l",  # "l" tarkoittaa viivaa
     main = "Arvon kehitys 2010-2020",
     xlab = "Vuosi",
     ylab = "Arvo",
     col = "red",
     lwd = 2)  # Viivan paksuus

# Lisätään pisteet viivalle
points(vuosi, arvo, 
       pch = 19,  # Täytetyt ympyrät
       col = "blue")

# Lisätään ruudukko
grid()

# Tehtävä 1.5: Pylväsdiagrammi
barplot(määrä,
        names.arg = kategoria,
        main = "Määrät kategorioittain",
        xlab = "Kategoria",
        ylab = "Määrä",
        col = rainbow(length(kategoria)),
        border = "black")

# -------- HARJOITUS 2: ggplot2-visualisoinnit --------

# Tehtävä 2.2: Pistekuvaaja ggplot2:lla
data(mtcars)
# Muunnetaan cyl faktoriksi
mtcars$cyl <- as.factor(mtcars$cyl)

ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 3) +
  labs(title = "Auton paino vs. polttoaineenkulutus",
       subtitle = "Väri kertoo sylinterien määrän",
       x = "Paino (1000 lbs)",
       y = "Miles Per Gallon (mpg)",
       color = "Sylinterit") +
  theme_minimal()

# Tehtävä 2.3: Histogrammi ggplot2:lla
ggplot(mtcars, aes(x = drat)) +
  geom_histogram(bins = 10, fill = "skyblue", color = "black") +
  labs(title = "Välityssuhteen (drat) jakauma",
       x = "Välityssuhde",
       y = "Frekvenssi") +
  theme_minimal()

# Tehtävä 2.4: Laatikkokaavio ggplot2:lla
ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl)) +
  geom_boxplot() +
  labs(title = "Polttoaineenkulutus sylinterien määrän mukaan",
       x = "Sylinterien määrä",
       y = "Miles Per Gallon (mpg)",
       fill = "Sylinterit") +
  theme_minimal()

# Tehtävä 2.5: Viulukuvaaja
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_violin() +
  geom_boxplot(width = 0.2, fill = "white") +
  labs(title = "Verholehden pituuden jakauma eri Iris-lajeilla",
       x = "Laji",
       y = "Verholehden pituus (cm)",
       fill = "Laji") +
  theme_minimal()

# Tehtävä 2.6: Pylväsdiagrammi ggplot2:lla
# Ensin tehdään cyl- ja am-muuttujista faktoreita
mtcars$am <- as.factor(mtcars$am)
levels(mtcars$am) <- c("Automaatti", "Manuaali")

ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar(position = "dodge") +
  labs(title = "Vaihteistotyyppien määrä sylinterimäärän mukaan",
       x = "Sylinterien määrä",
       y = "Lukumäärä",
       fill = "Vaihteistotyyppi") +
  theme_minimal()

# -------- HARJOITUS 3: Kuvaajien muokkaaminen --------

# Tehtävä 3.1: Teemat
# Peruspistekaavio
p <- ggplot(mtcars, aes(x = hp, y = mpg, color = cyl)) +
  geom_point(size = 3) +
  labs(title = "Hevosvoimat vs. Polttoaineenkulutus",
       x = "Hevosvoimat (hp)",
       y = "Miles Per Gallon (mpg)",
       color = "Sylinterit")

# Eri teemojen kokeilu
p + theme_minimal()  # Minimalistinen teema
p + theme_classic()  # Klassinen teema
p + theme_dark()     # Tumma teema
p + theme_bw()       # Mustavalkoinen teema

# Tehtävä 3.2: Värit ja fontit
# Lasketaan ensin keskiarvo cyl-ryhmittäin
mpg_means <- aggregate(mpg ~ cyl, data = mtcars, FUN = mean)

ggplot(mpg_means, aes(x = cyl, y = mpg, fill = cyl)) +
  geom_col() +
  labs(title = "Keskimääräinen polttoaineenkulutus sylinterien määrän mukaan",
       x = "Sylinterien määrä",
       y = "Keskimääräinen MPG",
       fill = "Sylinterit") +
  scale_fill_brewer(palette = "Set1") +  # Väripaletti
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 10)
  )

# Tehtävä 3.3: Akselien muokkaaminen
ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point(aes(color = cyl), size = 3) +
  labs(title = "Hevosvoimat vs. Polttoaineenkulutus",
       x = "Hevosvoimat (hp)",
       y = "Miles Per Gallon (mpg)",
       color = "Sylinterit") +
  scale_x_log10() +  # Logaritminen x-akseli
  scale_y_continuous(limits = c(10, 35)) +  # Y-akselin rajoittaminen
  theme_minimal()

# Tehtävä 3.4: Kuvaajien jakaminen
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(am ~ cyl) +  # Jako vaihteiston ja sylinterien mukaan
  labs(title = "Paino vs. Polttoaineenkulutus",
       subtitle = "Jaettuna vaihteistotyypin (rivit) ja sylinterien määrän (sarakkeet) mukaan",
       x = "Paino (1000 lbs)",
       y = "Miles Per Gallon (mpg)",
       color = "Sylinterit") +
  theme_minimal()

# -------- HARJOITUS 4: Edistyneemmät visualisoinnit --------

# Tehtävä 4.1: Useiden muuttujien visualisointi
ggplot(mtcars, aes(x = wt, y = mpg, color = cyl, size = hp, shape = am)) +
  geom_point(alpha = 0.7) +
  labs(title = "Useiden muuttujien visualisointi",
       subtitle = "Paino, kulutus, sylinterit, hevosvoimat ja vaihteisto",
       x = "Paino (1000 lbs)",
       y = "Miles Per Gallon (mpg)",
       color = "Sylinterit",
       size = "Hevosvoimat",
       shape = "Vaihteisto") +
  theme_minimal()

# Tehtävä 4.2: Lämpökartta
# Jos reshape2-paketti on asennettu
if (requireNamespace("reshape2", quietly = TRUE)) {
  library(reshape2)
  
  # Lasketaan korrelaatiomatriisi numeerisista muuttujista
  cor_matrix <- cor(mtcars[, c("mpg", "disp", "hp", "drat", "wt", "qsec")])
  
  # Muunnetaan pitkään muotoon
  cor_melted <- melt(cor_matrix)
  names(cor_melted) <- c("Var1", "Var2", "value")
  
  # Luodaan lämpökartta
  ggplot(cor_melted, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
    labs(title = "Korrelaatiomatriisi",
         x = "",
         y = "",
         fill = "Korrelaatio") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

# Tehtävä 4.3: Interaktiivinen kuvaaja
# Jos plotly-paketti on asennettu
if (requireNamespace("plotly", quietly = TRUE)) {
  library(plotly)
  
  # Luodaan ggplot-kuvaaja
  p <- ggplot(mtcars, aes(x = hp, y = mpg, color = cyl)) +
    geom_point(size = 3) +
    labs(title = "Hevosvoimat vs. Polttoaineenkulutus",
         x = "Hevosvoimat (hp)",
         y = "Miles Per Gallon (mpg)",
         color = "Sylinterit") +
    theme_minimal()
  
  # Muunnetaan interaktiiviseksi
  ggplotly(p)
}

# -------- HARJOITUS 5: Käytännön esimerkkiprojekti --------

# Tehtävä 5.1: Diamonds-aineiston visualisointi
# Ladataan diamonds-aineisto (osa ggplot2-pakettia)
data(diamonds)

# a) Histogrammi timanttien hinnoista
ggplot(diamonds, aes(x = price)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  labs(title = "Timanttien hintojen jakauma",
       x = "Hinta (USD)",
       y = "Frekvenssi") +
  theme_minimal()

# b) Pistekuvaaja: koko vs. hinta, väri leikkauksen mukaan
ggplot(diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.5) +
  labs(title = "Timanttien koko vs. hinta",
       subtitle = "Väri kertoo leikkauksen laadun",
       x = "Koko (carat)",
       y = "Hinta (USD)",
       color = "Leikkaus") +
  theme_minimal()

# c) Laatikkokaaviot hintojen jakautumisesta eri laatuluokissa
ggplot(diamonds, aes(x = cut, y = price, fill = cut)) +
  geom_boxplot() +
  labs(title = "Hintojen jakautuminen eri leikkausluokissa",
       x = "Leikkauksen laatu",
       y = "Hinta (USD)",
       fill = "Leikkaus") +
  theme_minimal()

# d) Kuvaaja, joka näyttää koon ja hinnan suhteen eri väreille ja leikkaustyypeille
ggplot(diamonds, aes(x = carat, y = price, color = color)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(color ~ cut) +
  labs(title = "Koon ja hinnan suhde eri väreille ja leikkaustyypeille",
       x = "Koko (carat)",
       y = "Hinta (USD)",
       color = "Väri") +
  theme_minimal() +
  theme(strip.text = element_text(size = 8))  # Pienennä facet-otsikoiden tekstiä
