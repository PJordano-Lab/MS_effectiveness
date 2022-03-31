
library(here)
library(tidyverse)
library(ggdist)
source(here("R", "functions.R"))
theme_set(theme_minimal())

Pvisit.sp <- readRDS(here("analysis", "output", paste0("bc.Pvisit.sp.Madronas.rds"))) %>% 
  mutate(bird_sp = ifelse(bird_sp == "Sylvia communis", "Curruca communis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia melanocephala", "Curruca melanocephala", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia undata", "Curruca undata", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia hortensis", "Curruca hortensis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia cantillans", "Curruca cantillans", bird_sp)
  )

Pvisit.sp %>% 
  ggplot() +
  facet_wrap(~id_plant, ncol = 6) +
  stat_pointinterval(aes(y = factor(bird_sp, levels = rev(levels(factor(bird_sp)))), 
                         x = Pvisit.sp), 
                     point_size = 0.5, size = 0.1,
                     .width = c(0.80)) +
  theme(axis.text.y = element_text(size = 4),
        axis.text.x = element_text(size = 6),
        plot.caption = element_text(size = 6, colour = "grey10"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(colour = "grey90", size = rel(0.5)),
        strip.text = element_text(size = rel(0.6))) +
  labs(x = "\nProbability of visit",
       y = "",
       caption = "Intervals represent Bayesian 80% credible intervals") +
  coord_cartesian(xlim = c(0, 0.08)) +
  NULL

ggsave(here("analysis", "output", "Figures", "Pvisit.sp.Madronas.pdf"), 
       width = 9, height = 12, units = "in")

ggsave(here("analysis", "output", "Figures", "Pvisit.sp.Madronas.png"), 
       width = 9, height = 12, units = "in", dpi = 600)
