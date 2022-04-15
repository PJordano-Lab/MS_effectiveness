
library(here)
library(tidyverse)
library(ggridges)
library(ggdist)
library(ggforce)
theme_set(theme_minimal())

# Load data

fulldata <- readRDS(here("data", "PV.Puntal.combined.rds")) %>% 
  mutate(bird_sp = ifelse(bird_sp == "Sylvia communis", "Curruca communis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia melanocephala", "Curruca melanocephala", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia undata", "Curruca undata", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia hortensis", "Curruca hortensis", bird_sp),
         bird_sp = ifelse(bird_sp == "Sylvia cantillans", "Curruca cantillans", bird_sp)
  )


#### Fig with Prob. visit for both cameras and barcoding ####

fulldata %>% 
  ggplot() +
  facet_wrap(~id_plant, ncol = 6) +
  geom_density_ridges(aes(y = factor(bird_sp, levels = rev(levels(factor(bird_sp)))),
                          # y = reorder(bird_sp, Pvisit.sp.bc), 
                          x = Pvisit.sp.bc), 
                      rel_min_height = 0.01,
                      scale = 1,
                      color = "orangered", fill = "orangered", alpha = 0.4, size = 0.01) +
  geom_density_ridges(aes(y = reorder(bird_sp, Pvisit.sp.bc), x = Pvisit.sp.cam), 
                      rel_min_height = 0.01,
                      scale = 1, 
                      color = "steelblue", fill = "steelblue", alpha = 0.4, size = 0.01) +
  theme(axis.text.y = element_text(size = 4),
        axis.text.x = element_text(size = 5)) +
  labs(title = "Puntal", 
       x = "\nProbability of visit",
       y = "") +
  coord_cartesian(xlim = c(0, 0.06)) +
  theme(plot.title = element_blank(),
        panel.grid.minor = element_blank()) +
  NULL

ggsave(here("analysis", "output", "Figures", "Pvisit.sp.Puntal.bc.cam.pdf"), 
       width = 9, height = 12, units = "in")

ggsave(here("analysis", "output", "Figures", "Pvisit.sp.Puntal.bc.cam.png"), 
       width = 9, height = 12, units = "in", dpi = 600)


#### Fig with Prob. visit for both cameras and barcoding (PAGINATED) ####

for (i in 1:2) {
  
  fulldata %>% 
    ggplot() +
    facet_wrap_paginate(~id_plant, ncol = 5, nrow = 4, page = i) +
    geom_density_ridges(aes(y = factor(bird_sp, levels = rev(levels(factor(bird_sp)))),
                            # y = reorder(bird_sp, Pvisit.sp.bc), 
                            x = Pvisit.sp.bc), 
                        rel_min_height = 0.01,
                        scale = 1,
                        color = "#FF450064", fill = "orangered", alpha = 0.4, size = 0.01) +
    geom_density_ridges(aes(y = reorder(bird_sp, Pvisit.sp.bc), x = Pvisit.sp.cam), 
                        rel_min_height = 0.01,
                        scale = 1, 
                        color = "#4682B464", fill = "steelblue", alpha = 0.4, size = 0.01) +
    theme(axis.text.y = element_text(size = 5),
          axis.text.x = element_text(size = 7)) +
    labs(title = "Puntal", 
         x = "\nProbability of visit",
         y = "") +
    coord_cartesian(xlim = c(0, 0.06)) +
    theme(plot.title = element_blank(),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(colour = "grey90", size = rel(0.5)),
          strip.text = element_text(size = rel(0.8))) +
    scale_x_continuous(labels = as.character(c(0, 0.02, 0.04, 0.06))) +
    NULL
  
  ggsave(here("analysis", "output", "Figures", paste0("Pvisit.sp.Puntal.bc.cam_page", i, ".pdf")), 
         width = 9, height = 12, units = "in")
  
  ggsave(here("analysis", "output", "Figures", paste0("Pvisit.sp.Puntal.bc.cam_page", i, ".png")), 
         width = 9, height = 12, units = "in", dpi = 600)
  
}



#### Consensus Prob visit in Puntal   ####

fulldata %>% 
  ggplot() +
  facet_wrap(~id_plant, ncol = 6) +
  stat_pointinterval(aes(y = factor(bird_sp, levels = rev(levels(factor(bird_sp)))),
                         # y = reorder(bird_sp, PV.combined), 
                         x = PV.combined), 
                     point_size = 0.5, size = 0.1,
                     .width = c(0.80)) +
  theme(axis.text.y = element_text(size = 4),
        axis.text.x = element_text(size = 6),
        plot.title = element_blank(), 
        plot.caption = element_text(size = 6, colour = "grey10"),
        panel.grid.minor = element_blank(),
        panel.grid.major = element_line(colour = "grey90", size = rel(0.5)),
        strip.text = element_text(size = rel(0.6))) +
  labs(title = "Puntal", 
       x = "\nProbability of visit",
       y = "",
       caption = "Intervals represent Bayesian 80% credible intervals") +
  coord_cartesian(xlim = c(0, 0.04)) +
  scale_x_continuous(labels = as.character(c(0, 0.01, 0.02, 0.03, 0.04))) +
  NULL

ggsave(here("analysis", "output", "Figures", "Pvisit.sp.Puntal.combined.pdf"), 
       width = 9, height = 12, units = "in")

ggsave(here("analysis", "output", "Figures", "Pvisit.sp.Puntal.combined.png"), 
       width = 9, height = 12, units = "in", dpi = 600)
