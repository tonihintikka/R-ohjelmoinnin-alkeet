# 2. ggplot2-visualisoinnit
# Tämä skripti esittelee ggplot2-kirjaston käyttöä erilaisten visualisointien luomiseen

# ======== Asennetaan ja ladataan ggplot2 ========

# Asennetaan ggplot2-paketti (tarvitsee tehdä vain kerran)
# install.packages("ggplot2")

# Ladataan ggplot2-kirjasto
library(ggplot2)

# ======== Luodaan esimerkkidataa ========

# Luodaan yksinkertainen dataframe
df <- data.frame(
  x = 1:10,
  y = c(5, 9, 3, 10, 12, 8, 14, 7, 13, 15),
  ryhmä = rep(c("A", "B"), each = 5),
  koko = runif(10, 1, 5)
)

# Luodaan isompi datajoukko monimutkaisempiin esimerkkeihin
set.seed(123)
laaja_df <- data.frame(
  x = rep(1:10, 3),
  y = c(1:10 * 1.5 + rnorm(10, 0, 1),
        1:10 * 0.8 + rnorm(10, 0, 1),
        1:10 * 1.2 + rnorm(10, 0, 1)),
  ryhmä = factor(rep(c("A", "B", "C"), each = 10)),
  kategoria = factor(rep(c("Matala", "Korkea"), times = 15)),
  arvo = runif(30, 10, 100)
)

# Luodaan data histogrammiesimerkille
hist_data <- data.frame(
  arvo = c(rnorm(1000, mean = 15, sd = 3),
           rnorm(1000, mean = 20, sd = 4)),
  ryhmä = factor(rep(c("Ryhmä 1", "Ryhmä 2"), each = 1000))
)

# Luodaan data boxplot-esimerkille
boxplot_data <- data.frame(
  arvo = c(rnorm(100, mean = 20, sd = 3),
           rnorm(100, mean = 25, sd = 4),
           rnorm(100, mean = 18, sd = 2),
           rnorm(100, mean = 22, sd = 5)),
  ryhmä = factor(rep(c("A", "B", "C", "D"), each = 100)),
  osajoukko = factor(rep(rep(c("X", "Y"), each = 50), times = 4))
)

# ======== 1. ggplot2:n perusteet ========

# ggplot2 perusrakenne: ggplot(data, aes(x, y)) + geom_*()

# Yksinkertainen pistekaavio
ggplot(data = df, aes(x = x, y = y)) +
  geom_point()

# Viivakuvaaja
ggplot(data = df, aes(x = x, y = y)) +
  geom_line()

# Pistekaavio ja viivakuvaaja yhdessä
ggplot(data = df, aes(x = x, y = y)) +
  geom_line() +
  geom_point()

# ======== 2. Estetiikkojen käyttö (aesthetics) ========

# Väri ryhmän mukaan
ggplot(data = df, aes(x = x, y = y, color = ryhmä)) +
  geom_point(size = 3)

# Pisteiden koko muuttujan mukaan
ggplot(data = df, aes(x = x, y = y, size = koko)) +
  geom_point() +
  labs(size = "Koko")  # Muutetaan legendin otsikkoa

# Useiden estetiikkojen käyttö
ggplot(data = df, aes(x = x, y = y, color = ryhmä, size = koko, shape = ryhmä)) +
  geom_point() +
  labs(color = "Ryhmä", size = "Koko", shape = "Ryhmä")

# ======== 3. Geometrioiden vertailu ========

# geom_point() - Pistekaavio
p1 <- ggplot(data = laaja_df, aes(x = x, y = y, color = ryhmä)) +
  geom_point() +
  labs(title = "geom_point()")

# geom_line() - Viivakuvaaja
p2 <- ggplot(data = laaja_df, aes(x = x, y = y, color = ryhmä)) +
  geom_line() +
  labs(title = "geom_line()")

# geom_smooth() - Sovitekäyrä
p3 <- ggplot(data = laaja_df, aes(x = x, y = y, color = ryhmä)) +
  geom_smooth() +
  labs(title = "geom_smooth()")

# geom_bar() - Pylväskaavio (laskee frekvenssin)
p4 <- ggplot(data = laaja_df, aes(x = ryhmä, fill = kategoria)) +
  geom_bar(position = "dodge") +
  labs(title = "geom_bar()")

# Yhdistetään kuvaajat (vaatii gridExtra-paketin)
# install.packages("gridExtra")
# library(gridExtra)
# grid.arrange(p1, p2, p3, p4, ncol = 2)

# ======== 4. Histogrammi ggplot2:lla ========

# Perushistogrammi
ggplot(data = hist_data, aes(x = arvo)) +
  geom_histogram(bins = 30)

# Histogrammi väritettynä ryhmän mukaan (päällekkäin)
ggplot(data = hist_data, aes(x = arvo, fill = ryhmä)) +
  geom_histogram(bins = 30, alpha = 0.5, position = "identity") +
  labs(title = "Histogrammi ryhmittäin", 
       x = "Arvo", 
       y = "Frekvenssi",
       fill = "Ryhmä")

# Histogrammi tiheyskäyrällä
ggplot(data = hist_data, aes(x = arvo)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
  geom_density(alpha = 0.5, fill = "red") +
  labs(title = "Histogrammi tiheyskäyrällä", 
       x = "Arvo", 
       y = "Tiheys")

# Useita histogrammeja vierekkäin (faceting)
ggplot(data = hist_data, aes(x = arvo)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  facet_wrap(~ ryhmä) +
  labs(title = "Histogrammit ryhmittäin", 
       x = "Arvo", 
       y = "Frekvenssi")

# ======== 5. Laatikkokaavio (Box Plot) ggplot2:lla ========

# Peruslaatikkokaavio
ggplot(data = boxplot_data, aes(x = ryhmä, y = arvo)) +
  geom_boxplot() +
  labs(title = "Laatikkokaavio", 
       x = "Ryhmä", 
       y = "Arvo")

# Laatikkokaavio täytettynä ryhmän mukaan
ggplot(data = boxplot_data, aes(x = ryhmä, y = arvo, fill = ryhmä)) +
  geom_boxplot() +
  labs(title = "Laatikkokaavio väritettynä", 
       x = "Ryhmä", 
       y = "Arvo",
       fill = "Ryhmä")

# Ryhmitelty laatikkokaavio
ggplot(data = boxplot_data, aes(x = ryhmä, y = arvo, fill = osajoukko)) +
  geom_boxplot() +
  labs(title = "Ryhmitelty laatikkokaavio", 
       x = "Ryhmä", 
       y = "Arvo",
       fill = "Osajoukko")

# Ympyröidään poikkeavat havainnot
ggplot(data = boxplot_data, aes(x = ryhmä, y = arvo)) +
  geom_boxplot(outlier.shape = NA) +  # Piilotetaan oletuspoikkeamat
  geom_jitter(width = 0.2, alpha = 0.5) +  # Lisätään hajontaa välttääksemme päällekkäisyyttä
  labs(title = "Laatikkokaavio pistepilven kanssa", 
       x = "Ryhmä", 
       y = "Arvo")

# ======== 6. Violin Plot (Viulukuvaaja) ========

# Perusviulukuvaaja
ggplot(data = boxplot_data, aes(x = ryhmä, y = arvo)) +
  geom_violin() +
  labs(title = "Viulukuvaaja", 
       x = "Ryhmä", 
       y = "Arvo")

# Viulukuvaaja + laatikkokaavio
ggplot(data = boxplot_data, aes(x = ryhmä, y = arvo, fill = ryhmä)) +
  geom_violin(alpha = 0.5) +
  geom_boxplot(width = 0.2, alpha = 0.8) +
  labs(title = "Viulukuvaaja laatikkokaavion kanssa", 
       x = "Ryhmä", 
       y = "Arvo",
       fill = "Ryhmä")

# ======== 7. Bar Plot (Pylväsdiagrammi) ========

# Luodaan data pylväsdiagrammia varten
data_pylväs <- data.frame(
  kategoria = factor(c("A", "B", "C", "D", "E")),
  arvo = c(10, 24, 15, 8, 17)
)

# Peruspylväsdiagrammi (huomaa stat = "identity")
ggplot(data = data_pylväs, aes(x = kategoria, y = arvo)) +
  geom_col() +  # geom_col() = geom_bar(stat = "identity")
  labs(title = "Pylväsdiagrammi", 
       x = "Kategoria", 
       y = "Arvo")

# Pylväsdiagrammi väritettynä
ggplot(data = data_pylväs, aes(x = kategoria, y = arvo, fill = kategoria)) +
  geom_col() +
  labs(title = "Pylväsdiagrammi väritettynä", 
       x = "Kategoria", 
       y = "Arvo",
       fill = "Kategoria")

# Vaakasuora pylväsdiagrammi
ggplot(data = data_pylväs, aes(x = kategoria, y = arvo, fill = kategoria)) +
  geom_col() +
  coord_flip() +  # Kääntää koordinaatiston
  labs(title = "Vaakasuora pylväsdiagrammi", 
       x = "Kategoria", 
       y = "Arvo",
       fill = "Kategoria")

# ======== 8. Kuvaajien muokkaaminen ========

# Teema
p <- ggplot(data = df, aes(x = x, y = y, color = ryhmä)) +
  geom_point(size = 3) +
  labs(title = "Muokattu kuvaaja",
       subtitle = "Esimerkki teeman käytöstä",
       x = "X-akseli",
       y = "Y-akseli",
       color = "Ryhmä")

# theme_minimal() - minimalistinen teema
p + theme_minimal()

# theme_bw() - mustavalkoinen teema
p + theme_bw()

# theme_classic() - klassinen teema
p + theme_classic()

# theme_dark() - tumma teema
p + theme_dark()

# Oma mukautettu teema
p + theme(
  plot.title = element_text(size = 16, face = "bold"),
  plot.subtitle = element_text(size = 12, color = "gray50"),
  axis.title = element_text(size = 14),
  legend.position = "bottom",
  panel.grid.major = element_line(color = "gray80"),
  panel.grid.minor = element_blank()
)

# ======== 9. Värit ja väripaletit ========

# Käsin määritellyt värit
ggplot(data = boxplot_data, aes(x = ryhmä, y = arvo, fill = ryhmä)) +
  geom_boxplot() +
  scale_fill_manual(values = c("red", "blue", "green", "purple"))

# RColorBrewer-paketista
# install.packages("RColorBrewer")
# library(RColorBrewer)
ggplot(data = boxplot_data, aes(x = ryhmä, y = arvo, fill = ryhmä)) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Set1")

# Jatkuva väripaletti
ggplot(data = laaja_df, aes(x = x, y = y, color = arvo)) +
  geom_point(size = 3) +
  scale_color_gradient(low = "blue", high = "red")

# Vihjeitä väripaleteista:
# scale_fill_brewer() / scale_color_brewer() - RColorBrewer-paketista
# scale_fill_viridis_d() / scale_color_viridis_d() - viridis-paketista
# scale_fill_gradient() / scale_color_gradient() - jatkuva kaksivärinen paletti
# scale_fill_gradient2() / scale_color_gradient2() - jatkuva kolmivärinen paletti

# ======== 10. Faceting (jaetut kuvaajat) ========

# facet_wrap() - jaetaan kuvaajat yhden muuttujan mukaan
ggplot(data = laaja_df, aes(x = x, y = y, color = ryhmä)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ kategoria) +
  labs(title = "Jaetut kuvaajat kategorian mukaan",
       x = "X",
       y = "Y",
       color = "Ryhmä")

# facet_grid() - jaetaan kuvaajat kahden muuttujan mukaan
ggplot(data = boxplot_data, aes(x = ryhmä, y = arvo, fill = ryhmä)) +
  geom_boxplot() +
  facet_grid(rows = vars(osajoukko)) +
  labs(title = "Jaetut laatikkokaaviot",
       x = "Ryhmä",
       y = "Arvo",
       fill = "Ryhmä")

# ======== 11. Kuvaajien tallentaminen ========

# Tallennetaan viimeinen kuvaaja
viimeinen_kuvaaja <- ggplot(data = laaja_df, aes(x = x, y = y, color = ryhmä)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ kategoria) +
  labs(title = "Jaetut kuvaajat kategorian mukaan",
       x = "X",
       y = "Y",
       color = "Ryhmä") +
  theme_minimal()

# Tallennetaan PNG-tiedostona
ggsave("ggplot2_esimerkki.png", viimeinen_kuvaaja, width = 10, height = 6, dpi = 300)

# Tallennetaan PDF-tiedostona
ggsave("ggplot2_esimerkki.pdf", viimeinen_kuvaaja, width = 10, height = 6)

# ======== Yhteenveto ========

cat("Tässä esimerkissä opimme käyttämään ggplot2-kirjastoa erilaisten kuvaajien luomiseen:\n")
cat("1. ggplot2:n perusteet ja rakenne\n")
cat("2. Estetiikkojen käyttö (aesthetics)\n")
cat("3. Eri geometriat (geom_*)\n")
cat("4. Histogrammit\n")
cat("5. Laatikkokaaviot\n")
cat("6. Viulukuvaajat\n")
cat("7. Pylväsdiagrammit\n")
cat("8. Kuvaajien muokkaaminen ja teemat\n")
cat("9. Värit ja väripaletit\n")
cat("10. Faceting (jaetut kuvaajat)\n")
cat("11. Kuvaajien tallentaminen\n")
cat("\nggplot2 tarjoaa tehokkaan ja joustavan tavan luoda visualisointeja R:llä.\n")
cat("Sen 'Grammar of Graphics' -lähestymistapa tekee monimutkaistenkin visualisointien luomisesta systemaattista.\n")
