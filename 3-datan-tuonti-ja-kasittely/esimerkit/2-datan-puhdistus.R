# 2. Datan esikäsittely ja puuttuvien arvojen käsittely - Esimerkkikoodi
# Tämä R-skripti demonstroi, miten käsitellä ja puhdistaa dataa sekä miten käsitellä puuttuvia arvoja

# ======== Luodaan esimerkkidata, jossa on ongelmia ========

# Käytetään set.seed, jotta tulokset ovat toistettavissa
set.seed(123)

# Luodaan data frame, jossa on puuttuvia arvoja ja muita ongelmia
ongelma_data <- data.frame(
  ID = 1:10,
  Nimi = c("Matti", "Maija ", "pekka", "  Liisa", "Juha", "Antti", NA, "tiina", "Mikko", "Kaisa"),
  Ikä = c(25, 32, NA, 28, 51, NA, 42, 35, 29, 45),
  Sukupuoli = c("mies", "nainen", "mies", "nainen", "mies", NA, "mies", "nainen", NA, "nainen"),
  Tulot = c(2800, 3200, 4100, -100, 3900, 2500, 3800, NA, 3100, 10000000),
  Päivämäärä = c("2023-01-15", "2023/02/20", "15.3.2023", NA, "2023-05-10", 
                "2023-06-15", "2023-07-20", "2023-08-15", "2023-09-10", "2023-10-15"),
  Postinumero = c("00100", "00200", "33720", "00300", "90100", "33200", "00500", "00400", "33100", "Ab123"),
  stringsAsFactors = FALSE
)

# Lisätään duplikaatti
ongelma_data <- rbind(ongelma_data, ongelma_data[2, ])

# Tulostetaan luotu data
cat("=== Alkuperäinen ongelma_data ===\n")
print(ongelma_data)
cat("\n")

# ======== Datan rakenteen tarkastelu ========

cat("=== Datan rakenne ===\n")
str(ongelma_data)
cat("\n")

cat("=== Yhteenveto datasta ===\n")
print(summary(ongelma_data))
cat("\n")

# Tarkistetaan puuttuvat arvot
cat("=== Puuttuvien arvojen määrä sarakkeittain ===\n")
print(colSums(is.na(ongelma_data)))
cat("\n")

cat("=== Puuttuvien arvojen kokonaismäärä ===\n")
print(sum(is.na(ongelma_data)))
cat("\n")

# ======== Puuttuvien arvojen visualisointi (jos mahdollista) ========

if (requireNamespace("VIM", quietly = TRUE)) {
  cat("VIM-paketti on asennettu, visualisoidaan puuttuvat arvot.\n")
  library(VIM)
  png("puuttuvat_arvot.png")
  aggr(ongelma_data, col = c("navyblue", "red"), numbers = TRUE, sortVars = TRUE, 
       labels = names(ongelma_data), cex.axis = 0.7, gap = 3, 
       ylab = c("Puuttuvien osuus", "Puuttuvien yhdistelmät"))
  dev.off()
  cat("Puuttuvien arvojen visualisointi tallennettu tiedostoon 'puuttuvat_arvot.png'\n\n")
} else {
  cat("VIM-paketti ei ole asennettu. Puuttuvien arvojen visualisointia ei suoriteta.\n")
  cat("Voit asentaa paketin komennolla: install.packages('VIM')\n\n")
}

# ======== Datan puhdistus ========

# Luodaan kopio, jotta alkuperäistä ei muuteta
puhdas_data <- ongelma_data

# Poistetaan duplikaatit
cat("=== Tarkistetaan duplikaatit ===\n")
cat("Duplikaattien määrä: ", sum(duplicated(puhdas_data)), "\n\n")

puhdas_data <- unique(puhdas_data)
cat("=== Duplikaattien poiston jälkeen ===\n")
cat("Rivien määrä ennen: ", nrow(ongelma_data), "\n")
cat("Rivien määrä jälkeen: ", nrow(puhdas_data), "\n\n")

# Siivotaan merkkijonoja
cat("=== Siivotaan merkkijonoja ===\n")
cat("Alkuperäiset nimet: ", paste(puhdas_data$Nimi, collapse = ", "), "\n")

# Poistetaan ylimääräiset välilyönnit
puhdas_data$Nimi <- trimws(puhdas_data$Nimi)

# Muunnetaan ensimmäinen kirjain isoksi, loput pieniksi
puhdas_data$Nimi <- paste0(toupper(substr(puhdas_data$Nimi, 1, 1)), 
                          tolower(substr(puhdas_data$Nimi, 2, nchar(puhdas_data$Nimi))))

cat("Siivotut nimet: ", paste(puhdas_data$Nimi, collapse = ", "), "\n\n")

# Tarkistetaan arvoalueet ja korjataan virheelliset arvot
cat("=== Tarkistetaan arvoalueet ===\n")
cat("Alkuperäiset tulot: ", paste(puhdas_data$Tulot, collapse = ", "), "\n")

# Korjataan negatiiviset ja epärealistisen suuret tulot (asetetaan NA:ksi)
puhdas_data$Tulot[puhdas_data$Tulot < 0 | puhdas_data$Tulot > 100000] <- NA

cat("Korjatut tulot: ", paste(puhdas_data$Tulot, collapse = ", "), "\n\n")

# Standardoidaan päivämäärät
cat("=== Standardoidaan päivämäärät ===\n")
cat("Alkuperäiset päivämäärät: ", paste(puhdas_data$Päivämäärä, collapse = ", "), "\n")

# Käsitellään päivämäärät yhtenäiseen muotoon
# Kokeillaan eri formaatteja
standardoi_pvm <- function(pvm) {
  if (is.na(pvm)) return(NA)
  
  # Kokeillaan eri formaatteja
  formaatit <- c("%Y-%m-%d", "%Y/%m/%d", "%d.%m.%Y")
  
  for (fmt in formaatit) {
    tulos <- tryCatch({
      as.Date(pvm, format = fmt)
    }, error = function(e) {
      NULL
    })
    
    if (!is.null(tulos) && !is.na(tulos)) {
      return(format(tulos, "%Y-%m-%d"))
    }
  }
  
  return(NA)  # Jos mikään formaatti ei toimi
}

puhdas_data$Päivämäärä <- sapply(puhdas_data$Päivämäärä, standardoi_pvm)

cat("Standardoidut päivämäärät: ", paste(puhdas_data$Päivämäärä, collapse = ", "), "\n\n")

# Tarkistetaan postinumerot
cat("=== Tarkistetaan postinumerot ===\n")
cat("Alkuperäiset postinumerot: ", paste(puhdas_data$Postinumero, collapse = ", "), "\n")

# Tarkistetaan, että postinumero on 5 numeroa
puhdas_data$Postinumero <- ifelse(grepl("^\\d{5}$", puhdas_data$Postinumero), 
                                 puhdas_data$Postinumero, NA)

cat("Tarkistetut postinumerot: ", paste(puhdas_data$Postinumero, collapse = ", "), "\n\n")

# ======== Puuttuvien arvojen käsittely ========

cat("=== Puuttuvien arvojen käsittely ===\n")

# 1. Yksinkertainen imputointi: Korvaa puuttuvat arvot keskiarvolla (numeeriset)
cat("Ikä ennen imputointia: ", paste(puhdas_data$Ikä, collapse = ", "), "\n")
puhdas_data$Ikä[is.na(puhdas_data$Ikä)] <- round(mean(puhdas_data$Ikä, na.rm = TRUE))
cat("Ikä keskiarvolla imputoinnin jälkeen: ", paste(puhdas_data$Ikä, collapse = ", "), "\n\n")

# 2. Mediaani imputointi tuloille
cat("Tulot ennen imputointia: ", paste(puhdas_data$Tulot, collapse = ", "), "\n")
puhdas_data$Tulot[is.na(puhdas_data$Tulot)] <- median(puhdas_data$Tulot, na.rm = TRUE)
cat("Tulot mediaanilla imputoinnin jälkeen: ", paste(puhdas_data$Tulot, collapse = ", "), "\n\n")

# 3. Moodi imputointi kategorialle (sukupuoli)
cat("Sukupuoli ennen imputointia: ", paste(puhdas_data$Sukupuoli, collapse = ", "), "\n")
# Lasketaan moodi (yleisin arvo)
moodi_sukupuoli <- names(sort(table(puhdas_data$Sukupuoli), decreasing = TRUE))[1]
puhdas_data$Sukupuoli[is.na(puhdas_data$Sukupuoli)] <- moodi_sukupuoli
cat("Sukupuoli moodilla imputoinnin jälkeen: ", paste(puhdas_data$Sukupuoli, collapse = ", "), "\n\n")

# 4. Lähin naapuri -imputointi (ei toteuteta tässä yksinkertaisessa esimerkissä)
# Vaatisi knn-imputointia, esim. VIM-paketin kNN-funktiolla

# 5. Rivien poistaminen (ei suositella, jos dataa on vähän)
# Esimerkki: poistetaan rivit, joissa on puuttuvia arvoja päivämäärässä
cat("Rivien määrä ennen päivämäärän NA-rivien poistoa: ", nrow(puhdas_data), "\n")
puhdas_data_complete_dates <- puhdas_data[!is.na(puhdas_data$Päivämäärä), ]
cat("Rivien määrä päivämäärän NA-rivien poiston jälkeen: ", nrow(puhdas_data_complete_dates), "\n\n")

# 6. Kehittyneempi imputointi mice-paketilla (vain demonstrointi, ei suoriteta)
cat("Kehittyneempi imputointi mice-paketilla vaatisi seuraavan koodin:\n")
cat("
library(mice)
imputed_data <- mice(puhdas_data, m = 5, method = 'pmm')
complete_data <- complete(imputed_data)
\n")

# ======== Tietojen tyyppien muuntaminen ========

cat("=== Tietojen tyyppien muuntaminen ===\n")

# Muunnetaan ikä numeroksi
puhdas_data$Ikä <- as.numeric(puhdas_data$Ikä)

# Muunnetaan sukupuoli faktoriksi
puhdas_data$Sukupuoli <- factor(puhdas_data$Sukupuoli, levels = c("mies", "nainen"))

# Muunnetaan päivämäärä Date-tyypiksi
puhdas_data$Päivämäärä <- as.Date(puhdas_data$Päivämäärä)

# Tulostetaan muunnetut tiedot
str(puhdas_data)
cat("\n")

# ======== Yhteenveto puhdistetusta datasta ========

cat("=== Yhteenveto puhdistetusta datasta ===\n")
print(summary(puhdas_data))
cat("\n")

cat("=== Puuttuvien arvojen määrä puhdistetun datan sarakkeittain ===\n")
print(colSums(is.na(puhdas_data)))
cat("\n")

cat("=== Puhdistetun datan rakenne ===\n")
str(puhdas_data)
cat("\n")

# ======== Tallennetaan puhdistettu data ========

# Tallenna CSV-muodossa
write.csv(puhdas_data, "puhdas_data.csv", row.names = FALSE)
cat("Puhdistettu data tallennettu tiedostoon 'puhdas_data.csv'\n")

# ======== Yhteenveto ========

cat("\n=== Yhteenveto datan puhdistuksesta ===\n")
cat("Suoritimme seuraavat toimenpiteet:\n")
cat("1. Duplikaattien poistaminen\n")
cat("2. Merkkijonojen siistiminen (nimet)\n")
cat("3. Virheellisten arvojen korjaaminen (tulot)\n")
cat("4. Päivämäärien standardointi\n")
cat("5. Puuttuvien arvojen käsittely eri tekniikoilla\n")
cat("6. Tietotyyppien muuntaminen sopivaan muotoon\n\n")

cat("Tärkeimmät huomiot:\n")
cat("- Puhdistaminen on usein datan käsittelyn aikaa vievin vaihe\n")
cat("- Puuttuvien arvojen käsittelyyn on useita strategioita\n")
cat("- Datan laatu vaikuttaa suoraan analyysien luotettavuuteen\n")
cat("- Automatisoitu datan puhdistus vaatii aina manuaalista tarkistusta\n")
