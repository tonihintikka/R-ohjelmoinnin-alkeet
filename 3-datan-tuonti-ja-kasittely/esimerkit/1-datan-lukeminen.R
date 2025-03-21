# 1. Datan lukeminen eri tiedostomuodoista - Esimerkkikoodi
# Tämä R-skripti demonstroi, miten lukea dataa eri tiedostomuodoista R:ään

# ======== CSV-tiedostot ========

# Luodaan ensin esimerkkidata, jota voidaan käyttää eri muotojen testaamiseen
esimerkkidata <- data.frame(
  nimi = c("Matti", "Maija", "Pekka", "Liisa", "Juha"),
  ikä = c(25, 32, 45, 28, 51),
  sukupuoli = c("mies", "nainen", "mies", "nainen", "mies"),
  tulot = c(2800, 3200, 4100, 3500, 3900),
  stringsAsFactors = FALSE
)

# Tallennetaan data CSV-tiedostoksi
write.csv(esimerkkidata, "esimerkkidata.csv", row.names = FALSE)

# Peruslukeminen CSV-tiedostosta
data_csv <- read.csv("esimerkkidata.csv")
print("CSV-tiedostosta luettu data:")
print(head(data_csv))
print(str(data_csv))

# Parametrien käyttäminen
data_csv_params <- read.csv("esimerkkidata.csv",
                           header = TRUE,           # Ensimmäinen rivi on otsikkorivi
                           sep = ",",               # Erotin on pilkku
                           dec = ".",               # Desimaalien erotin on piste
                           stringsAsFactors = FALSE) # Älä muunna merkkijonoja factoreiksi
print("CSV-tiedostosta parametreilla luettu data:")
print(str(data_csv_params))

# Kokeillaan suomalaistyylistä CSV-tiedostoa (puolipiste erottimena, pilkku desimaalierottimena)
# Luodaan ensin sellainen
write.csv2(esimerkkidata, "esimerkkidata_fi.csv", row.names = FALSE)

# Luetaan suomalaistyyppinen CSV
data_csv_fi <- read.csv2("esimerkkidata_fi.csv")
print("Suomalaistyylisestä CSV:stä luettu data:")
print(head(data_csv_fi))

# ======== Tekstitiedostot ========

# Tallennetaan tavallisena tekstinä (välilyönneillä erotettuna)
write.table(esimerkkidata, "esimerkkidata.txt", 
            row.names = FALSE, quote = TRUE)

# Luetaan tekstitiedosto
data_txt <- read.table("esimerkkidata.txt", header = TRUE)
print("Tekstitiedostosta luettu data:")
print(head(data_txt))

# Tallennetaan tab-erotettuna (TSV)
write.table(esimerkkidata, "esimerkkidata.tsv", 
            row.names = FALSE, sep = "\t")

# Luetaan TSV-tiedosto
data_tsv <- read.table("esimerkkidata.tsv", 
                      header = TRUE, sep = "\t")
print("TSV-tiedostosta luettu data:")
print(head(data_tsv))

# ======== Excel-tiedostot ========

# Tarvitaan readxl-paketti
if (!requireNamespace("readxl", quietly = TRUE)) {
  cat("readxl-paketti ei ole asennettu.\n")
  cat("Asenna se komennolla: install.packages('readxl')\n")
} else {
  library(readxl)
  
  # Jos haluat tallentaa Excel-muotoon, tarvitset writexl-paketin
  if (!requireNamespace("writexl", quietly = TRUE)) {
    cat("writexl-paketti ei ole asennettu.\n")
    cat("Asenna se komennolla: install.packages('writexl')\n")
  } else {
    library(writexl)
    
    # Tallennetaan Excel-tiedostoksi
    write_xlsx(esimerkkidata, "esimerkkidata.xlsx")
    
    # Luetaan Excel-tiedosto
    data_excel <- read_excel("esimerkkidata.xlsx")
    print("Excel-tiedostosta luettu data:")
    print(head(data_excel))
    
    # Luetaan tietty välilehti (tässä vain yksi välilehti)
    data_excel_sheet <- read_excel("esimerkkidata.xlsx", sheet = 1)
    
    # Kokeillaan alueen lukemista
    data_excel_range <- read_excel("esimerkkidata.xlsx", range = "A1:C6")
    print("Excel-tiedostosta rajattu alue:")
    print(head(data_excel_range))
  }
}

# ======== R-datatiedostot ========

# Tallennetaan RDS-tiedostoksi (yhden objektin tallentamiseen)
saveRDS(esimerkkidata, "esimerkkidata.rds")

# Luetaan RDS-tiedosto
data_rds <- readRDS("esimerkkidata.rds")
print("RDS-tiedostosta luettu data:")
print(head(data_rds))

# Tallennetaan RData-tiedostoksi (voi sisältää useita objekteja)
save(esimerkkidata, file = "esimerkkidata.RData")

# Luetaan RData-tiedosto (palauttaa objektit alkuperäisillä nimillä)
load("esimerkkidata.RData")
print("RData-tiedostosta luettu data:")
print(head(esimerkkidata))

# ======== Muut tiedostomuodot ========

# JSON (vaatii jsonlite-paketin)
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  cat("jsonlite-paketti ei ole asennettu.\n")
  cat("Asenna se komennolla: install.packages('jsonlite')\n")
} else {
  library(jsonlite)
  
  # Tallennetaan JSON-muotoon
  write_json(esimerkkidata, "esimerkkidata.json")
  
  # Luetaan JSON-tiedosto
  data_json <- read_json("esimerkkidata.json", simplifyVector = TRUE)
  print("JSON-tiedostosta luettu data:")
  print(head(data_json))
}

# ======== Datan lukeminen verkosta ========

# Esimerkkidata verkosta (Iris-datasetti)
url <- "https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv"

# Tarkistetaan voimmeko lukea datan verkosta
tryCatch({
  data_url <- read.csv(url)
  print("Verkosta luettu data (Iris-datasetti):")
  print(head(data_url))
}, error = function(e) {
  cat("Verkkodatan lukeminen epäonnistui:\n", e$message, "\n")
  cat("Tarkista internet-yhteys tai URL-osoite.\n")
})

# ======== Yhteenveto ========

cat("\n=== Yhteenveto datan lukemisesta ===\n")
cat("Olemme lukeneet dataa seuraavista tiedostomuodoista:\n")
cat("- CSV (.csv)\n")
cat("- Tekstitiedosto (.txt, .tsv)\n")
cat("- Excel-tiedosto (.xlsx) (jos readxl on asennettu)\n")
cat("- R-datatiedostot (.rds, .RData)\n")
cat("- JSON (.json) (jos jsonlite on asennettu)\n")
cat("- Verkkodata\n\n")

cat("Lisää tiedostomuotoja voidaan lukea asentamalla erikoistuneita paketteja, kuten:\n")
cat("- haven: SPSS, SAS, Stata -tiedostot\n")
cat("- xml2: XML-tiedostot\n")
cat("- DBI ja RSQLite: SQLite-tietokannat\n")
cat("- RMySQL, RPostgreSQL: SQL-tietokannat\n")
