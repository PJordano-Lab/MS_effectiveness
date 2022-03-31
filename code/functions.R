check_brms <- function(model,             # brms model
                       integer = FALSE,   # integer response? (TRUE/FALSE)
                       plot = TRUE,       # make plot?
                       nsamples = 1000,   # posterior samples in posterior_predict
                       ntrys = 5,         # number of trys in truncated distributions. See posterior_predict
                       ...                # further arguments for DHARMa::plotResiduals 
) {
  
  mdata <- brms::standata(model)
  if (!"Y" %in% names(mdata))
    stop("Cannot extract the required information from this brms model")
  
  dharma.obj <- DHARMa::createDHARMa(
    simulatedResponse = t(brms::posterior_predict(model, ndraws = nsamples, ntrys = ntrys)),
    observedResponse = mdata$Y, 
    fittedPredictedResponse = apply(
      t(brms::posterior_epred(model, ndraws = nsamples, re.form = NA)),
      1,
      mean),
    integerResponse = integer)
  
  if (isTRUE(plot)) {
    plot(dharma.obj, ...)
  }
  
  invisible(dharma.obj)
  
}


Nvisit2Pvisit <- function(Nvisit.postmat, tidy = TRUE) {
  Nvisit.postmat$sum <- apply(Nvisit.postmat, 1, sum)
  Pvisit <- Nvisit.postmat[, -ncol(Nvisit.postmat)]
  for (i in seq_len(ncol(Pvisit))) {
    Pvisit[, i] <- as.matrix(Nvisit.postmat[, i])/as.matrix(Nvisit.postmat[, ncol(Nvisit.postmat)])
  }
  
  if (isTRUE(tidy)) {
    Pvisit <- Pvisit %>% 
      as.data.frame() %>% 
      tidyr::pivot_longer(cols = everything(), names_to = "id_plant", values_to = "Pvisit") %>% 
      mutate(id_plant = as.numeric(id_plant))
  }
  
  Pvisit
}


#### PROCESSING POSTERIORS ##########################

# Writing a function to multiply probabilities by plant; otherwise memory errors
mutiply_PVindiv_Pbird <- function(Pbird.id, Pvis = Pvisit) {
  Pv = Pvis %>% 
    filter(id_plant == as.character(Pbird.id$id_plant[1])) %>% 
    pull(Pvisit)
  
  post <- Pbird.id %>%
    group_by(bird_sp) %>%
    mutate(Pv = Pv) %>%
    mutate(Pvisit.sp = Pbird*Pv)
  
  post
}



# Writing a function to multiply probabilities by plant; otherwise memory errors
multiply_PVsp_site <- function(Pvis.sp = NULL, PVsite = Psite) {
  
  Pvisit.site <- PVsite$Pvisit 
  
  post <- Pvis.sp %>%
    group_by(bird_sp) %>%
    mutate(PVsite = Pvisit.site) %>%
    mutate(Pvisit.sp.site = Pvisit.sp*PVsite)
  
  post
}



## Calculate probability of dispersing to each MH for each bird species
calc_prob_bird_mh <- function(bird.data = NULL) {
  
  bird.data %>% 
    select(-bird_sp) %>% 
    tidyr::pivot_wider(names_from = "mh", values_from = "seeds.m2.bird") %>% 
    tidyr::unnest(cols = c(FR, NF, OA, PL, PP)) %>% 
    mutate(seeds.total = FR + NF + OA + PL + PP) %>% 
    mutate(across(.fns = function(x, seeds.t) {x / seeds.t}, seeds.t = seeds.total)) %>% 
    select(-seeds.total) %>% 
    pivot_longer(cols = everything(), names_to = "mh", values_to = "Prob.bird.mh") %>% 
    arrange(mh) %>% 
    mutate(bird_sp = unique(bird.data$bird_sp)) %>% 
    relocate(bird_sp)
}


#### PLOTS ##########################

plot_Pbird_plant <- function(pop = psite, df = bc.Pbird.post, bc.cam = NULL, all = FALSE) {
  
  gg <- df %>% 
    ggplot() +
    facet_wrap(~id_plant, ncol = 5) +
    aes(x = reorder(bird_sp, Pbird), y = Pbird) +
    stat_gradientinterval(size = 1) +
    coord_flip() +
    theme(axis.text.y = element_text(size = 3),
          axis.text.x = element_text(size = 5)) +
    labs(title = pop,
         x = "",
         y = "Probability of visit by each bird species") 
  
  print(gg)
  
  if (isTRUE(all)) {all = "_all"} else {all = ""}
  
  ggsave(here("analysis", "output", paste0(bc.cam, ".Pbird_", pop, "_plant", all, ".pdf")), 
         width = 9, height = 11, units = "in")
  
  invisible(gg)
  
}



plot_Pbird_bird <- function(pop = psite, df = bc.Pbird.post, bc.cam = NULL, all = FALSE) {
  
  gg <- df %>% 
    ggplot() + 
    facet_wrap(~bird_sp, ncol = 6) +
    aes(x = rev(sort(id_plant)), y = Pbird) +
    stat_gradientinterval(size = 1) +
    coord_flip() +
    theme(axis.text.y = element_text(size = 3),
          axis.text.x = element_text(size = 5),
          strip.text = element_text(size = 6)) +
    labs(title = pop,
         x = "Plant",
         y = "Probability of visiting each plant") 
  
  print(gg)
  
  if (isTRUE(all)) {all = "_all"} else {all = ""}
  
  ggsave(here("analysis", "output", paste0(bc.cam, ".Pbird_", pop, "_bird", all, ".pdf")), 
         width = 9, height = 11, units = "in")
  
  invisible(gg)
}




plot_PV_plant <- function(pop = psite, df = Pvisit.sp, bc.cam = NULL, all = FALSE) {
  
  gg <- df %>% 
    ggplot() +
    facet_wrap(~id_plant, ncol = 5) +
    aes(x = reorder(bird_sp, Pvisit.sp), y = Pvisit.sp) +
    stat_gradientinterval(size = 1) +
    coord_flip() +
    theme(axis.text.y = element_text(size = 3),
          axis.text.x = element_text(size = 5)) +
    labs(title = pop,
         x = "",
         y = "Probability of visit") 
  
  print(gg)
  
  if (isTRUE(all)) {all = "_all"} else {all = ""}
  
  ggsave(here("analysis", "output", paste0(bc.cam, ".Pvisit.sp_", pop, "_plant", all, ".pdf")), 
         width = 9, height = 11, units = "in")
  
  invisible(gg)
  
}



plot_PV_plant_site <- function(pop = psite, df = Pvisit.sp.site, all = FALSE) {
  
  gg <- df %>% 
    filter(site == pop) %>% 
    ggplot() +
    facet_wrap(~id_plant, ncol = 5) +
    aes(x = reorder(bird_sp, Pvisit.sp.site), y = Pvisit.sp.site) +
    stat_gradientinterval(size = 1) +
    coord_flip() +
    theme(axis.text.y = element_text(size = 3),
          axis.text.x = element_text(size = 5)) +
    labs(title = pop, 
         x = "",
         y = "Probability of visit") 
  
  print(gg)
  
  if (isTRUE(all)) {all = "_all"} else {all = ""}
  
  ggsave(here("analysis", "output", paste0("bc.Pvisit.sp.site_", pop, "_plant", all, ".pdf")), 
         width = 9, height = 11, units = "in")
  
  invisible(gg)
  
}




add_Pfeed_Nfru_sp <- function(sp.list, pfeed, nfru) {
  bird.sp <- unique(sp.list$bird_sp)
  out <- sp.list %>% 
    mutate(Pfeed = rep(pfeed$Pfeed[pfeed$bird_sp == bird.sp], times = nrow(sp.list)/1000),
           Nfruits = rep(nfru$Nfruits[nfru$bird_sp == bird.sp], times = nrow(sp.list)/1000))
  
}
