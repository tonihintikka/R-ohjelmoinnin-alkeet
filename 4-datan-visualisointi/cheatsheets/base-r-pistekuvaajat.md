# Base R - Pistekuvaajat (Scatter Plots)

Pistekuvaajat ovat hyödyllisiä, kun haluat visualisoida kahden jatkuvan muuttujan välistä suhdetta.

## Peruspistekaavio

```r
plot(x, y)
```

## Mukautettu pistekaavio

```r
plot(x, y,
     main = "Otsikko",          # Kuvaajan otsikko
     xlab = "X-akselin nimi",   # X-akselin nimi
     ylab = "Y-akselin nimi",   # Y-akselin nimi
     col = "blue",              # Pisteiden väri
     pch = 19,                  # Pisteen tyyppi (0-25)
     cex = 1.5,                 # Pisteiden koko
     xlim = c(0, 10),           # X-akselin rajat
     ylim = c(0, 20))           # Y-akselin rajat
```

## Pistekaavio ryhmittäin

```r
# Oletetaan että factor_values on faktori tai vektori
plot(x, y, 
     col = factor_values,       # Väri faktorin mukaan
     pch = factor_values)       # Symboli faktorin mukaan

# Lisätään selite
legend("topleft",               # Sijainti: "topleft", "topright", "bottomleft", "bottomright"
       legend = levels(factor_values),
       col = 1:length(levels(factor_values)),
       pch = 1:length(levels(factor_values)))
```

## Yleisimmät pistesymbolit (pch)

```r
# Yleisimmät pistesymbolit (pch-arvot):
# 0: □ (neliö)
# 1: ○ (ympyrä)
# 2: △ (kolmio)
# 3: + (plus)
# 4: × (risti)
# 5: ◇ (vinoneliö)
# 15: ■ (täytetty neliö)
# 16: ● (täytetty ympyrä)
# 17: ▲ (täytetty kolmio)
# 18: ▼ (täytetty kolmio alaspäin)
# 19: ⬤ (täytetty ympyrä)
```

## Esimerkki

```r
# Luodaan satunnaisdataa
set.seed(123)
x <- 1:50
y <- 30 + 2*x + rnorm(50, 0, 15)
ryhmä <- factor(rep(c("A", "B"), each = 25))

# Piirretään pistekaavio ryhmillä
plot(x, y,
     col = as.numeric(ryhmä),
     pch = as.numeric(ryhmä) + 15,  # Käytetään eri symboleita ryhmille
     main = "Esimerkki pistekaaviosta ryhmittäin",
     xlab = "X-muuttuja",
     ylab = "Y-muuttuja",
     cex = 1.2)

# Lisätään selite
legend("topleft",
       legend = levels(ryhmä),
       col = 1:2,
       pch = 16:17,
       title = "Ryhmä")

# Lisätään ruudukko
grid()
```

## Lisätoimintoja

```r
# Lisätään tekstiä kuvaajaan
text(x, y + 5, labels = paste("Piste", 1:length(x)), cex = 0.7)

# Lisätään regressiosuora
abline(lm(y ~ x), col = "red", lwd = 2)

# Lisätään pysty- ja vaakaviivat
abline(h = mean(y), col = "blue", lty = 2)  # Vaakaviiva keskiarvon kohdalle
abline(v = mean(x), col = "green", lty = 3) # Pystyviiva x:n keskiarvon kohdalle
```

## Vinkkejä

- Käytä `cex.axis`, `cex.lab`, `cex.main` ja `cex.sub` parametreja muuttaaksesi tekstin kokoa akseleilla, otsikoissa jne.
- `par()`-funktiolla voit säätää kuvaajan marginaaleja ja muita parametreja: `par(mar = c(5, 4, 4, 2) + 0.1)`
- Koordinaattiruudukon saat näkyviin `grid()`-funktiolla

[Takaisin pääsivulle](../visualisointi-cheatsheet.md)
