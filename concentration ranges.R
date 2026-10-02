# Concentration-window plot: one panel per drug, each with its own log x-axis.
# Needs: install.packages(c("tidyverse", "scales", "ggh4x"))
# CSV columns: drug, type ("clinical" / "in vitro"), label,
#              low_nM, high_nM (equal = single value), tested_low_nM, tested_high_nM
library(tidyverse)
library(scales)
library(ggh4x)

data <- read_csv("C:/Git folder/Proper drugscreenpaper/drugscreen concentrations figure.csv")


dat <- data %>% drop_na() %>% 
  mutate(drug = factor(Drug, levels = unique(Drug)),
         type = factor(type, levels = c("clinical", "in vitro"))) %>%
  arrange(drug, type) %>%                                   # clinical on top within each drug
  mutate(key = factor(paste(drug, Label, sep = "|"),        # drug|label keeps labels unique per drug
                      levels = rev(unique(paste(drug, Label, sep = "|")))))

tested <- dat %>%
  distinct(drug, tested_low_uM, tested_high_uM) %>%
  pivot_longer(starts_with("tested"), values_to = "conc")

ggplot(dat, aes(y = key, colour = type)) +
  # ranges = thick segments (thickness in points, so identical in every panel)
  geom_segment(data = filter(dat, low_uM != high_uM),
               aes(x = low_uM, xend = high_uM, yend = key),
               linewidth = 4, lineend = "round") +
  # single values (e.g. one EC50) = diamonds
  geom_point(data = filter(dat, low_uM == high_uM),
             aes(x = low_uM), shape = 18, size = 5) +
  geom_vline(data = tested, inherit.aes = FALSE,
             aes(xintercept = conc, linetype = "Tested concentrations"), color= "black")+
  # one panel per drug; independent x-axes; panel height follows number of rows
  facet_grid2(drug ~ ., scales = "free", space = "free_y",
              independent = "x", axes = "all", switch = "y") +
  scale_x_log10(labels = label_number(big.mark = ",")) +
  scale_y_discrete(labels = ~ sub("^.*\\|", "", .x),        # drop the "drug|" prefix
                   expand = expansion(add = 0.7), 
                   position = "right") +
  scale_colour_manual(values = c("clinical" = "cornflowerblue", "in vitro" = "lightgreen"),
                      labels = c("Clinical exposure", "In vitro EC50/IC50"), name = NULL) +
  scale_linetype_manual(values = "dashed", name = NULL) +
  labs(x = "Concentration (uM)", y = NULL) +
  theme_bw() +
  theme(strip.placement = "outside",
        strip.text.y.left = element_text(angle = 0, face = "bold", hjust = 0),
        strip.background = element_blank(),
        panel.spacing.y = unit(1.5, "lines"),
        panel.grid.major.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.position = "bottom")


