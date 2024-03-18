
library(here)
library(tidyverse)
library(ggdist)

pred <- readRDS(here("data", "pred.mh.post.long.rds")) 

mh_cols <- c("FR"="#8d0060", "PP"="#cadd79", "PL"="#7186ff", "NF"="#fd863e", "OA"="#843600")

ggplot(pred, aes(color = mh, fill = mh)) +
  theme_minimal() +
  facet_wrap(~mh, ncol = 1) +
  # geom_histogram(aes(Nfruits))
  stat_slab(aes(Prob.escaping.pred), normalize = "panels", alpha = .5) +
  labs(x = "\nProbability of escaping postdispersal predation", y = "Density") +
  scale_y_continuous(breaks = c(0, 0.50, 1)) +
  coord_cartesian(xlim = c(0, 0.25)) +
  theme(panel.grid.minor = element_blank(),
        strip.text = element_text(size = rel(1.2)),
        axis.text.x = element_text(size = rel(1.2)),
        axis.title.x = element_text(size = rel(1.2)), 
        legend.position = "none") + 
  scale_color_manual(values = mh_cols)+ 
  scale_fill_manual(values = mh_cols)
  
  
ggsave(here("analysis", "output", "Figures", "Postdispersal_predation.pdf"), 
         width = 9, height = 11, units = "in")

ggsave(here("analysis", "output", "Figures", "Postdispersal_predation.png"), 
       width = 9, height = 11, units = "in", dpi = 600, bg = "white")
