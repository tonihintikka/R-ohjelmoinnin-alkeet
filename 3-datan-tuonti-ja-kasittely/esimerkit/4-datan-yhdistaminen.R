# 4. Datan yhdistäminen ja muuntaminen - Esimerkkikoodi
# Tämä R-skripti demonstroi, miten yhdistää useita datalähteitä ja muuntaa dataa eri muotojen välillä

# ======== Luodaan esimerkkidatat ========

# 1. Asiakasdata, jossa perustiedot
asiakkaat <- data.frame(
  asiakas_id = c(101, 102, 103, 104, 105, 106, 107),
  nimi = c("Matti Virtanen", "Maija Lahtinen", "Pekka Korhonen", "Liisa Nieminen", 
           "Juha Heikkinen", "Anna Mäkinen", "Timo Koskinen"),
  sukupuoli = c("mies", "nainen", "mies", "nainen", "mies", "nainen", "mies"),
  ikä = c(42, 35, 28, 54, 65, 31, 47),
  stringsAsFactors = FALSE
)

# 2. Yhteystietodata
yhteystiedot <- data.frame(
  asiakas_id = c(101, 102, 104, 105, 106, 108, 109),
  sähköposti = c("matti.v@example.com", "maija.l@example.com", "liisa.n@example.com", 
                "juha.h@example.com", "anna.m@example.com", "seppo.s@example.com", 
                "hanna.k@example.com"),
  puhelin = c("040-1234567", "050-2345678", "045-3456789", "040-4567890", 
             "050-5678901", "045-6789012", "040-7890123"),
  stringsAsFactors = FALSE
)

# 3. Ostosdata
ostokset <- data.frame(
  ostos_id = 1:10,
  asiakas_id = c(101, 102, 101, 103, 104, 101, 105, 106, 102, 103),
  tuote = c("Kahvi", "Tee", "Sokeri", "Leipä", "Maito", "Juusto", "Jogurtti", 
           "Murot", "Hunaja", "Keksit"),
  määrä = c(2, 1, 1, 2, 3, 1, 4, 2, 1, 2),
  hinta = c(5.90, 4.50, 2.30, 3.20, 1.80, 7.50, 1.20, 4.30, 6.70, 3.90),
  päivämäärä = as.Date(c("2023-01-10", "2023-01-15", "2023-01-20", "2023-01-25", 
                        "2023-02-01", "2023-02-05", "2023-02-10", "2023-02-15", 
                        "2023-02-20", "2023-02-25")),
  stringsAsFactors = FALSE
)

# 4. Postinumerodata
postinumerot <- data.frame(
  postinumero = c("00100", "00200", "33100", "33200", "90100"),
  kaupunki = c("Helsinki", "Helsinki", "Tampere", "Tampere", "Oulu"),
  lääni = c("Uusimaa", "Uusimaa", "Pirkanmaa", "Pirkanmaa", "Pohjois-Pohjanmaa"),
  stringsAsFactors = FALSE
)

# 5. Asiakkaiden postinumerot (yhdistävä data)
asiakas_postinumerot <- data.frame(
  asiakas_id = c(101, 102, 103, 104, 105, 106, 107),
  postinumero = c("00100", "33100", "90100", "00200", "33200", "00100", "33100"),
  stringsAsFactors = FALSE
)

# Tulostetaan perusdatat
cat("=== Perustiedot (asiakkaat) ===\n")
print(asiakkaat)
cat("\n=== Yhteystiedot ===\n")
print(yhteystiedot)
cat("\n=== Ostokset ===\n")
print(ostokset)
cat("\n=== Postinumerot ===\n")
print(postinumerot)
cat("\n=== Asiakkaiden postinumerot ===\n")
print(asiakas_postinumerot)
cat("\n")

# ======== Datan yhdistäminen (JOIN-operaatiot) ========

# 1. INNER JOIN - vain matchaavat rivit
cat("=== INNER JOIN: Asiakkaat ja yhteystiedot ===\n")
asiakkaat_yhteystiedot <- merge(asiakkaat, yhteystiedot, by = "asiakas_id")
print(asiakkaat_yhteystiedot)
cat("Alkuperäiset rivimäärät: Asiakkaat =", nrow(asiakkaat), ", Yhteystiedot =", nrow(yhteystiedot), "\n")
cat("INNER JOIN tulos:", nrow(asiakkaat_yhteystiedot), "riviä\n\n")

# 2. LEFT JOIN - kaikki asiakkaat, myös ne joilta puuttuu yhteystiedot
cat("=== LEFT JOIN: Asiakkaat ja yhteystiedot ===\n")
asiakkaat_yhteystiedot_left <- merge(asiakkaat, yhteystiedot, by = "asiakas_id", all.x = TRUE)
print(asiakkaat_yhteystiedot_left)
cat("LEFT JOIN tulos:", nrow(asiakkaat_yhteystiedot_left), "riviä\n\n")

# 3. RIGHT JOIN - kaikki yhteystiedot, myös ne joilta puuttuu asiakastiedot
cat("=== RIGHT JOIN: Asiakkaat ja yhteystiedot ===\n")
asiakkaat_yhteystiedot_right <- merge(asiakkaat, yhteystiedot, by = "asiakas_id", all.y = TRUE)
print(asiakkaat_yhteystiedot_right)
cat("RIGHT JOIN tulos:", nrow(asiakkaat_yhteystiedot_right), "riviä\n\n")

# 4. FULL JOIN - kaikki rivit molemmista tauluista
cat("=== FULL JOIN: Asiakkaat ja yhteystiedot ===\n")
asiakkaat_yhteystiedot_full <- merge(asiakkaat, yhteystiedot, by = "asiakas_id", all = TRUE)
print(asiakkaat_yhteystiedot_full)
cat("FULL JOIN tulos:", nrow(asiakkaat_yhteystiedot_full), "riviä\n\n")

# 5. Usean taulun yhdistäminen ketjuttamalla
cat("=== Usean taulun yhdistäminen: Asiakkaat + postinumerot + kaupunkitiedot ===\n")
# Ensin yhdistämme asiakkaat ja heidän postinumeronsa
asiakkaat_postit <- merge(asiakkaat, asiakas_postinumerot, by = "asiakas_id")
# Sitten yhdistämme tuloksen kaupunkitietoihin
asiakkaat_kaupungit <- merge(asiakkaat_postit, postinumerot, by = "postinumero")
print(asiakkaat_kaupungit)
cat("\n")

# 6. Yhdistäminen, kun avainten nimet eroavat
# Oletetaan, että meillä on ulkoinen data, jossa asiakastunniste on eri nimellä
ulkoinen_data <- data.frame(
  ulk_asiakas_id = c(101, 103, 105, 107, 110),
  luottoluokitus = c("A", "B", "A", "C", "B"),
  maksuhäiriöitä = c(FALSE, FALSE, TRUE, FALSE, TRUE),
  stringsAsFactors = FALSE
)

cat("=== Yhdistäminen eriävien avainten nimillä ===\n")
cat("Ulkoinen data:\n")
print(ulkoinen_data)
cat("\n")

# Yhdistäminen, kun avainten nimet eroavat
asiakkaat_luottotiedot <- merge(asiakkaat, ulkoinen_data, 
                              by.x = "asiakas_id", by.y = "ulk_asiakas_id", 
                              all.x = TRUE)
cat("Yhdistetyt asiakkaat ja luottotiedot:\n")
print(asiakkaat_luottotiedot)
cat("\n")

# ======== Rivien yhdistäminen (Row Binding) ========

# Oletetaan, että meillä on toinen asiakasdata uudemmista asiakkaista
uudet_asiakkaat <- data.frame(
  asiakas_id = c(201, 202, 203),
  nimi = c("Leena Jokinen", "Kari Salminen", "Jaana Tuominen"),
  sukupuoli = c("nainen", "mies", "nainen"),
  ikä = c(29, 38, 45),
  stringsAsFactors = FALSE
)

cat("=== Rivien yhdistäminen (rbind) ===\n")
cat("Uudet asiakkaat:\n")
print(uudet_asiakkaat)
cat("\n")

# Yhdistetään vanhat ja uudet asiakkaat
kaikki_asiakkaat <- rbind(asiakkaat, uudet_asiakkaat)
cat("Kaikki asiakkaat (vanhat + uudet):\n")
print(kaikki_asiakkaat)
cat("\n")

# ======== Sarakkeiden yhdistäminen (Column Binding) ========

# Oletetaan, että meillä on erilliset datat tiedoista
asiakkaat_perustiedot <- asiakkaat[, c("asiakas_id", "nimi", "sukupuoli")]
asiakkaat_lisätiedot <- data.frame(
  ikä = asiakkaat$ikä,
  asiakas_vuodesta = c(2018, 2020, 2019, 2021, 2017, 2022, 2020),
  segmentti = c("A", "B", "A", "C", "A", "B", "C"),
  stringsAsFactors = FALSE
)

cat("=== Sarakkeiden yhdistäminen (cbind) ===\n")
cat("Perustiedot:\n")
print(asiakkaat_perustiedot)
cat("\nLisätiedot:\n")
print(asiakkaat_lisätiedot)
cat("\n")

# Yhdistetään sarakkeet
asiakkaat_kaikki_tiedot <- cbind(asiakkaat_perustiedot, asiakkaat_lisätiedot)
cat("Kaikki tiedot (perustiedot + lisätiedot):\n")
print(asiakkaat_kaikki_tiedot)
cat("\n")

# ======== Datan muuntaminen leveästä pitkään muotoon (Wide to Long) ========

# Luodaan esimerkki leveästä datasta - asiakkaan ostokset kuukausittain
ostokset_leveä <- data.frame(
  asiakas_id = c(101, 102, 103, 104),
  nimi = c("Matti Virtanen", "Maija Lahtinen", "Pekka Korhonen", "Liisa Nieminen"),
  tammi = c(125.50, 89.90, 210.30, 45.60),
  helmi = c(95.70, 120.80, 180.20, 65.40),
  maalis = c(110.30, 75.60, 195.70, 55.90),
  huhti = c(135.20, 95.30, 220.60, 75.80),
  stringsAsFactors = FALSE
)

cat("=== Datan muuntaminen leveästä pitkään muotoon ===\n")
cat("Leveä data (ostokset kuukausittain):\n")
print(ostokset_leveä)
cat("\n")

# Muunnetaan pitkään muotoon
# Voimme käyttää reshape() funktiota perus-R:llä tai reshape2/tidyr -pakettien funktioita

# Reshape perus-R:llä
ostokset_pitkä <- reshape(
  ostokset_leveä,
  direction = "long",
  varying = list(c("tammi", "helmi", "maalis", "huhti")),
  v.names = "ostokset_summa",
  idvar = c("asiakas_id", "nimi"),
  timevar = "kuukausi",
  times = c("tammi", "helmi", "maalis", "huhti")
)

# Järjestetään tulokset
ostokset_pitkä <- ostokset_pitkä[order(ostokset_pitkä$asiakas_id, ostokset_pitkä$kuukausi), ]
rownames(ostokset_pitkä) <- NULL  # Nollataan rivi-indeksit

cat("Pitkä data (reshape perus-R:llä):\n")
print(ostokset_pitkä)
cat("\n")

# Käytetään vaihtoehtoisesti reshape2-pakettia jos se on asennettu
if (requireNamespace("reshape2", quietly = TRUE)) {
  cat("=== Datan muuntaminen reshape2-paketilla ===\n")
  
  library(reshape2)
  
  # Leveästä pitkään (melt)
  ostokset_pitkä_reshape2 <- melt(
    ostokset_leveä,
    id.vars = c("asiakas_id", "nimi"),
    measure.vars = c("tammi", "helmi", "maalis", "huhti"),
    variable.name = "kuukausi",
    value.name = "ostokset_summa"
  )
  
  cat("Pitkä data (reshape2::melt):\n")
  print(ostokset_pitkä_reshape2)
  cat("\n")
} else {
  cat("reshape2-paketti ei ole asennettu. Asennus: install.packages('reshape2')\n\n")
}

# ======== Datan muuntaminen pitkästä leveään muotoon (Long to Wide) ========

# Käytetään äsken luotua pitkää dataa ja muunnetaan se takaisin leveään muotoon

# Reshape perus-R:llä
ostokset_leveä_takaisin <- reshape(
  ostokset_pitkä,
  direction = "wide",
  idvar = c("asiakas_id", "nimi"),
  timevar = "kuukausi"
)

# Siistiä sarakkeiden nimet
names(ostokset_leveä_takaisin) <- gsub("ostokset_summa.", "", names(ostokset_leveä_takaisin))

cat("=== Datan muuntaminen pitkästä leveään muotoon ===\n")
cat("Leveä data takaisin (reshape perus-R:llä):\n")
print(ostokset_leveä_takaisin)
cat("\n")

# Käytetään vaihtoehtoisesti reshape2-pakettia jos se on asennettu
if (requireNamespace("reshape2", quietly = TRUE)) {
  cat("=== Datan muuntaminen reshape2-paketilla ===\n")
  
  library(reshape2)
  
  # Pitkästä leveään (dcast)
  ostokset_leveä_reshape2 <- dcast(
    ostokset_pitkä_reshape2,
    asiakas_id + nimi ~ kuukausi,
    value.var = "ostokset_summa"
  )
  
  cat("Leveä data takaisin (reshape2::dcast):\n")
  print(ostokset_leveä_reshape2)
  cat("\n")
}

# ======== Aggregointi ja ryhmittely =========

# Ryhmittäiset tilastot ostoksista
cat("=== Ostokset asiakkaittain ===\n")
ostokset_per_asiakas <- aggregate(
  cbind(määrä, hinta) ~ asiakas_id, 
  data = ostokset, 
  FUN = function(x) c(summa = sum(x), ka = mean(x), lkm = length(x))
)
print(ostokset_per_asiakas)
cat("\n")

# Laskemme ostoksien kokonaissumman asiakkaittain
ostokset$kokonaishinta <- ostokset$määrä * ostokset$hinta

cat("=== Ostoksien kokonaissumma asiakkaittain ===\n")
ostokset_summa_per_asiakas <- aggregate(
  kokonaishinta ~ asiakas_id, 
  data = ostokset, 
  FUN = sum
)
print(ostokset_summa_per_asiakas)
cat("\n")

# Yhdistämme asiakastiedot ja ostossummat
asiakkaat_ja_ostokset <- merge(asiakkaat, ostokset_summa_per_asiakas, by = "asiakas_id", all.x = TRUE)
# Korvataan NA-arvot 0:lla (asiakkaat, joilla ei ole ostoksia)
asiakkaat_ja_ostokset$kokonaishinta[is.na(asiakkaat_ja_ostokset$kokonaishinta)] <- 0

cat("=== Asiakkaat ja heidän ostossummansa ===\n")
print(asiakkaat_ja_ostokset)
cat("\n")

# ======== Ristiin taulukointi (Cross Tabulation) ========

# Luodaan kaupungeittain ja sukupuolittain jakautuva ristiintaulukointi
# Ensin yhdistämme tarpeelliset tiedot
asiakkaat_kaupungeittain <- merge(merge(asiakkaat, asiakas_postinumerot, by = "asiakas_id"),
                                 postinumerot, by = "postinumero")

cat("=== Ristiintaulukointi: Asiakkaat kaupungeittain ja sukupuolittain ===\n")
ristiintaulukko <- table(asiakkaat_kaupungeittain$kaupunki, asiakkaat_kaupungeittain$sukupuoli)
print(ristiintaulukko)
cat("\n")

# Prosenttiosuudet riveittäin
cat("=== Prosenttiosuudet riveittäin ===\n")
print(prop.table(ristiintaulukko, margin = 1) * 100)  # margin = 1 laskee prosentit riveittäin
cat("\n")

# Prosenttiosuudet sarakkeittain
cat("=== Prosenttiosuudet sarakkeittain ===\n")
print(prop.table(ristiintaulukko, margin = 2) * 100)  # margin = 2 laskee prosentit sarakkeittain
cat("\n")

# ======== Edistyneemmät menetelmät dplyr-paketilla ========

cat("=== Edistyneet menetelmät dplyr-paketilla ===\n")
cat("Jos haluat kokeilla edistyneempiä tapoja yhdistää ja muokata dataa, asenna dplyr-paketti:\n")
cat("install.packages('dplyr')\n\n")
cat("Tässä esimerkkejä dplyr-syntaksista:\n")
cat("
library(dplyr)

# JOIN-operaatiot
asiakkaat_yhteystiedot_dplyr <- inner_join(asiakkaat, yhteystiedot, by = 'asiakas_id')
asiakkaat_yhteystiedot_left_dplyr <- left_join(asiakkaat, yhteystiedot, by = 'asiakas_id')

# Datan yhdistäminen useista lähteistä pipe-operaattorilla
asiakkaat_kaikki_tiedot_dplyr <- asiakkaat %>%
  left_join(yhteystiedot, by = 'asiakas_id') %>%
  left_join(asiakas_postinumerot, by = 'asiakas_id') %>%
  left_join(postinumerot, by = 'postinumero')

# Ryhmittely ja aggregointi
ostokset_summa_dplyr <- ostokset %>%
  group_by(asiakas_id) %>%
  summarise(
    kokonaissumma = sum(määrä * hinta),
    ostosten_lkm = n(),
    keskiostos = mean(määrä * hinta)
  )
")

# ======== Tidyr-paketti pitkän ja leveän datan muuntamiseen ========

cat("=== Datan muuntaminen tidyr-paketilla ===\n")
cat("Jos haluat kokeilla moderneja tapoja muuntaa dataa pitkän ja leveän muodon välillä, asenna tidyr-paketti:\n")
cat("install.packages('tidyr')\n\n")
cat("Tässä esimerkkejä tidyr-syntaksista:\n")
cat("
library(tidyr)

# Leveästä pitkään (tidyr)
ostokset_pitkä_tidyr <- ostokset_leveä %>%
  pivot_longer(
    cols = c(tammi, helmi, maalis, huhti),
    names_to = 'kuukausi',
    values_to = 'ostokset_summa'
  )

# Pitkästä leveään (tidyr)
ostokset_leveä_tidyr <- ostokset_pitkä_tidyr %>%
  pivot_wider(
    names_from = kuukausi,
    values_from = ostokset_summa
  )
")

# ======== Yhteenveto ========

cat("\n=== Yhteenveto datan yhdistämisestä ja muuntamisesta ===\n")
cat("Tässä esimerkissä käsittelimme:\n")
cat("1. Datan yhdistäminen JOIN-operaatioilla (INNER, LEFT, RIGHT, FULL)\n")
cat("2. Rivien ja sarakkeiden yhdistäminen (rbind, cbind)\n")
cat("3. Datan muuntaminen leveän ja pitkän muodon välillä\n")
cat("4. Aggregointi ja ryhmittely\n")
cat("5. Ristiintaulukointi (Cross Tabulation)\n\n")

cat("Tärkeimmät huomiot:\n")
cat("- Datan yhdistäminen on keskeinen taito data-analyysissä\n")
cat("- R tarjoaa monipuoliset työkalut eri datatyyppien ja -lähteiden yhdistämiseen\n")
cat("- Pitkä ja leveä muoto palvelevat eri tarkoituksia - pitkä on usein parempi analyyseille\n")
cat("- Edistyneempiin tarpeisiin kannattaa tutustua dplyr- ja tidyr-paketteihin\n")
