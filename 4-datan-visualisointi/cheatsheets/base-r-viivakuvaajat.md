# Base R - Viivakuvaajat (Line Plots)

Viivakuvaajat ovat erityisen hyödyllisiä aikasarjojen ja trendien visualisointiin.

## Perusviivakuvaaja

```r
plot(x, y, type = "l")
```

## Mukautettu viivakuvaaja

```r
plot(x, y,
     type = "l",                # "l" = viiva, "p" = pisteet, "b" = molemmat
     main = "Otsikko",
     xlab = "X-akselin nimi",
     ylab = "Y-akselin nimi",
     col = "red",
     lwd = 2,                   # Viivan paksuus
     lty = 1)                   # Viivan tyyppi (1-6)
```

## Viivan tyypit (lty)

```r
# Viivan tyypit (lty-arvot):
# 1: yhtenäinen
# 2: katkoviiva
# 3: pisteviiva
# 4: pistekatkoviiva
# 5: pitkä katkoviiva
# 6: pitkäpistekatkuviiva
```

## Useiden viivojen piirtäminen samaan kuvaajaan

```r
# Piirretään ensimmäinen viiva
plot(x1, y1, type = "l", col = "blue", lwd = 2, ylim = c(min_y, max_y))

# Lisätään toinen viiva samaan kuvaajaan
lines(x2, y2, col = "red", lwd = 2, lty = 2)

# Lisätään kolmas viiva
lines(x3, y3, col = "green", lwd = 2, lty = 3)

# Lisätään selite
legend("topleft", 
       legend = c("Sarja 1", "Sarja 2", "Sarja 3"),
       col = c("blue", "red", "green"),
       lwd = 2,
       lty = c(1, 2, 3))
```

## Viiva ja pisteet

```r
# Viiva ja pisteet erikseen
plot(x, y, type = "l", col = "blue")      # Ensin viiva
points(x, y, pch = 19, col = "red")       # Sitten pisteet

# Viiva ja pisteet yhdellä komennolla
plot(x, y, type = "b")                    # "b" = both (molemmat)
plot(x, y, type = "o")                    # "o" = overplotted (päällekkäin)
```

## Esimerkki

```r
# Luodaan aikasarjadata
vuodet <- 2000:2020
arvot1 <- cumsum(rnorm(length(vuodet), 5, 3))  # Kumulatiivinen summa satunnaisluvuista
arvot2 <- cumsum(rnorm(length(vuodet), 3, 2))

# Piirretään ensimmäinen aikasarja
plot(vuodet, arvot1, 
     type = "l",
     col = "darkblue",
     lwd = 2,
     main = "Kahden aikasarjan vertailu",
     xlab = "Vuosi",
     ylab = "Arvo",
     ylim = c(min(c(arvot1, arvot2)), max(c(arvot1, arvot2))))

# Lisätään toinen aikasarja
lines(vuodet, arvot2, 
      col = "darkred", 
      lwd = 2,
      lty = 2)

# Lisätään pisteet
points(vuodet, arvot1, 
       pch = 19, 
       col = "blue",
       cex = 0.8)
points(vuodet, arvot2, 
       pch = 17, 
       col = "red",
       cex = 0.8)

# Lisätään selite
legend("topleft",
       legend = c("Sarja 1", "Sarja 2"),
       col = c("darkblue", "darkred"),
       lty = c(1, 2),
       pch = c(19, 17),
       lwd = 2)

# Lisätään ruudukko
grid()
```

## Vinkkejä

- Käytä `type = "s"` portaittaisille viivoille (step function)
- Käytä `axis()` -funktiota mukauttaaksesi akseleita tarkemmin
- Kun visualisoit aikasarjoja, käytä `ts` -objekteja ja `plot.ts()` -funktiota
- Käytä `par(new = TRUE)` piirtääksesi kuvaajan toisen kuvaajan päälle (huomioi akselien asteikot)

[Takaisin pääsivulle](../visualisointi-cheatsheet.md)
