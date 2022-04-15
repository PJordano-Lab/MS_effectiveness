
library(here)
library(tidyverse)
library(ggdist)

surv <- readRDS(here("data", "surv.mh.post.rds")) 

# ggplot(surv) +
#   geom_density(aes(surv.avg), fill = "lightgrey") +
#   facet_wrap(~mh, ncol = 1, scales = "free_y") +
#   theme(axis.text.y = element_blank()) +
#   labs(title = "Average of both years")


ggplot(surv) +
  theme_minimal() +
  facet_wrap(~mh, ncol = 1) +
  stat_slab(aes(surv.avg), normalize = "panels") +
  labs(x = "\nProbability of seedling survival", y = "Density") +
  scale_y_continuous(breaks = c(0, 0.50, 1)) +
  coord_cartesian(xlim = c(0, 0.20)) +
  theme(panel.grid.minor = element_blank(),
        strip.text = element_text(size = rel(1.2)),
        axis.text.x = element_text(size = rel(1.2)),
        axis.title.x = element_text(size = rel(1.2)))
  
  
ggsave(here("analysis", "output", "Figures", "seedling_survival.pdf"), 
         width = 9, height = 11, units = "in")

ggsave(here("analysis", "output", "Figures", "seedling_survival.png"), 
       width = 9, height = 11, units = "in", dpi = 600, bg = "white")
