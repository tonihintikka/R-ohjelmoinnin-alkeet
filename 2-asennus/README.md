# 2. R-ympäristön asennus

Tässä osiossa käymme läpi, miten asennat R-ohjelmointikielen ja RStudio-kehitysympäristön tietokoneellesi. Asennusprosessi on melko suoraviivainen ja samanlainen eri käyttöjärjestelmillä.

## R:n ja RStudion asentaminen

R-ympäristön asentamiseksi tarvitset kaksi asiaa:

1. **R-ohjelmointikielen** - tämä on perusta, joka suorittaa R-koodin
2. **RStudio-kehitysympäristön** - tämä on käyttäjäystävällinen käyttöliittymä, joka helpottaa R:n käyttöä

### Vaihe 1: R:n asentaminen

R on asennettava ensin, koska RStudio tarvitsee sitä toimiakseen.

#### Windows-käyttäjille

1. Mene CRAN (Comprehensive R Archive Network) -sivustolle: [https://cran.r-project.org/](https://cran.r-project.org/)
2. Valitse "Download R for Windows"
3. Klikkaa "base" -linkkiä
4. Klikkaa "Download R x.x.x for Windows" -linkkiä (missä x.x.x on uusin versio)
5. Kun lataus on valmis, avaa ladattu asennustiedosto
6. Seuraa asennusohjelman ohjeita hyväksyen oletusasetukset
7. Klikkaa "Finish" kun asennus on valmis

#### macOS-käyttäjille

1. Mene CRAN-sivustolle: [https://cran.r-project.org/](https://cran.r-project.org/)
2. Valitse "Download R for macOS"
3. Valitse uusin .pkg-tiedosto, joka sopii Mac-tietokoneesi käyttöjärjestelmäversioon
   - Intel Macille valitse "R-x.x.x.pkg"
   - Apple Silicon (M1/M2) Macille valitse "R-x.x.x-arm64.pkg" jos saatavilla
4. Avaa ladattu .pkg-tiedosto ja seuraa asennusohjelman ohjeita
5. Syötä pääkäyttäjän salasana tarvittaessa
6. Klikkaa "Close" kun asennus on valmis

#### Linux-käyttäjille

Useimmissa Linux-jakeluissa voit asentaa R:n komentoriviltä:

**Ubuntu/Debian:**
```bash
# Lisää R:n repositorio
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

# Päivitä pakettiluettelo ja asenna R
sudo apt update
sudo apt install r-base r-base-dev
```

**Fedora:**
```bash
sudo dnf install R
```

**Arch Linux:**
```bash
sudo pacman -S r
```

### Vaihe 2: RStudion asentaminen

RStudio on integroitu kehitysympäristö (IDE), joka tekee R-ohjelmoinnista paljon helpompaa.

#### Kaikille käyttöjärjestelmille

1. Mene RStudion lataussivulle: [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/)
2. Selaa sivua alaspäin kohtaan "All Installers"
3. Valitse käyttöjärjestelmääsi sopiva asennustiedosto
4. Lataa asennustiedosto ja avaa se
5. Seuraa asennusohjelman ohjeita
6. Käynnistä RStudio asennuksen jälkeen

## RStudion käyttöliittymän esittely

Kun avaat RStudion ensimmäistä kertaa, näet käyttöliittymän, joka on jaettu yleensä neljään paneeliin:

![RStudio käyttöliittymä](https://rstudio.github.io/cheatsheets/html/images/rstudio.png)

### 1. Lähdekoodi-editori (Source Editor) - Vasen yläkulma

Tässä paneelissa kirjoitat ja muokkaat R-skriptejä. Täällä voit:
- Luoda uusia R-skriptitiedostoja (.R-päätteisiä)
- Muokata olemassa olevia tiedostoja
- Suorittaa koodia valitsemalla osan koodista ja painamalla Ctrl+Enter (Windows/Linux) tai Cmd+Enter (macOS)

### 2. Konsoli (Console) - Vasen alakulma

Konsoli on paikka, jossa:
- R suorittaa komennot ja näyttää tulokset
- Voit kirjoittaa ja suorittaa komentoja suoraan (interaktiivinen tila)
- Näet virheilmoitukset ja varoitukset

### 3. Ympäristö/Historia (Environment/History) - Oikea yläkulma

Tässä paneelissa:
- **Environment**-välilehti näyttää kaikki nykyisessä työtilassa olevat objektit (muuttujat, funktiot, jne.)
- **History**-välilehti näyttää aiemmin suoritetut komennot
- **Connections**-välilehti hallitsee tietokantayhteyksiä
- **Tutorial**-välilehti tarjoaa interaktiivisia opetusohjelmia

### 4. Tiedostot/Paketit/Ohjeet/Kuvaajat (Files/Packages/Help/Plots) - Oikea alakulma

Tässä paneelissa on useita hyödyllisiä välilehtiä:
- **Files**: Näyttää tiedostot nykyisessä työhakemistossa
- **Plots**: Näyttää luodut kuvaajat
- **Packages**: Hallitsee asennettuja R-paketteja
- **Help**: Näyttää ohjedokumentaation
- **Viewer**: Näyttää HTML-sisältöä, kuten Shiny-sovellukset tai R Markdown -dokumentit

## RStudion perustoiminnot

Tässä on muutamia perustoimintoja, joita käytät usein RStudiossa:

### R-skriptin luominen ja tallentaminen

1. Luo uusi R-skripti valitsemalla **File → New File → R Script** tai painamalla **Ctrl+Shift+N** (Windows/Linux) tai **Cmd+Shift+N** (macOS)
2. Kirjoita R-koodi editori-ikkunaan
3. Tallenna skripti valitsemalla **File → Save** tai painamalla **Ctrl+S** (Windows/Linux) tai **Cmd+S** (macOS)
4. Anna tiedostolle nimi (yleensä .R-päätteinen)

### Koodin suorittaminen

R-koodia voi suorittaa usealla tavalla:

1. **Suorita valittu koodi**: Valitse koodia ja paina **Ctrl+Enter** (Windows/Linux) tai **Cmd+Enter** (macOS)
2. **Suorita koko skripti**: Paina **Ctrl+Shift+Enter** (Windows/Linux) tai **Cmd+Shift+Enter** (macOS)
3. **Suorita nykyinen rivi**: Aseta kursori riville ja paina **Ctrl+Enter** (Windows/Linux) tai **Cmd+Enter** (macOS)

### Pakettien asentaminen ja lataaminen

R:n toiminnallisuutta laajennetaan pakettien avulla:

1. **Asenna paketti** valitsemalla **Tools → Install Packages** tai suorittamalla komento `install.packages("paketin_nimi")` konsolissa
2. **Lataa paketti** käyttöön suorittamalla komento `library(paketin_nimi)` 

### Työhakemiston asettaminen

Työhakemisto on kansio, josta R lukee tiedostoja ja johon se tallentaa tulokset:

1. Tarkista nykyinen työhakemisto komennolla `getwd()`
2. Aseta uusi työhakemisto valitsemalla **Session → Set Working Directory → Choose Directory** tai komennolla `setwd("polku/hakemistoon")`

### Datan tuonti

RStudiossa on useita tapoja tuoda dataa:

1. Käytä **Environment**-paneelin **Import Dataset** -painiketta
2. Käytä R-funktioita kuten `read.csv()`, `read.table()` tai `readxl::read_excel()`

### Ohje ja dokumentaatio

Apua saa monella tavalla:

1. Käytä `?funktion_nimi` saadaksesi ohjeita tietystä funktiosta
2. Käytä **Help**-paneelia selataksesi dokumentaatiota
3. Avaa pakettien verkkosivut **Help**-valikosta
4. Käytä `help.search("hakusana")` tai `??hakusana` etsiäksesi ohjeita tietystä aiheesta

## RStudion mukauttaminen

RStudioa voi mukauttaa monella tavalla:

1. Avaa asetukset valitsemalla **Tools → Global Options**
2. Muuta **Appearance**-kohdasta teemaa ja fontteja
3. Säädä **Code**-kohdasta koodieditorin toimintaa
4. Muuta **Pane Layout** -kohdasta paneelien järjestystä

## Seuraavat askeleet

Nyt kun olet asentanut R:n ja RStudion ja tutustunut käyttöliittymään, olet valmis aloittamaan R-ohjelmoinnin opiskelun! Seuraavassa osiossa perehdymme R-kielen perusteisiin, kuten muuttujiin, datatyyppeihin ja perustoimintoihin.

## Vinkkejä ja yleisiä ongelmia

### Vinkkejä aloittelijoille

- Pidä RStudion ohjepaneeli auki, kun opettelet uusia funktioita
- Käytä koodissa kommentteja (alkavat #-merkillä) muistiinpanoina itsellesi
- Tallenna skriptisi säännöllisesti
- Harjoittele pienillä projekteilla

### Yleisiä ongelmia ja ratkaisuja

1. **"Package not found"** -virhe:
   - Varmista, että kirjoitit paketin nimen oikein
   - Kokeile asentaa paketti uudelleen: `install.packages("paketin_nimi")`

2. **Työhakemiston ongelmat**:
   - Tarkista nykyinen työhakemisto: `getwd()`
   - Käytä absoluuttisia polkuja tai `setwd()` -komentoa

3. **R-versioiden yhteensopivuusongelmat**:
   - Tarkista R-versio komennolla `R.version`
   - Päivitä R tarvittaessa uusimpaan versioon

4. **RStudio ei käynnisty**:
   - Varmista, että R on asennettu ennen RStudiota
   - Poista RStudio ja asenna se uudelleen

5. **Paketit eivät toimi yhdessä**:
   - Päivitä paketit komennolla `update.packages()`
   - Tarkista, onko pakettien välillä tunnettuja yhteensopivuusongelmia

## Yhteenveto

Tässä osiossa opit:
- Asentamaan R:n ja RStudion eri käyttöjärjestelmille
- Navigoimaan RStudion käyttöliittymässä
- Käyttämään RStudion perustoimintoja
- Mukauttamaan RStudioa tarpeisiisi

Seuraavassa osiossa siirrymme R-kielen perusteiden oppimiseen, kuten muuttujiin, tietotyyppeihin ja perustoimintoihin.
