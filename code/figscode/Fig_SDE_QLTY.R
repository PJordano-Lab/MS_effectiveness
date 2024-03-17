
library(here)
library(tidyverse)
library(ggdist)
theme_set(theme_minimal())

qlt <- readRDS(here("data", "SDE_QLTY_total.rds"))  %>% 
  mutate(bird_sp = ifelse(bird_sp == "Sylvia communis", "Curruca communis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia melanocephala", "Curruca melanocephala", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia undata", "Curruca undata", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia hortensis", "Curruca hortensis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia cantillans", "Curruca cantillans", bird_sp)
  )


qlt %>%
  ggplot() +
  stat_pointinterval(aes(P.recruit, reorder(bird_sp, P.recruit, FUN = median)),
                     .width = c(0.66, 0.95),
                     point_size = 2, colour = "grey30") +
  labs(x = "\nProbability of recruitment per consumed fruit",
       y = "",
       # caption = "Birs species sorted by decreasing median probability (dots). Intervals represent 0.66 and 0.95 credibility intervals"
       ) +
  theme(axis.title.x = element_text(size = rel(1.3)),
        plot.caption = element_text(colour = "grey30"),
        axis.text.y = element_text(face = "italic"))


# qlt %>% 
#   ggplot() +
#   stat_slab(aes(P.recruit, bird_sp), normalize = "groups") +
#   coord_cartesian(xlim = c(0, 0.002))
  
  
ggsave(here("analysis", "output", "Figures", "SDE_QLTY.pdf"), 
         width = 7, height = 9, units = "in")

ggsave(here("analysis", "output", "Figures", "SDE_QLTY.png"), 
       width = 7, height = 9, units = "in", dpi = 600, bg = "white")



qlt.mh <- readRDS(here("data", "SDE_QLTY_mh.rds"))  %>% 
  mutate(bird_sp = ifelse(bird_sp == "Sylvia communis", "Curruca communis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia melanocephala", "Curruca melanocephala", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia undata", "Curruca undata", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia hortensis", "Curruca hortensis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia cantillans", "Curruca cantillans", bird_sp)
  )

mh_cols <- c("FR"="#8d0060", "PP"="#cadd79", "PL"="#7186ff", "NF"="#fd863e", "OA"="#843600")

ggplot(qlt.mh, aes(y = mh, x = Prob.bird.disperse.mh, color = mh)) + 
  stat_pointinterval(alpha = .5) + 
  facet_wrap(~bird_sp, ncol = 4) + 
  scale_color_manual(values = mh_cols) + 
  theme(strip.text = element_text(face = "italic"),
        legend.position = "none",
        axis.text.x = element_text(angle = 90)) + 
  labs(y = NULL, x = "Proportion bird's microhabitat use")

ggsave(here("../../EBD-PhD/Tesis/bckup/Chap2/MH_use.pdf"), 
       width = 5, height = 7)
