
library(here)
library(tidyverse)
library(ggdist)

nfru <- readRDS(here("analysis", "output", "Nfruits_visit_post_long.rds")) %>% 
  mutate(bird_sp = ifelse(bird_sp == "Sylvia communis", "Curruca communis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia melanocephala", "Curruca melanocephala", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia undata", "Curruca undata", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia hortensis", "Curruca hortensis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia cantillans", "Curruca cantillans", bird_sp)
  ) %>% 
  mutate(bird_sp = ifelse(bird_sp == "Coccothraustes coccothraustes", "C. coccothraustes", bird_sp))



ggplot(nfru) +
  theme_minimal() +
  facet_wrap(~bird_sp, ncol = 5) +
  # geom_histogram(aes(Nfruits))
  stat_histinterval(aes(Nfruits), normalize = "panels",
                    interval_alpha = 0, point_alpha = 0) +
  labs(x = "\nNumber of fruits consumed per visit", 
       y = "Density") +
  scale_y_continuous(breaks = c(0, 0.50, 1)) +
  coord_cartesian(xlim = c(0, 60)) +
  theme(panel.grid.minor = element_blank(),
        strip.text = element_text(size = rel(0.9), face = "italic"),
        axis.text.x = element_text(size = rel(0.8)),
        axis.title.x = element_text(size = rel(1.2)))
  
  
ggsave(here("analysis", "output", "Figures", "Nfruits_visit.pdf"), 
         width = 9, height = 12, units = "in")

ggsave(here("analysis", "output", "Figures", "Nfruits_visit.png"), 
       width = 9, height = 12, units = "in", dpi = 600, bg = "white")
