# ggplot2 - Perussyntaksi ja rakenne

ggplot2 on Hadley Wickhamin kehittämä visualisointikirjasto, joka perustuu "Grammar of Graphics" -filosofiaan. Sen perusidea on rakentaa kuvaajat kerroksittain.

## Asentaminen ja lataaminen

```r
# Asentaminen (tarvitsee tehdä vain kerran)
install.packages("ggplot2")

# Lataaminen
library(ggplot2)
```

## Perusrakenne

ggplot2-kuvaaja koostuu seuraavista osista:

1. **Data**: Tietoaineisto, jota visualisoidaan
2. **Aesthetics (aes)**: Visuaaliset ominaisuudet, jotka liitetään datan muuttujiin
3. **Geometries (geom)**: Geometriset objektit, jotka esittävät dataa (pisteet, viivat, jne.)
4. **Facets**: Datan jako osajoukoiksi erillisiin kuvaajiin
5. **Statistics**: Tilastolliset muunnokset, jotka voidaan tehdä datalle
6. **Coordinates**: Koordinaattisysteemi
7. **Themes**: Kuvaajan ulkoasu ja tyyli

## Yksinkertaisin ggplot2-kuvaaja

```r
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point()
```

## Kuvaajan rakentaminen vaiheittain

```r
# Määritellään data ja aesthetics
p <- ggplot(data = mtcars, aes(x = wt, y = mpg))

# Lisätään geometria
p + geom_point()

# Lisätään otsikot
p + geom_point() +
  labs(title = "Auto Weight vs. MPG",
       x = "Weight (1000 lbs)",
       y = "Miles per Gallon")

# Lisätään teema
p + geom_point() +
  labs(title = "Auto Weight vs. MPG",
       x = "Weight (1000 lbs)",
       y = "Miles per Gallon") +
  theme_minimal()
```

## Aesthetics (aes)

Aesthetics määrittää, miten datan arvot määräävät visuaalisia ominaisuuksia:

```r
# x ja y ovat perus-aestheticsit
ggplot(mtcars, aes(x = wt, y = mpg))

# color, size, shape, alpha ovat myös yleisiä
ggplot(mtcars, aes(x = wt, y = mpg, 
                  color = factor(cyl),  # väri sylinterien mukaan
                  size = hp,            # koko hevosvoimien mukaan
                  shape = factor(am)))  # muoto vaihteiston mukaan
```

## Geometriat (geom_xxx)

Geometriat määrittävät, miten data esitetään visuaalisesti:

```r
# Pisteet
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()

# Viiva
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_line()

# Useita geometrioita yhdessä
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm")  # Lisää lineaarisen regressiosuoran
```

## Kuvaajan otsikointi ja selitteet

```r
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point() +
  labs(title = "Auton paino vs. polttoaineenkulutus",
       subtitle = "Vertailu sylinterimäärän mukaan",
       x = "Paino (1000 lbs)",
       y = "Miles Per Gallon",
       color = "Sylinterien määrä",
       caption = "Lähde: mtcars dataset")
```

## Teemat

ggplot2 sisältää useita valmiita teemoja:

```r
# Minimalistinen teema
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  theme_minimal()

# Mustavalkoinen teema
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  theme_bw()

# Klassinen teema
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  theme_classic()

# Tumma teema
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  theme_dark()
```

## Kuvaajien yhdistäminen (+)

ggplot2:ssa kuvaajat rakentuvat kerroksittain `+` operaattorilla:

```r
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(aes(color = factor(cyl)), size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = "Auton paino vs. polttoaineenkulutus") +
  theme_minimal() +
  scale_color_brewer(palette = "Set1", name = "Sylinterit")
```

## Kuvaajien tallennus

```r
# Luodaan kuvaaja
p <- ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point() +
  theme_minimal()

# Tallennetaan PNG-tiedostona
ggsave("kuvaaja.png", p, width = 8, height = 6, dpi = 300)

# Tallennetaan PDF-tiedostona
ggsave("kuvaaja.pdf", p, width = 8, height = 6)
```

## Esimerkki

```r
# Monipuolinen ggplot2-esimerkki
ggplot(mtcars, aes(x = wt, y = mpg)) +
  # Lisätään pisteet
  geom_point(aes(color = factor(cyl), size = hp), alpha = 0.7) +
  # Lisätään regressiosuora
  geom_smooth(method = "lm", color = "black", linetype = "dashed") +
  # Otsikot ja selitteet
  labs(title = "Auton painon ja polttoaineenkulutuksen suhde",
       subtitle = "Väri kertoo sylinterien määrän, koko hevosvoimat",
       x = "Paino (1000 lbs)",
       y = "Miles Per Gallon (mpg)",
       color = "Sylinterit",
       size = "Hevosvoimat") +
  # Skaalataan x-akseli
  scale_x_continuous(breaks = seq(1, 6, by = 0.5)) +
  # Väriteema
  scale_color_brewer(palette = "Set1") +
  # Kuvaajan teema
  theme_minimal() +
  # Teeman muokkaukset
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12, color = "gray50"),
    axis.title = element_text(size = 12),
    legend.position = "right"
  )
```

## Vinkkejä

- Käytä `aes()` määritelläksesi estetiikkoja, jotka riippuvat datasta
- Käytä estetiikkoja (esim. `color = "blue"`) geom-funktion ulkopuolella, jos haluat soveltaa sitä koko dataan
- Käytä estetiikkoja geom-funktion sisällä, jos haluat soveltaa sitä vain tiettyyn geometriaan
- Useimpia ggplot2:n osia voidaan muokata theme()-funktiolla

[Takaisin pääsivulle](../visualisointi-cheatsheet.md)
