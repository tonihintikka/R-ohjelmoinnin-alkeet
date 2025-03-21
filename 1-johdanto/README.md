# 1. Johdanto R-ohjelmointiin

## Mikä R on?

R on ohjelmointikieli ja ohjelmistoympäristö, joka on suunniteltu erityisesti tilastolliseen laskentaan ja datan visualisointiin. R on vapaasti saatavilla oleva avoimen lähdekoodin ohjelmisto, joka toimii useilla käyttöjärjestelmillä (Windows, macOS ja Linux).

R-kielen kehittivät alun perin tilastotieteilijät Ross Ihaka ja Robert Gentleman Aucklandin yliopistossa Uudessa-Seelannissa 1990-luvun alussa. Nykyään R:n kehityksestä vastaa R Core Team -ryhmä, ja kieli on laajentunut valtavasti käyttäjäyhteisön kehittämien pakettien ansiosta.

## Miksi oppia R-ohjelmointia?

R-ohjelmoinnin oppimiselle on useita hyviä syitä:

1. **Suosittu data-analyysin työkalu**: R on yksi suosituimmista datan analysointiin käytetyistä työkaluista tutkijoiden, tilastotieteilijöiden ja data-analyytikkojen keskuudessa.

2. **Laaja pakettivalikoima**: R:lle on saatavilla yli 18 000 pakettia (vuoden 2023 tietojen mukaan), jotka laajentavat sen toiminnallisuutta. CRAN (Comprehensive R Archive Network) on pääasiallinen R-pakettien varasto.

3. **Vahva visualisointikyvykkyys**: R tarjoaa erinomaisia työkaluja datan visualisointiin, erityisesti ggplot2-paketin avulla.

4. **Tilastolliset analyysit**: R on suunniteltu tilastolliseen analyysiin ja tarjoaa laajan valikoiman tilastollisia malleja ja testejä.

5. **Helppo datan käsittely**: Modernit R-paketit kuten dplyr ja tidyr tekevät datan käsittelystä ja muokkauksesta intuitiivista.

6. **Toistettava tutkimus**: R Markdown -työkalulla voit yhdistää koodia, visualisointeja ja tekstiä luodaksesi toistettavia raportteja ja analyysejä.

7. **Aktiivinen yhteisö**: R:llä on aktiivinen yhteisö, joka tuottaa jatkuvasti uusia paketteja, opetusmateriaalia ja tukea.

8. **Ilmainen ja avoin**: R on ilmainen käyttää, ja sen koodi on avoimesti saatavilla.

## R:n käyttökohteet

R:ää käytetään monilla eri aloilla, muun muassa:

- **Tilastotiede ja data-analyysi**: Tilastolliset testit, regressioanalyysit, aikasarja-analyysit
- **Koneoppiminen**: Luokittelu, klusterointi, neuroverkot
- **Bioinformatiikka**: Genomiikka, proteomiikka, sekvenssianalyysit
- **Lääketiede ja terveydenhuolto**: Kliiniset tutkimukset, epidemiologia
- **Taloustiede ja rahoitus**: Aikasarja-analyysit, riskianalyysit, markkinatutkimus
- **Yhteiskuntatieteet**: Mielipidemittaukset, demografiset tutkimukset
- **Ekologia ja ympäristötiede**: Populaatiomallinnus, ilmastodata-analyysit
- **Teollisuus ja liiketoiminta**: Laadunvalvonta, markkinatutkimus, asiakasanalytiikka

## R vs. muut ohjelmointikielet ja -työkalut

Verrattuna muihin datatyökaluihin, R:llä on omat vahvuutensa ja heikkoutensa:

### R vs. Python
- **R** on suunniteltu erityisesti tilastolliseen laskentaan ja data-analyysiin.
- **Python** on yleiskäyttöisempi ohjelmointikieli, jolla on vahva ekosysteemi data-analyysiä varten.
- R:n vahvuus on sen tilastollisten menetelmien ja visualisointien laajuudessa.
- Python on monipuolisempi ja integroituu helpommin muihin järjestelmiin.

### R vs. Excel
- **R** mahdollistaa toistettavan analyysin ja skaalautuu suuriin datasetteihin.
- **Excel** on intuitiivisempi käyttää yksinkertaisiin analyyseihin ilman koodausta.
- R on parempi monimutkaisten analyysien ja automatisoitujen työnkulkujen käsittelyssä.
- Excel on hyvä nopeaan datan tarkasteluun ja yksinkertaiseen visualisointiin.

### R vs. SPSS/SAS/Stata
- **R** on ilmainen ja avoin lähdekoodi, kun taas **SPSS/SAS/Stata** ovat kaupallisia ohjelmistoja.
- R:n käyttö vaatii enemmän ohjelmointiosaamista kuin valikkopohjainen SPSS.
- R:llä on joustavampi visualisointikyvykkyys kuin perinteisillä tilasto-ohjelmistoilla.
- SAS/SPSS saattavat olla parempia erittäin suurten datamäärien käsittelyssä.

## R-ekosysteemi

R-ekosysteemi koostuu useista komponenteista:

1. **R Base**: R:n perusversio, joka sisältää perustoiminnallisuuden data-analyysiin ja visualisointiin.

2. **RStudio**: Suosittu integroitu kehitysympäristö (IDE) R-koodin kirjoittamiseen. RStudio tarjoaa käyttäjäystävällisen käyttöliittymän, jossa on koodieditori, konsoli, grafiikka-alue ja ympäristönhallinta.

3. **Paketit**: R:n laajennukset, jotka lisäävät uusia toiminnallisuuksia. Yleisimmin käytettyjä paketteja ovat:
   - **tidyverse**: Kokoelma paketteja datan käsittelyyn ja visualisointiin (dplyr, ggplot2, tidyr, ym.)
   - **data.table**: Tehokas paketti suurten datasettien käsittelyyn
   - **shiny**: Interaktiivisten verkkosovelluksien luomiseen
   - **rmarkdown**: Dokumenttien, raporttien ja esitysten luomiseen
   - **caret**: Koneoppimiseen

4. **CRAN (Comprehensive R Archive Network)**: Virallinen R-pakettien varasto, josta paketteja voi asentaa.

5. **Bioconductor**: Erikoistunut varasto bioinformatiikkaan liittyville R-paketeille.

6. **GitHub**: Monet R-paketit ja -projektit kehitetään ja jaetaan GitHubin kautta.

## R:n merkitys datatieteen kentällä

R on ollut merkittävä työkalu datatieteen kehityksessä:

- Se on auttanut **demokratisoimaan data-analyysiä** tekemällä kehittyneistä tilastollisista menetelmistä saatavilla kaikille.
- R on edistänyt **avointa tiedettä ja toistettavaa tutkimusta** mahdollistamalla koodin ja analyysin jakamisen.
- Monet uudet **tilastolliset menetelmät** julkaistaan ensin R-paketteina.
- R **yhteisö** on luonut kulttuuria, jossa korostetaan datan visualisoinnin laatua ja selkeyttä.

## Seuraavat askeleet

R:n käytön aloittamiseksi sinun tarvitsee:

1. **Asentaa R**: Lataa ja asenna R CRAN-sivustolta
2. **Asentaa RStudio**: Lataa ja asenna RStudio IDE
3. **Oppia R:n perusteet**: Muuttujat, tietotyypit, funktiot, ja niin edelleen
4. **Tutustua datan tuontiin ja käsittelyyn**: Miten tuoda data R:ään ja käsitellä sitä
5. **Oppia visualisointia**: Miten luoda kuvaajia datasta
6. **Syventyä tilastollisiin analyyseihin**: Hyödyntää R:n tilastollisia ominaisuuksia

Seuraavissa osioissa käsittelemme näitä aiheita yksityiskohtaisemmin ja rakennamme perustaa R-osaamisellesi.

## Yhteenveto

R on tehokas työkalu datan käsittelyyn, analysointiin ja visualisointiin. Sen vahvuuksia ovat laaja pakettivalikoima, erinomaiset visualisointimahdollisuudet ja vahva yhteisötuki. R:n oppiminen avaa ovia monenlaisiin data-analyysin työtehtäviin eri aloilla.

Vaikka R:n oppiminen voi alussa tuntua haastavalta erityisesti ilman aiempaa ohjelmointikokemusta, johdonmukainen harjoittelu ja käytännön projektit auttavat kehittämään taitojasi. Tämä materiaalipaketti on suunniteltu tekemään oppimisprosessista mahdollisimman selkeä ja käytännönläheinen.
