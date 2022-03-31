# Master script for the project ################################

library(rmarkdown)
options(brms.backend = "cmdstanr")


## Barcoding: PV indiv & Pbird -> Pvisit.sp

# Madroñas
render("code/Barcoding_PV_indiv_bird.Rmd", 
       output_file = "Barcoding_PV_indiv_bird_Madronas.md",
       params = list(site = "Madronas"))

# Puntal 
render("code/Barcoding_PV_indiv_bird.Rmd", 
       output_file = "Barcoding_PV_indiv_bird_Puntal.md",
       params = list(site = "Puntal"))

## Barcoding: PV site
render("code/Barcoding_PV_site_after.Rmd")


## Videos (only Puntal)
render("code/Videos_PV_indiv_bird.Rmd")


## Puntal: merge barcoding + Videos
render("code/PV_merge_Puntal.Rmd")


#### Pfeed
render("code/Prob_consumption_visit.Rmd")


#### Nfruits/visit
render("code/Number_fruits_visit.Rmd")


#### Prob. escape from seed predators
render("code/Prob_escape_seed_predators.Rmd")


## SDE QTY: multiply everything
render("code/SDE_QTY.Rmd")



##### SDE QUALITY #####

## Probability of dispersal to each Microhabitat by each bird species
render("code/Prob_MH_use.Rmd")

## Probability of emergence and surviving 1st summer
render("code/mh_emergence.Rmd")

## Probability of escaping seed predation
render("code/mh_seed_predation.Rmd")


## SDE-QLTY total
render("code/SDE_QLTY.Rmd")




## DATA COMBINATION ############################################

#### Effectiveness calculations
render("code/calc_effectiveness.Rmd")

#### Calculate effectiveness for individual plants (grouping all birds consumption)
render("code/calc_effectiveness_plants.Rmd")


## EFFECTIVENESS ANALYSES  #####################################

#### Figure 3. Effectiveness landscape 
render("code/Fig.3_Effectiveness_landscapes.Rmd")

#### QTC and QLC components variance partitioning
render("code/variance_partitioning.Rmd")

#### Plant trait effects on fruit consumption (GLM)
render("code/GLM_effectiveness.Rmd")


## RECIPROCITY ANALYSES  #######################################

#### RPE~SDE model
render("code/effectiveness_correlation_distribution.Rmd")

#### Figure 4. RPE~SDE correlation
render("code/Fig.4_RPE_SDE_cor.Rmd")


## ASYMMETRY ANALYSES  #########################################

#### Calculation of dependence and asymmetry
render("code/prep_dependencies_unique_interactions.Rmd")

#### Figure 5. Dependence and Asymmetry distribution
render("code/Fig.5_Asymmetry.Rmd")

#### Asymmetry Null model - matrix dimension
render("code/Null_models_dim.Rmd")

#### Asymmetry Null model - significance
render("code/Null_model_asym_sig.Rmd")


## OTHER #######################################################

#### Suppl. Mat. Fig - Accumulation curves

#### Suppl. Mat. Fig - Predation and Germination

#### Suppl. Mat. Fig - Fruit quality

#### Suppl. Mat. Fig - MH use and suitability

#### Suppl. Mat. Fig - Individual plant's crop consumption

#### Suppl. Mat. Fig - Fruit availability vs. Crop consumption

