# 3. Edistyneet visualisointitekniikat
# Tämä skripti esittelee edistyneempiä visualisointitekniikoita R:llä

# ======== Asennetaan ja ladataan tarvittavat paketit ========

# Asennetaan paketit (tarvitsee tehdä vain kerran)
# install.packages(c("ggplot2", "plotly", "gganimate", "gapminder", 
#                   "scales", "viridis", "hrbrthemes", "ggridges",
#                   "corrplot"))

# Ladataan peruspaketit
library(ggplot2)

# ======== Luodaan esimerkkidataa ========

# Luodaan data lämpökarttaa varten
set.seed(123)
korrelaatio_matriisi <- matrix(
  runif(100, -1, 1), 
  nrow = 10, 
  ncol = 10
)
diag(korrelaatio_matriisi) <- 1  # Diagonaalilla täydelliset korrelaatiot
rownames(korrelaatio_matriisi) <- colnames(korrelaatio_matriisi) <- 
  paste0("Muuttuja_", 1:10)

# Luodaan data rinnakkaiskoordinaatistoa varten
parallel_data <- data.frame(
  ID = 1:30,
  Muuttuja1 = rnorm(30, mean = 0, sd = 1),
  Muuttuja2 = rnorm(30, mean = 5, sd = 2),
  Muuttuja3 = rnorm(30, mean = 10, sd = 1.5),
  Muuttuja4 = rnorm(30, mean = 15, sd = 3),
  Ryhmä = factor(rep(c("A", "B", "C"), each = 10))
)

# Luodaan data tulivuori-kuvaajaa varten
rikosdata <- data.frame(
  vuosi = rep(2010:2020, each = 5),
  kategoria = factor(rep(c("Varkaus", "Pahoinpitely", "Petos", "Huumerikos", "Liikennerikos"),
                      times = 11)),
  määrä = sample(1000:10000, 55)
)

# Luodaan aikasarjadata
aikasarja <- data.frame(
  päivä = seq(as.Date("2020-01-01"), as.Date("2020-12-31"), by = "day"),
  arvo1 = cumsum(rnorm(366, mean = 0, sd = 1)),
  arvo2 = cumsum(rnorm(366, mean = 0, sd = 0.7)),
  arvo3 = cumsum(rnorm(366, mean = 0, sd = 1.5))
)

# ======== 1. Lämpökartta (Heatmap) ========

# Peruslämpökartta ggplot2:lla
# Ensin muunnetaan matriisi pitkään muotoon
korrelaatio_df <- as.data.frame(as.table(korrelaatio_matriisi))
names(korrelaatio_df) <- c("Rivi", "Sarake", "Korrelaatio")

# Luodaan lämpökartta
korr_heatmap <- ggplot(korrelaatio_df, aes(x = Sarake, y = Rivi, fill = Korrelaatio)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Korrelaatiomatriisi lämpökarttana",
       x = "", y = "", fill = "Korrelaatio")

print(korr_heatmap)

# Edistyneempi lämpökartta corrplot-paketilla
if (requireNamespace("corrplot", quietly = TRUE)) {
  library(corrplot)
  
  corrplot(korrelaatio_matriisi, 
           method = "color",
           type = "upper",
           order = "hclust",
           addCoef.col = "black",
           tl.col = "black",
           tl.srt = 45,
           diag = FALSE,
           title = "Korrelogrammi ryvästettynä",
           mar = c(0, 0, 1, 0))
}

# ======== 2. Rinnakkaiskoordinaatisto (Parallel Coordinates) ========

# Rinnakkaiskoordinaatisto GGally-paketilla
if (requireNamespace("GGally", quietly = TRUE)) {
  library(GGally)
  
  # Perusrinnakkaiskoordinaatisto
  ggparcoord(parallel_data, 
             columns = 2:5,     # Valitaan muuttujat
             groupColumn = "Ryhmä",  # Väritys ryhmän mukaan
             scale = "std",     # Standardointi
             title = "Rinnakkaiskoordinaattikuvaaja") +
    theme_minimal() +
    scale_color_brewer(palette = "Set1")
}

# ======== 3. Ympyrädiagrammi (Radar Chart / Spider Plot) ========

# Luodaan data tutkadiagrammia (radar chart) varten
radar_data <- data.frame(
  Kategoria = c("Nopeus", "Teho", "Kestävyys", "Hallinta", "Taito"),
  Pelaaja1 = c(90, 60, 75, 80, 85),
  Pelaaja2 = c(70, 80, 85, 75, 60),
  Pelaaja3 = c(80, 70, 65, 90, 70)
)

# Tutkadiagrammi fmsb-paketilla
if (requireNamespace("fmsb", quietly = TRUE)) {
  library(fmsb)
  
  # Muunnetaan data oikeaan muotoon
  radar_matrix <- as.matrix(radar_data[, -1])  # Poista kategoria-sarake
  rownames(radar_matrix) <- radar_data$Kategoria
  
  # Lisätään max ja min rivit
  radar_plot_data <- rbind(
    rep(100, ncol(radar_matrix)),  # Maksimi
    rep(0, ncol(radar_matrix)),    # Minimi
    radar_matrix
  )
  
  # Piirretään tutkadiagrammi
  par(mar = c(1, 1, 2, 1))
  radarchart(radar_plot_data,
             pcol = c("red", "blue", "green"),
             pfcol = scales::alpha(c("red", "blue", "green"), 0.3),
             plwd = 2,
             cglcol = "grey",
             cglty = 1,
             axislabcol = "black",
             title = "Pelaajien ominaisuudet")
  
  # Lisätään selite
  legend("topright", 
         legend = colnames(radar_plot_data), 
         col = c("red", "blue", "green"),
         lty = 1, 
         lwd = 2, 
         pch = 16,
         bty = "n")
}

# ======== 4. Violin Plot ja Joy Plot ========

# Luodaan violin plot ggplot2:lla
violin_plot <- ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.1, alpha = 0.5) +
  labs(title = "Violin Plot - Iris Dataset",
       x = "Species",
       y = "Sepal Length") +
  theme_minimal()

print(violin_plot)

# Joy Plot (Ridgeline Plot) ggridges-paketilla
if (requireNamespace("ggridges", quietly = TRUE)) {
  library(ggridges)
  
  ridge_plot <- ggplot(iris, aes(x = Sepal.Length, y = Species, fill = Species)) +
    geom_density_ridges(alpha = 0.7) +
    labs(title = "Ridgeline Plot - Iris Dataset",
         x = "Sepal Length",
         y = "") +
    theme_minimal() +
    theme(legend.position = "none")
  
  print(ridge_plot)
}

# ======== 5. Aikasarjakuvaajat ========

# Perusaikasarjakuvaaja
aikasarja_plot <- ggplot(aikasarja, aes(x = päivä)) +
  geom_line(aes(y = arvo1, color = "Sarja 1"), size = 1) +
  geom_line(aes(y = arvo2, color = "Sarja 2"), size = 1) +
  geom_line(aes(y = arvo3, color = "Sarja 3"), size = 1) +
  labs(title = "Aikasarjakuvaaja",
       x = "Päivämäärä",
       y = "Arvo",
       color = "Sarja") +
  scale_color_manual(values = c("red", "blue", "green")) +
  theme_minimal()

print(aikasarja_plot)

# Edistyneempi aikasarjakuvaaja dygraphs-paketilla (interaktiivinen)
if (requireNamespace("dygraphs", quietly = TRUE)) {
  library(dygraphs)
  library(xts)
  
  # Muunnetaan data xts-muotoon
  aikasarja_xts <- xts(aikasarja[, -1], order.by = aikasarja$päivä)
  
  # Luodaan interaktiivinen aikasarjakuvaaja
  dygraph(aikasarja_xts, main = "Interaktiivinen aikasarjakuvaaja") %>%
    dyOptions(colors = c("red", "blue", "green")) %>%
    dyRangeSelector() %>%
    dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>%
    dyLegend(width = 500)
}

# ======== 6. Tulivuori-kuvaaja (Volcano Plot) ========

# Tulivuori-kuvaaja (arvojen jakautuminen vuosien ja kategorioiden yli)
volcano_plot <- ggplot(rikosdata, aes(x = vuosi, y = kategoria)) +
  geom_tile(aes(fill = määrä), color = "white") +
  scale_fill_viridis_c(option = "inferno") +
  labs(title = "Tulivuori-kuvaaja rikostilastoista",
       x = "Vuosi",
       y = "Rikoskategoria",
       fill = "Määrä") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0))

print(volcano_plot)

# ======== 7. Parvikuvaaja (Swarm Plot) ========

# Luodaan data parvikuvaajaa varten
swarm_data <- data.frame(
  ryhmä = factor(rep(LETTERS[1:3], each = 100)),
  arvo = c(rnorm(100, 10, 2), rnorm(100, 14, 3), rnorm(100, 8, 1.5))
)

# Parvikuvaaja ggbeeswarm-paketilla
if (requireNamespace("ggbeeswarm", quietly = TRUE)) {
  library(ggbeeswarm)
  
  swarm_plot <- ggplot(swarm_data, aes(x = ryhmä, y = arvo, color = ryhmä)) +
    geom_beeswarm() +
    labs(title = "Parvikuvaaja (Beeswarm Plot)",
         x = "Ryhmä",
         y = "Arvo") +
    theme_minimal()
  
  print(swarm_plot)
}

# ======== 8. Kulmahistogrammi (Polar Histogram) ========

# Luodaan data kulmahistogrammia varten
kulma_data <- data.frame(
  kulma = runif(1000, 0, 360),  # Satunnaisia kulmia 0-360 astetta
  intensiteetti = abs(rnorm(1000, 5, 2))  # Satunnaisia positiivisia intensiteettejä
)

# Kulmahistogrammi ggplot2:lla
kulma_hist <- ggplot(kulma_data, aes(x = kulma)) +
  geom_histogram(bins = 36, fill = "skyblue", color = "white") +  # 36 binnia = 10 astetta per binni
  coord_polar() +  # Muunnetaan karteesinen koordinaatisto napakoordinaatistoksi
  scale_x_continuous(breaks = seq(0, 360, by = 45), limits = c(0, 360)) +
  labs(title = "Kulmahistogrammi",
       x = "Kulma (astetta)",
       y = "Frekvenssi") +
  theme_minimal()

print(kulma_hist)

# ======== 9. Interaktiiviset kuvaajat plotly:llä ========

if (requireNamespace("plotly", quietly = TRUE)) {
  library(plotly)
  
  # Luodaan ggplot2-kuvaaja
  p <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
    geom_point() +
    labs(title = "Iris Dataset - Sepal Length vs Width")
  
  # Muunnetaan interaktiiviseksi
  p_interactive <- ggplotly(p)
  
  # Tulostetaan interaktiivinen kuvaaja
  print(p_interactive)
  
  # Edistyneempi suoraan plotly:llä
  iris_plotly <- plot_ly(data = iris, 
                        x = ~Sepal.Length, 
                        y = ~Sepal.Width, 
                        z = ~Petal.Length,
                        color = ~Species, 
                        type = "scatter3d",
                        mode = "markers")
  
  iris_plotly <- iris_plotly %>% layout(title = "3D Plot Iris Dataset")
  
  print(iris_plotly)
}

# ======== 10. Animaatiot gganimate-paketilla ========

if (requireNamespace("gganimate", quietly = TRUE)) {
  library(gganimate)
  
  # Luodaan esimerkki-dataset animaatiota varten (simuloidaan Gapminder-dataa)
  if (requireNamespace("gapminder", quietly = TRUE)) {
    library(gapminder)
    data("gapminder")
    
    # Luodaan animoitu kuvaaja
    p <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)) +
      geom_point(alpha = 0.7) +
      scale_size(range = c(2, 12), guide = "none") +
      scale_x_log10() +
      labs(title = 'Vuosi: {frame_time}',
           x = 'BKT per henkilö (log-asteikko)',
           y = 'Elinajanodote',
           color = 'Maanosa') +
      theme_minimal()
    
    # Lisätään animaatio
    p_animated <- p + 
      transition_time(year) +
      ease_aes('linear')
    
    # Tämä toimisi RStudio-ympäristössä, mutta tässä skriptissä se vain valmistaa animaation
    # print(animate(p_animated, fps = 10, duration = 10))
    # anim_save("gapminder_animation.gif", p_animated)
    
    # Staattinen versio vain osoitukseksi siitä, miltä yhden ruudun animaatio näyttäisi
    print(p)
  }
}

# ======== 11. Monitasoinen kuvaaja facet_grid():llä ========

# Luodaan monitasoinen kuvaaja
multi_facet <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(. ~ Species) +
  labs(title = "Irisdatan monitasoinen visualisointi",
       subtitle = "Terälehtien pituus ja leveys lajeittain") +
  theme_minimal()

print(multi_facet)

# ======== 12. Kuvaajien tallentaminen ========

# Tallennetaan valittu kuvaaja
ggsave("heatmap_esimerkki.png", korr_heatmap, width = 10, height = 8, dpi = 300)

# ======== Yhteenveto ========

cat("Tässä esimerkissä opimme useita edistyneitä visualisointitekniikoita:\n")
cat("1. Lämpökartta (Heatmap)\n")
cat("2. Rinnakkaiskoordinaatisto (Parallel Coordinates)\n")
cat("3. Ympyrädiagrammi (Radar Chart / Spider Plot)\n")
cat("4. Violin Plot ja Joy Plot\n")
cat("5. Aikasarjakuvaajat\n")
cat("6. Tulivuori-kuvaaja (Volcano Plot)\n")
cat("7. Parvikuvaaja (Swarm Plot)\n")
cat("8. Kulmahistogrammi (Polar Histogram)\n")
cat("9. Interaktiiviset kuvaajat plotly:llä\n")
cat("10. Animaatiot gganimate-paketilla\n")
cat("11. Monitasoinen kuvaaja facet_grid():llä\n")
cat("12. Kuvaajien tallentaminen\n")
cat("\nNämä edistyneet tekniikat mahdollistavat monimutkaisen datan visualisoinnin\n")
cat("tehokkailla ja informatiivisilla tavoilla. Monet näistä visualisoinneista\n")
cat("vaativat lisäpaketteja, jotka voi asentaa install.packages()-funktiolla.\n")
