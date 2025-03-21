# 1. Peruskuvaajat R:ssä
# Tämä skripti esittelee R:n perusgrafiikoiden käyttöä eri kuvaajatyyppien luomiseen

# ======== Luodaan esimerkkidataa ========

# Luodaan numerodataa
x <- 1:10  # Luvut 1-10
y <- c(5, 9, 3, 10, 12, 8, 14, 7, 13, 15)  # Satunnaisia arvoja

# Luodaan kategoriset arvot
kategoriat <- c("A", "B", "C", "D", "E")
arvot <- c(10, 24, 15, 8, 17)

# Luodaan satunnaislukuja normaalijakaumasta
set.seed(123)  # Asetetaan siemen tulosten toistettavuuden vuoksi
normaalidata <- rnorm(1000, mean = 50, sd = 10)

# Luodaan ryhmitellyt arvot
ryhmä1 <- rnorm(100, mean = 10, sd = 2)
ryhmä2 <- rnorm(100, mean = 15, sd = 3)
ryhmä3 <- rnorm(100, mean = 8, sd = 1.5)
ryhmät <- list(A = ryhmä1, B = ryhmä2, C = ryhmä3)

# ======== 1. Pistekaavio (Scatter Plot) ========

# Yksinkertainen pistekaavio
plot(x, y)

# Muokattu pistekaavio
plot(x, y,
     main = "X:n ja Y:n välinen suhde",    # Otsikko
     xlab = "X-arvo",                      # X-akselin nimi
     ylab = "Y-arvo",                      # Y-akselin nimi
     pch = 19,                             # Pisteen tyyppi (täytetty ympyrä)
     col = "blue",                         # Pisteiden väri
     cex = 1.5)                            # Pisteiden koko

# Lisätään ruudukko
grid()

# ======== 2. Viivakuvaaja (Line Plot) ========

# Yksinkertainen viivakuvaaja
plot(x, y, type = "l")

# Muokattu viivakuvaaja
plot(x, y,
     type = "l",                           # "l" = viiva, "p" = pisteet, "b" = molemmat
     main = "Viivakuvaaja",                # Otsikko
     xlab = "X-arvo",                      # X-akselin nimi
     ylab = "Y-arvo",                      # Y-akselin nimi
     col = "red",                          # Viivan väri
     lwd = 2,                              # Viivan paksuus
     lty = 1)                              # Viivan tyyppi (1 = yhtenäinen)

# Eri viivan tyyppejä
par(mfrow = c(2, 3))  # Jaetaan kuva-alue 2x3 ruudukkoon

plot(x, y, type = "l", lty = 1, main = "Yhtenäinen (1)")
plot(x, y, type = "l", lty = 2, main = "Katkoviiva (2)")
plot(x, y, type = "l", lty = 3, main = "Pisteviiva (3)")
plot(x, y, type = "l", lty = 4, main = "Piste-katkoviiva (4)")
plot(x, y, type = "l", lty = 5, main = "Pitkä katko (5)")
plot(x, y, type = "l", lty = 6, main = "Kaksi pistettä, katko (6)")

par(mfrow = c(1, 1))  # Palautetaan yksi kuva-alue

# ======== 3. Pylväsdiagrammi (Bar Plot) ========

# Yksinkertainen pylväsdiagrammi
barplot(arvot)

# Muokattu pylväsdiagrammi
barplot(arvot,
        names.arg = kategoriat,            # Kategorioiden nimet
        main = "Pylväsdiagrammi",          # Otsikko
        xlab = "Kategoria",                # X-akselin nimi
        ylab = "Arvo",                     # Y-akselin nimi
        col = "skyblue",                   # Pylväiden väri
        border = "darkblue")               # Pylväiden reunojen väri

# Vaakasuora pylväsdiagrammi
barplot(arvot, 
        names.arg = kategoriat,
        main = "Vaakasuora pylväsdiagrammi",
        xlab = "Arvo",
        ylab = "Kategoria",
        col = rainbow(length(arvot)),      # Eri värit jokaiselle pylväälle
        horiz = TRUE)                      # Vaakasuora

# ======== 4. Histogrammi (Histogram) ========

# Yksinkertainen histogrammi
hist(normaalidata)

# Muokattu histogrammi
hist(normaalidata,
     breaks = 30,                          # Luokkien (pylväiden) määrä
     main = "Histogrammi",                 # Otsikko
     xlab = "Arvo",                        # X-akselin nimi
     ylab = "Frekvenssi",                  # Y-akselin nimi
     col = "lightgreen",                   # Pylväiden väri
     border = "darkgreen")                 # Pylväiden reunojen väri

# Histogrammi tiheysfunktiolla
hist(normaalidata,
     breaks = 30,
     freq = FALSE,                         # Näytetään tiheys frekvenssin sijaan
     main = "Histogrammi tiheysfunktiolla",
     xlab = "Arvo",
     ylab = "Tiheys",
     col = "pink",
     border = "red")

# Lisätään normaalijakauman tiheysfunktio
curve(dnorm(x, mean = mean(normaalidata), sd = sd(normaalidata)),
      add = TRUE,                          # Lisää olemassa olevaan kuvaajaan
      col = "blue",
      lwd = 2)

# ======== 5. Laatikkokaavio (Box Plot) ========

# Yksinkertainen laatikkokaavio
boxplot(normaalidata)

# Muokattu laatikkokaavio
boxplot(normaalidata,
        main = "Laatikkokaavio",           # Otsikko
        ylab = "Arvo",                     # Y-akselin nimi
        col = "orange",                    # Laatikon väri
        border = "brown")                  # Laatikon reunojen väri

# Useiden ryhmien vertailu laatikkokaaviolla
boxplot(ryhmät,
        main = "Ryhmien vertailu",         # Otsikko
        xlab = "Ryhmä",                    # X-akselin nimi
        ylab = "Arvo",                     # Y-akselin nimi
        col = c("red", "green", "blue"),   # Eri väri jokaiselle ryhmälle
        notch = TRUE)                      # Lisää lovet mediaanin ympärille (95% luottamusvälit)

# ======== 6. Piirakkakaavio (Pie Chart) ========

# Yksinkertainen piirakkakaavio
pie(arvot)

# Muokattu piirakkakaavio
pie(arvot,
    labels = kategoriat,                   # Kategorioiden nimet
    main = "Piirakkakaavio",               # Otsikko
    col = rainbow(length(arvot)),          # Eri väri jokaiselle sektorille
    clockwise = TRUE)                      # Luetaan myötäpäivään (oletuksena vastapäivään)

# Piirakkakaavio prosenttiosuuksilla
osuudet <- round(100 * arvot / sum(arvot), 1)
labels <- paste(kategoriat, "(", osuudet, "%)", sep = "")
pie(arvot,
    labels = labels,
    main = "Piirakkakaavio prosenttiosuuksilla",
    col = heat.colors(length(arvot)))      # Toinen väripaletti

# ======== 7. Hajontamatriisi (Scatter Plot Matrix) ========

# Luodaan monimutkainen dataset
df <- data.frame(
  x = x,
  y = y,
  z = x * y,
  w = log(x)
)

# Yksinkertainen hajontamatriisi
pairs(df)

# Muokattu hajontamatriisi
pairs(df,
      main = "Hajontamatriisi",            # Otsikko
      pch = 19,                            # Pisteen tyyppi
      col = "purple",                      # Pisteiden väri
      upper.panel = NULL)                  # Ei kuvaajia yläkolmioon

# ======== 8. Useiden kuvaajien yhdistäminen ========

# Jaetaan kuva-alue 2x2 ruudukkoon
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))  # mar: marginaalit (ala, vasen, ylä, oikea)

# Pistekaavio
plot(x, y, pch = 19, col = "blue", main = "Pistekaavio")

# Viivakuvaaja
plot(x, y, type = "l", col = "red", lwd = 2, main = "Viivakuvaaja")

# Histogrammi
hist(normaalidata, breaks = 20, col = "lightgreen", main = "Histogrammi")

# Laatikkokaavio
boxplot(ryhmät, col = c("red", "green", "blue"), main = "Laatikkokaavio")

# Palautetaan yksi kuva-alue
par(mfrow = c(1, 1))

# ======== 9. Kuvaajien tallentaminen ========

# Tallennetaan PNG-tiedostona
png("pistekaavio.png", width = 800, height = 600)
plot(x, y, 
     pch = 19, 
     col = "blue", 
     main = "Tallennettava pistekaavio",
     cex = 2)
dev.off()  # Suljetaan grafiikkalaite ja tallennetaan kuva

# Tallennetaan PDF-tiedostona
pdf("kuvaaja_kokoelma.pdf", width = 10, height = 8)
par(mfrow = c(2, 2))
plot(x, y, pch = 19, main = "Pistekaavio")
plot(x, y, type = "l", main = "Viivakuvaaja")
hist(normaalidata, main = "Histogrammi")
boxplot(ryhmät, main = "Laatikkokaavio")
dev.off()  # Suljetaan grafiikkalaite ja tallennetaan kuva

# ======== Yhteenveto ========

cat("Tässä esimerkissä opimme luomaan erilaisia peruskuvaajia R:llä:\n")
cat("1. Pistekaavio (Scatter Plot)\n")
cat("2. Viivakuvaaja (Line Plot)\n")
cat("3. Pylväsdiagrammi (Bar Plot)\n")
cat("4. Histogrammi (Histogram)\n")
cat("5. Laatikkokaavio (Box Plot)\n")
cat("6. Piirakkakaavio (Pie Chart)\n")
cat("7. Hajontamatriisi (Scatter Plot Matrix)\n")
cat("8. Useiden kuvaajien yhdistäminen\n")
cat("9. Kuvaajien tallentaminen\n")
cat("\nJokaista kuvaajaa voi muokata monin tavoin, kuten väreillä, pistetyypeillä,\n")
cat("viivatyypeillä, otsikoilla ja akselien nimillä.\n")
