# Harjoitukset: Datan tuonti ja käsittely
# Tämä tiedosto sisältää harjoituksia datan tuontiin ja käsittelyyn liittyen.

# ======== HARJOITUS 1: Datan lukeminen ========

# Tehtävä 1.1: Luo CSV-tiedosto
# Luo seuraava data.frame ja tallenna se CSV-tiedostoksi "opiskelijat.csv"
opiskelijat <- data.frame(
  opiskelija_id = 1:5,
  nimi = c("Antti", "Maija", "Juha", "Leena", "Pekka"),
  pisteet = c(78, 92, 65, 84, 76),
  läpäisi = c(TRUE, TRUE, FALSE, TRUE, TRUE)
)

# Kirjoita tänne koodi, joka tallentaa opiskelijat-data.framen CSV-tiedostoksi


# Tehtävä 1.2: Lue CSV-tiedosto
# Lue "opiskelijat.csv" takaisin R:ään uuteen muuttujaan. Varmista, että boolean-arvot luetaan oikein.


# Tehtävä 1.3: Tarkastele datan rakennetta
# Käytä sopivia funktioita tarkastellaksesi opiskelijat-datan rakennetta


# ======== HARJOITUS 2: Datan puhdistus ja käsittely ========

# Käytämme tässä esimerkkidataa, jossa on puuttuvia ja virheellisiä arvoja
epäsiisti_data <- data.frame(
  id = 1:8,
  nimi = c("Matti", "Maija", "pekka  ", "  Liisa", "Juha", NA, "Tiina", "  mikko"),
  ikä = c(25, -3, 35, 22, 150, 42, NA, 29),
  palkka = c(3500, 4200, 3800, 9999999, 4100, 3900, 4000, NA)
)

# Tehtävä 2.1: Korjaa puuttuvat ja virheelliset arvot
# - Korjaa nimien muotoilu (ensimmäinen kirjain isoksi, loput pienellä, ei ylimääräisiä välejä)
# - Korvaa virheelliset ikäarvot (negatiiviset ja epärealistiset) NA:lla
# - Korvaa epärealistiset palkka-arvot NA:lla
# - Korvaa puuttuvat arvot sopivilla arvoilla (mieti mikä olisi paras tapa)


# Tehtävä 2.2: Lisää uusi sarake, joka luokittelee palkat
# Luo uusi sarake "palkkaluokka", joka luokittelee palkat seuraavasti:
# - Alle 3800: "Matala"
# - 3800-4000: "Keskitaso"
# - Yli 4000: "Korkea"


# ======== HARJOITUS 3: Datan suodatus ========

# Käytämme myyntidataa harjoitusten pohjana
myyntidata <- data.frame(
  tuote_id = c(101, 102, 103, 104, 105, 101, 102, 103, 104, 105),
  päivämäärä = as.Date(c("2023-01-15", "2023-01-20", "2023-01-25", "2023-01-30", 
                        "2023-02-05", "2023-02-10", "2023-02-15", "2023-02-20", 
                        "2023-02-25", "2023-03-01")),
  myyjä = c("Antti", "Maija", "Antti", "Pekka", "Leena", "Maija", "Antti", "Leena", "Pekka", "Antti"),
  määrä = c(5, 3, 7, 2, 4, 6, 2, 8, 3, 5),
  hinta = c(50, 120, 35, 80, 65, 50, 120, 35, 80, 65),
  alue = c("Etelä", "Länsi", "Etelä", "Pohjoinen", "Itä", "Länsi", "Etelä", "Itä", "Pohjoinen", "Länsi")
)

# Tehtävä 3.1: Suodata tammikuun myynnit
# Luo data.frame, joka sisältää vain tammikuun myynnit


# Tehtävä 3.2: Suodata Antin myynnit eteläisellä alueella
# Luo data.frame, joka sisältää vain myyjä Antin myynnit eteläisellä alueella


# Tehtävä 3.3: Suodata tuotteet, joiden hinta on vähintään 70 euroa
# Luo data.frame, joka sisältää vain tuotteet, joiden hinta on vähintään 70 euroa


# ======== HARJOITUS 4: Uusien muuttujien luominen ========

# Jatkamme myyntidatan käsittelyä

# Tehtävä 4.1: Laske kokonaissumma
# Lisää myyntidataan uusi sarake "summa", joka on tuotteen määrä kerrottuna hinnalla


# Tehtävä 4.2: Luo aikaan liittyviä muuttujia
# Lisää myyntidataan uudet sarakkeet:
# - "kuukausi": kuukausinumero (1, 2, 3, ...)
# - "viikonpäivä": päivän nimi (maanantai, tiistai, ...)


# Tehtävä 4.3: Luo kategorisoivia muuttujia
# Lisää myyntidataan uusi sarake "määräluokka", joka luokittelee myynnit seuraavasti:
# - 1-3 kpl: "Pieni"
# - 4-6 kpl: "Keskikoko"
# - 7+ kpl: "Suuri"


# ======== HARJOITUS 5: Datan yhdistäminen ========

# Luodaan kaksi datasettiä, jotka voidaan yhdistää
tuotteet <- data.frame(
  tuote_id = c(101, 102, 103, 104, 105),
  tuotenimi = c("Kahvi", "Tee", "Sokeri", "Maito", "Leipä"),
  kategoria = c("Juomat", "Juomat", "Mausteet", "Maitotuotteet", "Leivonnaiset"),
  varastossa = c(150, 80, 200, 95, 30),
  stringsAsFactors = FALSE
)

myyjät <- data.frame(
  myyjä = c("Antti", "Maija", "Pekka", "Leena", "Juha"),
  myyjä_id = c(1, 2, 3, 4, 5),
  osasto = c("Elintarvikkeet", "Elintarvikkeet", "Kodinkoneet", "Elintarvikkeet", "Elektroniikka"),
  palveluvuodet = c(5, 3, 7, 2, 4),
  stringsAsFactors = FALSE
)

# Tehtävä 5.1: Yhdistä myyntidata ja tuotetiedot
# Yhdistä myyntidata ja tuotteet siten, että saat tuotenimet mukaan myyntidataan


# Tehtävä 5.2: Yhdistä myyntidata ja myyjien tiedot
# Yhdistä myyntidata ja myyjät siten, että saat myyjien osastot ja palveluvuodet mukaan myyntidataan


# Tehtävä 5.3: Luo kokonaisvaltainen raportti
# Yhdistä myyntidata, tuotetiedot ja myyjien tiedot siten, että saat kaikki tiedot samaan taulukkoon


# ======== HARJOITUS 6: Datan aggregointi ja ryhmittely ========

# Käytämme edelleen myyntidataa ja siihen yhdistettyjä tietoja

# Tehtävä 6.1: Laske myynti myyjittäin
# Laske kunkin myyjän kokonaismyynti (määrä * hinta)


# Tehtävä 6.2: Laske myynti alueittain ja kategorioittain
# Yhdistä ensin tuotetiedot myyntidataan, ja laske sitten myynti alueittain ja tuotekategorioittain


# Tehtävä 6.3: Laske kuukausittainen myynti
# Muodosta kuukausittainen myyntiraportti, jossa näkyy kunkin kuukauden kokonaismyynti


# ======== HARJOITUS 7: Datan muuntaminen (reshaping) ========

# Luodaan uusi data.frame myynneistä kuukausittain ja myyjittäin
myynti_kvartaaleittain <- data.frame(
  myyjä = c("Antti", "Maija", "Pekka", "Leena"),
  Q1 = c(15000, 12000, 9000, 11000),
  Q2 = c(17000, 13500, 9500, 12000),
  Q3 = c(14000, 11000, 8500, 10500),
  Q4 = c(18000, 14000, 10000, 13000),
  stringsAsFactors = FALSE
)

# Tehtävä 7.1: Muunna data leveästä pitkään muotoon
# Muunna myynti_kvartaaleittain pitkään muotoon, jossa on sarakkeet:
# - myyjä
# - kvartaali (Q1, Q2, Q3, Q4)
# - myynti


# Tehtävä 7.2: Muunna data takaisin leveään muotoon
# Muunna edellisessä tehtävässä luotu pitkä data takaisin leveään muotoon


# ======== HARJOITUS 8: Datan tallennus eri muodoissa ========

# Tehtävä 8.1: Tallenna myyntidata CSV-tiedostoon
# Tallenna myyntidata CSV-tiedostoksi "myyntidata.csv"


# Tehtävä 8.2: Tallenna tuotetiedot Excel-tiedostoon (jos writexl on asennettu)
# Tallenna tuotteet Excel-tiedostoksi "tuotteet.xlsx"


# Tehtävä 8.3: Tallenna useita data.frameja RData-tiedostoon
# Tallenna sekä myyntidata että tuotteet samaan RData-tiedostoon "myynti_analyysi.RData"


# ======== MALLIVASTAUKSET ========

# Tässä osiossa on mallivastaukset kaikkiin tehtäviin.
# Suosittelemme yrittämään ensin itse ennen malliratkaisujen katsomista.

# --- HARJOITUS 1: Mallivastaukset ---

# Tehtävä 1.1
# write.csv(opiskelijat, "opiskelijat.csv", row.names = FALSE)

# Tehtävä 1.2
# opiskelijat_luettu <- read.csv("opiskelijat.csv", stringsAsFactors = FALSE)
# opiskelijat_luettu$läpäisi <- as.logical(opiskelijat_luettu$läpäisi)

# Tehtävä 1.3
# str(opiskelijat_luettu)
# head(opiskelijat_luettu)
# summary(opiskelijat_luettu)

# --- HARJOITUS 2: Mallivastaukset ---

# Tehtävä 2.1
# puhdas_data <- epäsiisti_data
# # Korjaa nimet
# puhdas_data$nimi <- trimws(puhdas_data$nimi)
# puhdas_data$nimi <- paste0(toupper(substr(puhdas_data$nimi, 1, 1)), 
#                           tolower(substr(puhdas_data$nimi, 2, nchar(puhdas_data$nimi))))
# # Korjaa ikä
# puhdas_data$ikä[puhdas_data$ikä < 0 | puhdas_data$ikä > 120] <- NA
# # Korjaa palkka
# puhdas_data$palkka[puhdas_data$palkka > 10000] <- NA
# # Täytä puuttuvat arvot
# puhdas_data$nimi[is.na(puhdas_data$nimi)] <- "Tuntematon"
# puhdas_data$ikä[is.na(puhdas_data$ikä)] <- mean(puhdas_data$ikä, na.rm = TRUE)
# puhdas_data$palkka[is.na(puhdas_data$palkka)] <- median(puhdas_data$palkka, na.rm = TRUE)

# Tehtävä 2.2
# puhdas_data$palkkaluokka <- cut(puhdas_data$palkka,
#                                breaks = c(-Inf, 3800, 4000, Inf),
#                                labels = c("Matala", "Keskitaso", "Korkea"))

# --- HARJOITUS 3: Mallivastaukset ---

# Tehtävä 3.1
# tammikuu_myynnit <- myyntidata[format(myyntidata$päivämäärä, "%m") == "01", ]
# # Vaihtoehtoisesti:
# tammikuu_myynnit <- myyntidata[myyntidata$päivämäärä >= as.Date("2023-01-01") & 
#                              myyntidata$päivämäärä <= as.Date("2023-01-31"), ]

# Tehtävä 3.2
# antti_etelä <- myyntidata[myyntidata$myyjä == "Antti" & myyntidata$alue == "Etelä", ]

# Tehtävä 3.3
# kalliit_tuotteet <- myyntidata[myyntidata$hinta >= 70, ]

# --- HARJOITUS 4: Mallivastaukset ---

# Tehtävä 4.1
# myyntidata$summa <- myyntidata$määrä * myyntidata$hinta

# Tehtävä 4.2
# myyntidata$kuukausi <- as.numeric(format(myyntidata$päivämäärä, "%m"))
# myyntidata$viikonpäivä <- weekdays(myyntidata$päivämäärä)

# Tehtävä 4.3
# myyntidata$määräluokka <- cut(myyntidata$määrä,
#                              breaks = c(0, 3, 6, Inf),
#                              labels = c("Pieni", "Keskikoko", "Suuri"),
#                              right = FALSE)

# --- HARJOITUS 5: Mallivastaukset ---

# Tehtävä 5.1
# myynti_tuotteet <- merge(myyntidata, tuotteet, by = "tuote_id")

# Tehtävä 5.2
# myynti_myyjät <- merge(myyntidata, myyjät, by = "myyjä")

# Tehtävä 5.3
# kokonaisraportti <- merge(merge(myyntidata, tuotteet, by = "tuote_id"), myyjät, by = "myyjä")

# --- HARJOITUS 6: Mallivastaukset ---

# Tehtävä 6.1
# myyntidata$summa <- myyntidata$määrä * myyntidata$hinta
# myynti_myyjittäin <- aggregate(summa ~ myyjä, data = myyntidata, FUN = sum)

# Tehtävä 6.2
# myynti_tuotteet <- merge(myyntidata, tuotteet, by = "tuote_id")
# myynti_tuotteet$summa <- myynti_tuotteet$määrä * myynti_tuotteet$hinta
# myynti_alue_kategoria <- aggregate(summa ~ alue + kategoria, 
#                                   data = myynti_tuotteet, FUN = sum)

# Tehtävä 6.3
# myyntidata$summa <- myyntidata$määrä * myyntidata$hinta
# myyntidata$kuukausi <- format(myyntidata$päivämäärä, "%Y-%m")
# kuukausimyynti <- aggregate(summa ~ kuukausi, data = myyntidata, FUN = sum)

# --- HARJOITUS 7: Mallivastaukset ---

# Tehtävä 7.1
# pitkä_muoto <- reshape(myynti_kvartaaleittain, 
#                       direction = "long",
#                       varying = list(c("Q1", "Q2", "Q3", "Q4")),
#                       v.names = "myynti",
#                       idvar = "myyjä",
#                       timevar = "kvartaali",
#                       times = c("Q1", "Q2", "Q3", "Q4"))
# rownames(pitkä_muoto) <- NULL

# Tehtävä 7.2
# leveä_muoto <- reshape(pitkä_muoto,
#                       direction = "wide",
#                       idvar = "myyjä",
#                       timevar = "kvartaali")
# # Siistimme sarakenimet (poistamme "myynti." etuliitteen)
# names(leveä_muoto) <- gsub("myynti.", "", names(leveä_muoto))

# --- HARJOITUS 8: Mallivastaukset ---

# Tehtävä 8.1
# write.csv(myyntidata, "myyntidata.csv", row.names = FALSE)

# Tehtävä 8.2
# if (requireNamespace("writexl", quietly = TRUE)) {
#   library(writexl)
#   write_xlsx(tuotteet, "tuotteet.xlsx")
# } else {
#   print("writexl-paketti ei ole asennettu")
# }

# Tehtävä 8.3
# save(myyntidata, tuotteet, file = "myynti_analyysi.RData")
