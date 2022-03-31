
library(here)
library(tidyverse)
library(ggdist)

Pfeed <- readRDS(here("analysis", "output", "Pfeed.post.rds")) %>% 
  mutate(bird_sp = ifelse(bird_sp == "Sylvia communis", "Curruca communis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia melanocephala", "Curruca melanocephala", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia undata", "Curruca undata", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia hortensis", "Curruca hortensis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia cantillans", "Curruca cantillans", bird_sp)
  ) %>% 
  mutate(bird_sp = ifelse(bird_sp == "Coccothraustes coccothraustes", "C. coccothraustes", bird_sp))



ggplot(Pfeed) +
  theme_minimal() +
  facet_wrap(~bird_sp, ncol = 5) +
  stat_slab(aes(Pfeed), normalize = "panels") +
  labs(x = "\nProbability of consumption per visit", 
       y = "Density") +
  scale_y_continuous(breaks = c(0, 0.50, 1)) +
  scale_x_continuous(labels = as.character(c(0, 0.25, 0.50, 0.75, 1))) +
  theme(panel.grid.minor = element_blank(),
        strip.text = element_text(size = rel(0.9), face = "italic"),
        axis.text.x = element_text(size = rel(0.8)))
  
  
ggsave(here("analysis", "output", "Figures", "Pfeed.pdf"), 
         width = 9, height = 12, units = "in")

ggsave(here("analysis", "output", "Figures", "Pfeed.png"), 
       width = 9, height = 12, units = "in", dpi = 600, bg = "white")
