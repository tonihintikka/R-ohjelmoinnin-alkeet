# 3. Datan suodattaminen ja uusien muuttujien luominen - Esimerkkikoodi
# Tämä R-skripti demonstroi, miten suodattaa dataa ja luoda uusia muuttujia

# ======== Luodaan esimerkkidata ========

# Luodaan kuvitteellinen asiakasdata
asiakkaat <- data.frame(
  asiakas_id = 1:15,
  nimi = c("Matti Virtanen", "Maija Lahtinen", "Pekka Korhonen", "Liisa Nieminen", 
           "Juha Heikkinen", "Anna Mäkinen", "Timo Koskinen", "Sari Järvinen",
           "Mikko Leinonen", "Kaisa Karjalainen", "Antti Saarinen", "Leena Hämäläinen",
           "Jukka Räsänen", "Tiina Kallio", "Ville Salonen"),
  sukupuoli = c("mies", "nainen", "mies", "nainen", "mies", "nainen", "mies", "nainen",
                "mies", "nainen", "mies", "nainen", "mies", "nainen", "mies"),
  ikä = c(42, 35, 28, 54, 65, 31, 47, 39, 29, 52, 33, 61, 44, 37, 28),
  postinumero = c("00100", "33720", "90100", "33100", "00200", "33200", "00300", "15300",
                 "00400", "33500", "90200", "00500", "33600", "00600", "33400"),
  ostoksia = c(12, 5, 20, 8, 15, 3, 11, 7, 22, 9, 14, 6, 18, 10, 4),
  keskiostos = c(58.5, 120.2, 35.8, 85.3, 42.1, 150.5, 65.7, 95.3, 30.4, 75.8, 
                50.2, 110.4, 45.6, 80.9, 130.6),
  liittymispvm = as.Date(c("2020-01-15", "2022-05-20", "2019-08-10", "2021-03-05", 
                         "2020-11-12", "2022-09-30", "2021-06-18", "2020-07-25", 
                         "2019-12-03", "2022-02-15", "2021-10-22", "2020-04-08", 
                         "2022-08-17", "2021-01-29", "2020-10-14")),
  viimeisin_ostos = as.Date(c("2023-02-10", "2023-01-05", "2023-03-15", "2023-02-20", 
                            "2023-03-01", "2023-01-10", "2023-02-15", "2023-01-20", 
                            "2023-03-10", "2023-02-05", "2023-01-25", "2023-03-05", 
                            "2023-02-25", "2023-01-15", "2023-02-28")),
  kanta_asiakas = c(TRUE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, 
                   TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE),
  stringsAsFactors = FALSE
)

# Tulostetaan data
cat("=== Alkuperäinen data ===\n")
print(asiakkaat)
cat("\n=== Datan rakenne ===\n")
str(asiakkaat)
cat("\n")

# ======== Datan suodattaminen ========

# 1. Perussuodatus - yksittäinen ehto
cat("=== Suodatetaan kanta-asiakkaat ===\n")
kanta_asiakkaat <- asiakkaat[asiakkaat$kanta_asiakas == TRUE, ]
print(nrow(kanta_asiakkaat))
print(head(kanta_asiakkaat))
cat("\n")

# Voidaan myös kirjoittaa yksinkertaisemmin
kanta_asiakkaat <- asiakkaat[asiakkaat$kanta_asiakas, ]  # TRUE/FALSE-vektorilla indeksointi

# 2. Useamman ehdon yhdistäminen AND-operaattorilla (&)
cat("=== Suodatetaan nuoret kanta-asiakkaat (ikä < 40) ===\n")
nuoret_kanta_asiakkaat <- asiakkaat[asiakkaat$kanta_asiakas & asiakkaat$ikä < 40, ]
print(nrow(nuoret_kanta_asiakkaat))
print(nuoret_kanta_asiakkaat)
cat("\n")

# 3. Useamman ehdon yhdistäminen OR-operaattorilla (|)
cat("=== Suodatetaan kanta-asiakkaat TAI paljon ostosten tekijät (>= 15 ostosta) ===\n")
kanta_tai_paljon_ostoksia <- asiakkaat[asiakkaat$kanta_asiakas | asiakkaat$ostoksia >= 15, ]
print(nrow(kanta_tai_paljon_ostoksia))
print(kanta_tai_paljon_ostoksia$asiakas_id)
cat("\n")

# 4. Lukuarvojen alueen suodattaminen
cat("=== Suodatetaan asiakkaat, joiden ikä on 30-50 välillä ===\n")
keski_ikaiset <- asiakkaat[asiakkaat$ikä >= 30 & asiakkaat$ikä <= 50, ]
print(nrow(keski_ikaiset))
print(keski_ikaiset$asiakas_id)
cat("\n")

# 5. Tekstipohjainen suodatus (substring-haku)
cat("=== Suodatetaan asiakkaat, joiden nimessä on 'nen' ===\n")
nen_asiakkaat <- asiakkaat[grepl("nen", asiakkaat$nimi), ]
print(nrow(nen_asiakkaat))
print(nen_asiakkaat$nimi)
cat("\n")

# 6. IN-tyyppinen suodatus (arvo on jossain listassa)
cat("=== Suodatetaan tietyillä postinumeroalueilla asuvat (00-alkuiset) ===\n")
pk_seutu <- asiakkaat[substr(asiakkaat$postinumero, 1, 2) == "00", ]
print(nrow(pk_seutu))
print(pk_seutu$nimi)
cat("\n")

# 7. Päivämääräpohjainen suodatus
cat("=== Suodatetaan vuonna 2022 liittyneet asiakkaat ===\n")
liittyneet_2022 <- asiakkaat[format(asiakkaat$liittymispvm, "%Y") == "2022", ]
print(nrow(liittyneet_2022))
print(liittyneet_2022$nimi)
cat("\n")

# 8. Monimutkainen suodatus
cat("=== Monimutkaisempi suodatus: Kanta-asiakkaat, joilla yli 10 ostosta, ikä alle 50 ja viimeisin ostos 2023-02 ===\n")
monimutkainen_suodatus <- asiakkaat[
  asiakkaat$kanta_asiakas & 
  asiakkaat$ostoksia > 10 & 
  asiakkaat$ikä < 50 &
  format(asiakkaat$viimeisin_ostos, "%Y-%m") == "2023-02", 
]
print(nrow(monimutkainen_suodatus))
print(monimutkainen_suodatus$nimi)
cat("\n")

# 9. Sarakkeiden valinta
cat("=== Valitaan vain tietyt sarakkeet: id, nimi, ikä ===\n")
perustiedot <- asiakkaat[, c("asiakas_id", "nimi", "ikä")]
print(head(perustiedot))
cat("\n")

# 10. Rivien ja sarakkeiden yhdistetty valinta
cat("=== Valitaan kanta-asiakkaiden perustiedot ===\n")
kanta_perustiedot <- asiakkaat[asiakkaat$kanta_asiakas, c("asiakas_id", "nimi", "ikä")]
print(kanta_perustiedot)
cat("\n")

# ======== Uusien muuttujien luominen ========

# Luodaan kopio, jotta alkuperäistä ei muokata
asiakkaat_laaja <- asiakkaat

# 1. Yksinkertainen laskutoimitus
cat("=== Luodaan uusi muuttuja: kokonaisostosten arvo ===\n")
asiakkaat_laaja$kokonaisostokset <- asiakkaat_laaja$ostoksia * asiakkaat_laaja$keskiostos
cat("Ensimmäiset viisi kokonaisostosten arvoa:\n")
print(asiakkaat_laaja$kokonaisostokset[1:5])
cat("\n")

# 2. Luokittelu (categorical variable)
cat("=== Luodaan uusi muuttuja: ikäryhmä ===\n")
asiakkaat_laaja$ikäryhmä <- cut(asiakkaat_laaja$ikä,
                              breaks = c(0, 30, 40, 50, 60, 100),
                              labels = c("alle 30", "30-40", "40-50", "50-60", "yli 60"),
                              right = FALSE)  # Välit ovat [a,b)
print(table(asiakkaat_laaja$ikäryhmä))
cat("\n")

# 3. Päivämäärien käsittely
cat("=== Luodaan uusi muuttuja: asiakkuuden kesto päivissä ===\n")
asiakkaat_laaja$asiakkuuden_kesto <- as.numeric(difftime(Sys.Date(), asiakkaat_laaja$liittymispvm, units = "days"))
cat("Ensimmäiset viisi asiakkuuden kestoa:\n")
print(asiakkaat_laaja$asiakkuuden_kesto[1:5])
cat("\n")

# 4. Tieto kuukausista
cat("=== Luodaan uusi muuttuja: kuukaudet viimeisimmästä ostoksesta ===\n")
asiakkaat_laaja$kk_viim_ostoksesta <- as.numeric(difftime(Sys.Date(), asiakkaat_laaja$viimeisin_ostos, units = "days")) / 30.44  # Keskimääräinen kuukauden pituus
asiakkaat_laaja$kk_viim_ostoksesta <- round(asiakkaat_laaja$kk_viim_ostoksesta, 1)  # Pyöristetään 1 desimaaliin
cat("Kuukaudet viimeisimmästä ostoksesta:\n")
print(asiakkaat_laaja$kk_viim_ostoksesta)
cat("\n")

# 5. Merkkijonojen käsittely
cat("=== Luodaan uusi muuttuja: etu- ja sukunimi erikseen ===\n")
# Erotellaan nimi osiin
nimet_erillään <- strsplit(asiakkaat_laaja$nimi, " ")
asiakkaat_laaja$etunimi <- sapply(nimet_erillään, function(x) x[1])
asiakkaat_laaja$sukunimi <- sapply(nimet_erillään, function(x) x[2])
cat("Ensimmäiset viisi etunimeä ja sukunimeä:\n")
print(asiakkaat_laaja[1:5, c("etunimi", "sukunimi")])
cat("\n")

# 6. Looginen muuttuja (TRUE/FALSE)
cat("=== Luodaan uusi muuttuja: korkea keskiostos ===\n")
# Määritellään korkea keskiostos: yli mediaanin 
mediaani_keskiostos <- median(asiakkaat_laaja$keskiostos)
asiakkaat_laaja$korkea_keskiostos <- asiakkaat_laaja$keskiostos > mediaani_keskiostos
cat("Asiakkaat, joilla on korkea keskiostos:\n")
print(asiakkaat_laaja[asiakkaat_laaja$korkea_keskiostos, c("asiakas_id", "nimi", "keskiostos")])
cat("\n")

# 7. Luodaan pisteytys (scoring)
cat("=== Luodaan uusi muuttuja: asiakasluokitus pisteytyksen perusteella ===\n")
# Pisteytetään asiakkaat: 
# - 1-3 pistettä ostoksista (< 10: 1p, 10-15: 2p, > 15: 3p)
# - 1-3 pistettä keskiostoksesta (< 60: 1p, 60-100: 2p, > 100: 3p)
# - 1-2 pistettä kanta-asiakkuudesta (ei: 1p, kyllä: 2p)
# - 1-2 pistettä tuoreesta ostoksesta (> 2kk: 1p, <= 2kk: 2p)

asiakkaat_laaja$pisteet_ostokset <- cut(asiakkaat_laaja$ostoksia, 
                                      breaks = c(-Inf, 10, 15, Inf), 
                                      labels = c(1, 2, 3))
asiakkaat_laaja$pisteet_ostokset <- as.numeric(as.character(asiakkaat_laaja$pisteet_ostokset))

asiakkaat_laaja$pisteet_keskiostos <- cut(asiakkaat_laaja$keskiostos, 
                                        breaks = c(-Inf, 60, 100, Inf), 
                                        labels = c(1, 2, 3))
asiakkaat_laaja$pisteet_keskiostos <- as.numeric(as.character(asiakkaat_laaja$pisteet_keskiostos))

asiakkaat_laaja$pisteet_kanta <- ifelse(asiakkaat_laaja$kanta_asiakas, 2, 1)

asiakkaat_laaja$pisteet_tuoreus <- ifelse(asiakkaat_laaja$kk_viim_ostoksesta <= 2, 2, 1)

# Lasketaan kokonaispisteet
asiakkaat_laaja$kokonaispisteet <- asiakkaat_laaja$pisteet_ostokset + 
                                 asiakkaat_laaja$pisteet_keskiostos + 
                                 asiakkaat_laaja$pisteet_kanta +
                                 asiakkaat_laaja$pisteet_tuoreus

# Luokitellaan asiakkaat pisteiden perusteella
asiakkaat_laaja$asiakasluokka <- cut(asiakkaat_laaja$kokonaispisteet, 
                                   breaks = c(0, 5, 7, 10), 
                                   labels = c("Perustaso", "Keskitaso", "Premium"))

cat("Asiakkaiden pisteytys ja luokitus:\n")
print(asiakkaat_laaja[, c("asiakas_id", "nimi", "kokonaispisteet", "asiakasluokka")])
cat("\n")

# 8. Z-score standardointi
cat("=== Luodaan uusi muuttuja: standardoitu kokonaisostosten arvo (z-score) ===\n")
asiakkaat_laaja$kokonaisostokset_z <- scale(asiakkaat_laaja$kokonaisostokset)
cat("Standardoidut kokonaisostosten arvot:\n")
print(round(asiakkaat_laaja$kokonaisostokset_z, 2))
cat("\n")

# 9. Minimi-maksimi normalisointi (0-1 välille)
cat("=== Luodaan uusi muuttuja: normalisoitu kokonaisostosten arvo (0-1) ===\n")
min_ostokset <- min(asiakkaat_laaja$kokonaisostokset)
max_ostokset <- max(asiakkaat_laaja$kokonaisostokset)
asiakkaat_laaja$kokonaisostokset_norm <- (asiakkaat_laaja$kokonaisostokset - min_ostokset) / (max_ostokset - min_ostokset)
cat("Normalisoidut kokonaisostosten arvot:\n")
print(round(asiakkaat_laaja$kokonaisostokset_norm, 2))
cat("\n")

# ======== Ryhmittäiset laskelmat ========

cat("=== Ryhmittäiset laskelmat ===\n")

# 1. Keskiarvo sukupuolittain
cat("Keskiostos sukupuolittain:\n")
keskiostokset_sp <- aggregate(keskiostos ~ sukupuoli, data = asiakkaat_laaja, FUN = mean)
print(keskiostokset_sp)
cat("\n")

# 2. Useita laskelmia ikäryhmittäin
cat("Useat laskelmat ikäryhmittäin:\n")
ikaryhmä_yhteenveto <- aggregate(cbind(ostoksia, keskiostos, kokonaisostokset) ~ ikäryhmä, 
                               data = asiakkaat_laaja, 
                               FUN = function(x) c(keskiarvo = mean(x), mediaani = median(x)))
print(ikaryhmä_yhteenveto)
cat("\n")

# 3. Ristiintaulukointi (crosstab)
cat("Ristiintaulukointi: kanta-asiakkaat ikäryhmittäin:\n")
kanta_ikaryhma <- table(asiakkaat_laaja$ikäryhmä, asiakkaat_laaja$kanta_asiakas)
print(kanta_ikaryhma)
cat("\n")

# 4. Suhteelliset osuudet
cat("Suhteelliset osuudet ikäryhmittäin:\n")
prop.table(table(asiakkaat_laaja$ikäryhmä)) * 100
cat("\n")

# ======== Tallenna laajennettu data ========

# Tallennetaan laajennettu data CSV-tiedostoon
write.csv(asiakkaat_laaja, "asiakkaat_laajennettu.csv", row.names = FALSE)
cat("Laajennettu data tallennettu tiedostoon 'asiakkaat_laajennettu.csv'\n\n")

# ======== Edistyneemmät menetelmät (dplyr) ========

# Kommentoidaan pois, jos dplyr ei ole asennettu
# Käyttäjä voi asentaa paketin: install.packages("dplyr")

cat("=== Edistyneet menetelmät dplyr-paketilla ===\n")
cat("Jos haluat kokeilla edistyneempiä tapoja käsitellä dataa, asenna dplyr-paketti:\n")
cat("install.packages('dplyr')\n\n")
cat("Tässä esimerkkejä dplyr-syntaksista:\n")
cat("
library(dplyr)

# Suodatus filter()-funktiolla
kanta_asiakkaat_dplyr <- asiakkaat %>% 
  filter(kanta_asiakas == TRUE)

# Sarakkeiden valinta select()-funktiolla
perustiedot_dplyr <- asiakkaat %>% 
  select(asiakas_id, nimi, ikä)

# Uuden muuttujan luonti mutate()-funktiolla
asiakkaat_ostos_dplyr <- asiakkaat %>% 
  mutate(kokonaisostokset = ostoksia * keskiostos)

# Ryhmittely ja yhteenveto group_by() ja summarise() -funktioilla
sukupuoli_yhteenveto <- asiakkaat %>% 
  group_by(sukupuoli) %>% 
  summarise(
    määrä = n(),
    keski_ikä = mean(ikä),
    keskimääräinen_ostos = mean(keskiostos),
    kanta_asiakkaiden_osuus = mean(kanta_asiakas) * 100
  )
")

# ======== Yhteenveto ========

cat("\n=== Yhteenveto datan suodatuksesta ja muunnoksista ===\n")
cat("Tässä esimerkissä käsittelimme:\n")
cat("1. Datan suodattamista useilla eri kriteereillä\n")
cat("2. Useita tapoja luoda uusia muuttujia\n")
cat("3. Ryhmittäisiä laskelmia\n")
cat("4. Eri tietotyyppien käsittelyä (numerot, teksti, päivämäärät, loogiset arvot)\n\n")

cat("Tärkeimmät huomiot:\n")
cat("- Datan suodatus ja uusien muuttujien luonti ovat keskeisiä data-analyysin vaiheita\n")
cat("- Alkuperäisestä datasta voidaan johtaa lukuisia hyödyllisiä muuttujia\n")
cat("- R tarjoaa monipuoliset työkalut näihin tarkoituksiin\n")
cat("- Edistyneempiin tarpeisiin kannattaa tutustua dplyr-pakettiin\n")
