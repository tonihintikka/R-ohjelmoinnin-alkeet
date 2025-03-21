# 4. Kattava visualisointiesimerkki
# Tämä skripti esittelee kokonaisen data-analyysi- ja visualisointiprosessin

# ======== Asennetaan ja ladataan tarvittavat paketit ========

# Asennetaan paketit (tarvitsee tehdä vain kerran)
# install.packages(c("ggplot2", "dplyr", "tidyr", "lubridate", "scales"))

# Ladataan peruspaketit
library(ggplot2)   # Visualisoinnit
if (requireNamespace("dplyr", quietly = TRUE)) library(dplyr)  # Datan käsittely
if (requireNamespace("tidyr", quietly = TRUE)) library(tidyr)  # Datan muuntaminen
if (requireNamespace("lubridate", quietly = TRUE)) library(lubridate)  # Päivämäärien käsittely

# ======== Ladataan ja tarkastellaan dataa ========

# Käytetään R:n sisäänrakennettua mtcars-datasetiä, joka sisältää tietoa automalleista
data(mtcars)

# Tarkastellaan datan rakennetta
str(mtcars)

# Yhteenveto datasta
summary(mtcars)

# Tarkastellaan ensimmäisiä rivejä
head(mtcars)

# ======== Datan esikäsittely ========

# Lisätään automalli (rownames) omaksi sarakkeeksi
mtcars_df <- mtcars
mtcars_df$car_name <- rownames(mtcars)

# Muunnetaan kategorisia muuttujia faktoreiksi
mtcars_df$cyl <- as.factor(mtcars_df$cyl)
mtcars_df$vs <- as.factor(mtcars_df$vs)
mtcars_df$am <- as.factor(mtcars_df$am)
mtcars_df$gear <- as.factor(mtcars_df$gear)
mtcars_df$carb <- as.factor(mtcars_df$carb)

# Nimetään am-sarakkeen tasot selvemmin
levels(mtcars_df$am) <- c("Automaatti", "Manuaali")

# Nimetään vs-sarakkeen tasot selvemmin
levels(mtcars_df$vs) <- c("V-moottori", "Suora moottori")

# ======== 1. Peruskuvaajat ========

# Histogrammi: Polttoaineenkulutusjakauma (mpg)
hist_mpg <- ggplot(mtcars_df, aes(x = mpg)) +
  geom_histogram(bins = 10, fill = "skyblue", color = "black") +
  labs(title = "Polttoaineenkulutusjakauma",
       subtitle = "Histogram of Miles Per Gallon (mpg)",
       x = "Miles Per Gallon (mpg)",
       y = "Frekvenssi") +
  theme_minimal()

print(hist_mpg)

# Pistekaavio: Polttoaineenkulutus vs. Auton paino
scatter_mpg_wt <- ggplot(mtcars_df, aes(x = wt, y = mpg)) +
  geom_point(aes(color = cyl, size = hp), alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "black", linetype = "dashed") +
  labs(title = "Polttoaineenkulutus vs. Auton paino",
       subtitle = "Väri kertoo sylinterien määrän, koko hevosvoimat",
       x = "Paino (1000 lbs)",
       y = "Miles Per Gallon (mpg)",
       color = "Sylinterit",
       size = "Hevosvoimat") +
  theme_minimal()

print(scatter_mpg_wt)

# Laatikkokaavio: Polttoaineenkulutus vaihteiston tyypin mukaan
box_mpg_am <- ggplot(mtcars_df, aes(x = am, y = mpg, fill = am)) +
  geom_boxplot() +
  labs(title = "Polttoaineenkulutus vaihteiston tyypin mukaan",
       x = "Vaihteiston tyyppi",
       y = "Miles Per Gallon (mpg)",
       fill = "Vaihteisto") +
  theme_minimal()

print(box_mpg_am)

# ======== 2. Edistyneemmät visualisoinnit ========

# Viulukuvaaja: Polttoaineenkulutus sylinterien määrän mukaan
violin_mpg_cyl <- ggplot(mtcars_df, aes(x = cyl, y = mpg, fill = cyl)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.1, alpha = 0.5) +
  labs(title = "Polttoaineenkulutus sylinterien määrän mukaan",
       x = "Sylinterien määrä",
       y = "Miles Per Gallon (mpg)",
       fill = "Sylinterit") +
  theme_minimal()

print(violin_mpg_cyl)

# Pistekaavio jaettuna vaihteiston ja moottorin tyypin mukaan
facet_plot <- ggplot(mtcars_df, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_grid(vs ~ am) +
  labs(title = "Polttoaineenkulutus vs. Paino",
       subtitle = "Jaoteltuna moottorin ja vaihteiston tyypin mukaan",
       x = "Paino (1000 lbs)",
       y = "Miles Per Gallon (mpg)",
       color = "Sylinterit") +
  theme_minimal()

print(facet_plot)

# ======== 3. Visualisointien ryhmittely ========

# Pylväsdiagrammi: Automallien määrä vaihteiston ja sylinterimäärän mukaan
bar_count <- ggplot(mtcars_df, aes(x = am, fill = cyl)) +
  geom_bar(position = "dodge") +
  labs(title = "Automallien määrä vaihteiston ja sylinterimäärän mukaan",
       x = "Vaihteiston tyyppi",
       y = "Automallien määrä",
       fill = "Sylinterit") +
  theme_minimal()

print(bar_count)

# ======== 4. Tehokkuuden visualisointi ========

# Luodaan uusi muuttuja: teho-paino-suhde
mtcars_df$power_weight_ratio <- mtcars_df$hp / mtcars_df$wt

# Järjestetään teho-paino-suhteen mukaan
mtcars_sorted <- mtcars_df[order(-mtcars_df$power_weight_ratio), ]

# Top 10 autoa teho-paino-suhteen mukaan
top10 <- head(mtcars_sorted, 10)

# Pylväsdiagrammi: Top 10 autoa teho-paino-suhteen mukaan
bar_power_weight <- ggplot(top10, aes(x = reorder(car_name, power_weight_ratio), 
                                     y = power_weight_ratio,
                                     fill = am)) +
  geom_col() +
  coord_flip() +  # Käännetään koordinaatisto
  labs(title = "Top 10 autoa teho-paino-suhteen mukaan",
       x = "",
       y = "Teho-paino-suhde (hp/wt)",
       fill = "Vaihteisto") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10))

print(bar_power_weight)

# ======== 5. Korrelaatiot ja suhteet ========

# Lasketaan korrelaatiomatriisi numeerisille muuttujille
cor_matrix <- cor(mtcars[, c("mpg", "disp", "hp", "drat", "wt", "qsec")])
print(round(cor_matrix, 2))

# Visualisoidaan korrelaatiomatriisi lämpökarttana
if (requireNamespace("reshape2", quietly = TRUE)) {
  library(reshape2)
  
  # Muunnetaan korrelaatiomatriisi pitkään muotoon
  cor_melted <- melt(cor_matrix)
  names(cor_melted) <- c("Var1", "Var2", "value")
  
  # Luodaan lämpökartta
  cor_heatmap <- ggplot(cor_melted, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
    labs(title = "Korrelaatiomatriisi",
         x = "",
         y = "",
         fill = "Korrelaatio") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  print(cor_heatmap)
}

# Edistyneempi lämpökartta corrplot-paketilla
if (requireNamespace("corrplot", quietly = TRUE)) {
  library(corrplot)
  
  corrplot(cor_matrix, 
           method = "color",
           type = "upper",
           order = "hclust",
           addCoef.col = "black",
           tl.col = "black",
           tl.srt = 45,
           diag = FALSE,
           title = "Korrelaatiomatriisi ryvästettynä",
           mar = c(0, 0, 1, 0))
}

# ======== 6. Moniulotteinen visualisointi ========

# Luodaan kuvaaja, joka yhdistää useita muuttujia
multi_var_plot <- ggplot(mtcars_df, aes(x = wt, y = mpg, color = hp, size = disp, shape = am)) +
  geom_point(alpha = 0.7) +
  scale_color_gradient(low = "blue", high = "red") +
  labs(title = "Moniulotteinen visualisointi",
       subtitle = "Paino, kulutus, teho, moottorin tilavuus ja vaihteisto",
       x = "Paino (1000 lbs)",
       y = "Miles Per Gallon (mpg)",
       color = "Hevosvoimat",
       size = "Moottorin tilavuus",
       shape = "Vaihteisto") +
  theme_minimal()

print(multi_var_plot)

# ======== 7. Interaktiivinen visualisointi (plotly) ========

if (requireNamespace("plotly", quietly = TRUE)) {
  library(plotly)
  
  # Muunnetaan ggplot-kuvaaja interaktiiviseksi
  interactive_plot <- ggplotly(multi_var_plot)
  
  # Tässä skriptissä voimme vain ilmoittaa, että tämä toimisi interaktiivisesti
  cat("Plotly-kuvaaja olisi interaktiivinen RStudio-ympäristössä. Kokeile!\n")
}

# ======== 8. Parikaavio (Pairs Plot) ========

# Luodaan parikaavio tärkeimmistä muuttujista
pairs(mtcars[, c("mpg", "disp", "hp", "wt")])

# Edistyneempi parikaavio GGally-paketilla
if (requireNamespace("GGally", quietly = TRUE)) {
  library(GGally)
  
  # Luodaan parikaavio ggpairs-funktiolla
  ggpairs_plot <- ggpairs(mtcars_df, 
                          columns = c("mpg", "disp", "hp", "wt"),
                          mapping = ggplot2::aes(color = am),
                          upper = list(continuous = wrap("cor", size = 3)),
                          title = "Parikaavio autoilumuuttujista") +
    theme_minimal()
  
  print(ggpairs_plot)
}

# ======== 9. Ryhmiteltyä data-analyysiä ========

# Keskiarvot ryhmittäin
if (requireNamespace("dplyr", quietly = TRUE)) {
  # Ryhmittele sylinterien ja vaihteistotyypin mukaan
  group_stats <- mtcars_df %>%
    group_by(cyl, am) %>%
    summarise(
      keskimäär_mpg = mean(mpg),
      keskimäär_hp = mean(hp),
      keskimäär_wt = mean(wt),
      keskimäär_qsec = mean(qsec),
      n = n()
    )
  
  print(group_stats)
  
  # Visualisoidaan ryhmien keskiarvoja
  group_bar <- ggplot(group_stats, aes(x = interaction(cyl, am), y = keskimäär_mpg, fill = am)) +
    geom_col() +
    labs(title = "Keskimääräinen polttoaineenkulutus ryhmittäin",
         subtitle = "Ryhmiteltynä sylinterien määrän ja vaihteiston tyypin mukaan",
         x = "Sylinterit ja vaihteisto",
         y = "Keskimääräinen MPG",
         fill = "Vaihteisto") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  print(group_bar)
}

# ======== 10. Cleveland Dot Plot (Pistekuvaajavariaatio) ========

# Luodaan Cleveland Dot Plot vertailemaan hevosvoimia automallien välillä
# Valitaan top 15 automallia hevosvoimien mukaan
top15_hp <- head(mtcars_df[order(-mtcars_df$hp), ], 15)

# Luodaan Cleveland Dot Plot
cleveland_plot <- ggplot(top15_hp, aes(x = hp, y = reorder(car_name, hp))) +
  geom_point(aes(color = am), size = 3) +
  labs(title = "Top 15 autoa hevosvoimien mukaan",
       x = "Hevosvoimat (hp)",
       y = "",
       color = "Vaihteisto") +
  theme_minimal() +
  theme(plot.title = element_text(size = 14, face = "bold"),
        axis.text.y = element_text(size = 10))

print(cleveland_plot)

# ======== 11. Sädekaavio (Radar Chart) ========

# Luodaan sädekaavio muutamille automalleille
if (requireNamespace("fmsb", quietly = TRUE)) {
  library(fmsb)
  
  # Valitaan muutamia automalleja
  car_selection <- c("Ferrari Dino", "Mazda RX4", "Toyota Corolla", "Cadillac Fleetwood")
  radar_data <- mtcars_df[mtcars_df$car_name %in% car_selection, ]
  
  # Valitaan visualisoitavat muuttujat
  vars <- c("mpg", "hp", "wt", "qsec")
  radar_matrix <- as.matrix(radar_data[, vars])
  
  # Skaalataan arvot 0-1 välille
  radar_matrix_scaled <- apply(radar_matrix, 2, function(x) (x - min(x)) / (max(x) - min(x)))
  rownames(radar_matrix_scaled) <- radar_data$car_name
  
  # Lisätään max ja min rivit
  radar_plot_data <- rbind(rep(1, ncol(radar_matrix_scaled)),  # Maksimi
                          rep(0, ncol(radar_matrix_scaled)),   # Minimi
                          radar_matrix_scaled)
  
  # Piirretään sädekaavio
  par(mar = c(1, 1, 3, 1))
  radarchart(radar_plot_data,
             pcol = rainbow(nrow(radar_matrix_scaled)),
             pfcol = scales::alpha(rainbow(nrow(radar_matrix_scaled)), 0.3),
             plwd = 2,
             cglcol = "grey",
             cglty = 1,
             axislabcol = "black",
             title = "Automallien ominaisuusvertailu")
  
  # Lisätään selite
  legend("topright", 
         legend = rownames(radar_matrix_scaled), 
         col = rainbow(nrow(radar_matrix_scaled)),
         lty = 1, 
         lwd = 2, 
         pch = 16,
         bty = "n")
}

# ======== 12. Kuvaajien tallentaminen ======== 

# Tallennetaan kuvia eri formaateissa
ggsave("mpg_vs_weight.png", scatter_mpg_wt, width = 8, height = 6, dpi = 300)
ggsave("top10_power_weight.pdf", bar_power_weight, width = 8, height = 6)

# Voidaan myös tallentaa useita kuvia yhteen PDF-tiedostoon
pdf("mtcars_visualisoinnit.pdf", width = 10, height = 8)
print(hist_mpg)
print(scatter_mpg_wt)
print(box_mpg_am)
print(violin_mpg_cyl)
print(facet_plot)
print(bar_count)
print(bar_power_weight)
print(multi_var_plot)
print(cleveland_plot)
dev.off()

# ======== 13. Yhteenveto datasta tekstimuodossa ========

# Luodaan yhteenvetoteksti
cat("\n=============== YHTEENVETO MTCARS-DATASTA ===============\n\n")

cat("Datan koko: ", nrow(mtcars_df), " riviä, ", ncol(mtcars_df), " saraketta\n\n")

cat("Polttoaineenkulutuksen (MPG) tunnusluvut:\n")
cat("  Minimi: ", min(mtcars_df$mpg), "\n")
cat("  Maksimi: ", max(mtcars_df$mpg), "\n")
cat("  Keskiarvo: ", mean(mtcars_df$mpg), "\n")
cat("  Mediaani: ", median(mtcars_df$mpg), "\n\n")

cat("Sylinterien jakautuminen:\n")
cyl_count <- table(mtcars_df$cyl)
for (i in 1:length(cyl_count)) {
  cat("  ", names(cyl_count)[i], " sylinteriä: ", cyl_count[i], " autoa\n")
}
cat("\n")

cat("Vaihteistotyyppien jakautuminen:\n")
am_count <- table(mtcars_df$am)
for (i in 1:length(am_count)) {
  cat("  ", names(am_count)[i], ": ", am_count[i], " autoa\n")
}
cat("\n")

cat("Merkittävät korrelaatiot:\n")
# Etsitään vahvat korrelaatiot (itseisarvo > 0.7)
cor_matrix <- cor(mtcars[, c("mpg", "disp", "hp", "drat", "wt", "qsec")])
for (i in 1:(nrow(cor_matrix)-1)) {
  for (j in (i+1):ncol(cor_matrix)) {
    if (abs(cor_matrix[i,j]) > 0.7) {
      cat("  ", colnames(cor_matrix)[i], " ja ", colnames(cor_matrix)[j], 
          ": ", round(cor_matrix[i,j], 2), "\n")
    }
  }
}
cat("\n")

cat("Tehokkaimmat autot (Top 5 hevosvoimien mukaan):\n")
top5_hp <- head(mtcars_df[order(-mtcars_df$hp), ], 5)
for (i in 1:nrow(top5_hp)) {
  cat("  ", top5_hp$car_name[i], ": ", top5_hp$hp[i], " hp\n")
}
cat("\n")

cat("Taloudellisin auto:\n")
most_efficient <- mtcars_df[which.max(mtcars_df$mpg), ]
cat("  ", most_efficient$car_name, " (", most_efficient$mpg, " mpg)\n\n")

cat("=========================================================\n")

# ======== Yhteenveto ========

cat("\nTässä esimerkissä opimme:\n")
cat("1. Datan lataaminen ja esikäsittely\n")
cat("2. Peruskuvaajien luominen\n")
cat("3. Edistyneempien visualisointien luominen\n")
cat("4. Ryhmiteltyjen visualisointien luominen\n")
cat("5. Korrelaatioiden tarkastelu\n")
cat("6. Moniulotteisten visualisointien luominen\n")
cat("7. Kuvaajien muokkaaminen ja hienosäätö\n")
cat("8. Kuvaajien tallentaminen eri formaateissa\n")
cat("9. Datan yhteenvedon luominen\n\n")

cat("Visualisointi on olennainen osa data-analyysiä. Se auttaa ymmärtämään dataa,\n")
cat("tunnistamaan trendejä ja malleja sekä kommunikoimaan löydöksiä tehokkaasti.\n")
cat("R tarjoaa monipuoliset työkalut erilaisten visualisointien luomiseen,\n")
cat("alkaen perusvisualisoinneista edistyneempiin ja interaktiivisiin visualisointeihin.\n")
