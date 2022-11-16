# Dataset and code for Mutualism Effectiveness and Reciprocity Manuscript

Manuscript title: 'Reciprocity and interaction effectiveness in generalized mutualisms among free-living species'

Authors: Elena Quintero, Francisco Rodríguez-Sánchez and Pedro Jordano.

Link manuscript Ecology Letters: <https://doi.org/10.1111/ele.14141> (available soon)

Link preprint BioRxiv: <https://doi.org/10.1101/2022.03.23.485462>

Link dataset in Dryad: <https://doi.org/10.5061/dryad.02v6wwq6n>

#### Suggested Citations:

*Manuscript citation:*

Quintero, E., Rodríguez-Sánchez, F. & Jordano, P. 2022. Reciprocity and interaction effectiveness in generalized mutualisms among free-living species. *Ecology Letters*, <https://doi.org/10.1111/ele.14141>

*Dataset citation:*

Quintero, E, Rodríguez-Sánchez, F. & Jordano, P. 2022. Data for the article "Reciprocity and interaction effectiveness in generalized mutualisms among free-living species", *Dryad*, Dataset, <doi:10.5061/dryad.02v6wwq6n>

#### Licenses

Data: [CC0](https://creativecommons.org/share-your-work/public-domain/cc0/) - the authors respectfully request to be contacted or credited by researchers interested in the re-use of the data.

Code: MIT license (see MIT-license.txt)

#### Corresponding Author Information

-   Name: Elena Quintero
-   Email: [elenaquintero.qb\@gmail.com](mailto:elenaquintero.qb@gmail.com){.email}
-   Affiliation: Department of Integrative, Estación Biológica de Doñana - CSIC, Sevilla, Spain
-   ORCID ID: <https://orcid.org/0000-0003-4979-6874>

## Description of the Data and file structure

Dataset and code present in this project are designed to calculate the effectiveness of the mutualistic service between frugivore animals and fruiting plants. The estimations follow the effectiveness framework (see Schupp et al 2017) and the code is structured based on these estimations.

![](framework.jpg)

#### Dataset description:

All the variables present within the datasets are described in the metadata folder. Data was collected in a shrubland dominated by *Pistacia lentiscus* in Doñana National Park (Huelva, Spain).

-   *bc_indiv_lentisc.csv* - DNA-barcoding identification of bird samples collected underneath individual plants of *Pistacia lentiscus*.

-   *cam_indiv_lentisc.csv* - Animal recorded visitation events to individual plant of *Pistacia lentiscus*.

-   *BirdFuncDat.txt* - Traits for all bird species extracted from Elton Traits.

-   *lentisc_feeding_rates.csv* - Number of fruits of *Pistacia lentiscus* that birds consumed per visit recorded through camera monitoring.

-   *fruit_characteristics.csv* - Fruit and seed weight of individual plants of *Pistacia lentiscus* at the study site.

-   *fruit_traits_HR_pedro.csv* - Water proportion found in fruits and seeds of *Pistacia lentiscus* at Hato Ratón site in Doñana NP. Data coming from Pedro Jordano's (co-author) PhD Thesis

-   *seed_predators_escape.csv* - Number of predated seeds of *Pistacia lentiscus* found at seed traps and number of intact seeds assigned through DNA-barcoding to granivorous birds.

-   *mh_combined_barcoding.csv* - DNA-barcoding identifications of bird samples collected at five different microhabitats - under *Pistacia lentiscus* conspecifics (PL) , under other fleshy fruited species (FR), under non-fleshy fruited species (NF), under pine trees (*Pinus pinea*; PP), and open ground areas (OA) 

-   *seed_predation.csv* - Results of *Pistacia lentiscus* seeds exposed to post-dispersal predation experiment at five different microhabitats.

-   *seedling_emergence.csv* - Results of *Pistacia lentiscus* seeds emergence and survival experiment at five different microhabitats.

-   *dron_areas.csv* - Individual *Pistacia lentiscus* plants' crown area measured using a dron.

Resulting dataset using the dataset above and generated using the codes below:

-   asymm_null_models_patefield.rds - results of null models (n=1000) for asymmetry distribution values in the interaction matrix, following Patefield null model.

-   asymm_null_models_vazquez.rds - results of null models (n=1000) for asymmetry distribution values in the interaction matrix, following Vázquez null model.

-   *bc.indiv.Madronas.Nvisits.post.long.rds* - Posterior distribution of the number of visits that bird did at individual plants of *Pistacia lentiscus* found at El Puntal site.

-   *bc.indiv.Puntal.Nvisits.post.long.rds* - Posterior distribution of the number of visits that bird did at individual plants of *Pistacia lentiscus* found at Laguna de las Madroñas site calculated using DNA-barcoding dataset.

-   *bc.Pvisit.sp.Madronas.rds* - Posterior distribution of the probability that a bird species visits an individual plant of *Pistacia lentiscus* in Laguna de las Madroñas site calculated using DNA-barcoding dataset.

-   *bc.Pvisit.sp.Puntal.rds* - Posterior distribution of the probability that a bird species visits an individual plant of *Pistacia lentiscus* in El Puntal site.

-   *cam.Pvisit.sp.Puntal.rds* - Posterior distribution of the probability that a bird species visits an individual plant of *Pistacia lentiscus* in Laguna de las Madroñas site calculated using camera dataset.

-   *consumed_fruit_mat.csv* - Matrix of animal-plant interactions where the values in the cell represent the total number of fruits that bird species consumed at individual plants of *Pistacia lentiscus.*

-   *effectiveness_summary.csv* - Summary values (median and mean) for effectiveness estimations and its subcomponents.

-   *Dependency_distribution.rds* - Mutual dependency estimation between animals and plants using effectiveness values and their asymmetry.

-   *Effectiveness_correlation_slope_CI_sd.rds* - Standard deviation of the confidence interval for the correlation between the two-sided effectiveness values of individual *Pistacia lentiscus* plants.

-   *Effectiveness_correlation_slope_CI.rds* - Confidence interval for the correlation between the two-sided effectiveness values of individual *Pistacia lentiscus* plants.

-   *Effectiveness_correlation_slopes_sd.rds* - Standard deviation for the correlation between the two-sided effectiveness values of individual *Pistacia lentiscus* plants.

-   *Effectiveness_correlation_slopes.rds* - Calculated correlation between the two-sided effectiveness values of individual *Pistacia lentiscus* plants.

    Effectiveness_plants_no_pred.rds

    Effectiveness_plants.rds

    effectiveness.rds

    Nfruits_visit_post_long.rds

    null_model_matrix_dimensions.rds

    null_models_patefield.rds

    null_models_vazquez.rds

    Nvisits.site.rds

    Pdisperse.bird.mh.rds

    Pfeed.post.rds

    pred.mh.post.long.rds

    prob.escape.rds

    PV.Puntal.combined.rds

    SDE_QLTY_mh.rds

    SDE_QLTY_total.rds

    SDE_QTY_crop_consumed_wide.rds

    SDE_QTY_Nfruits_escape.rds

    surv.mh.post.rds

#### Code description:

![](code.jpg)

The code is structured as following:

Barcoding_PV_indiv_bird.Rmd
Barcoding_PV_site_after.Rmd
calc_effectiveness_plants.Rmd
calc_effectiveness.Rmd
effectiveness_correlation_distribution.Rmd
Fig.3_Effectiveness_landscapes.Rmd
Fig.4_RPE_SDE_cor.Rmd
Fig.5_Asymmetry.Rmd
GLM_effectiveness.Rmd
mh_emergence.Rmd
mh_seed_predation.Rmd
Null_model_asym_sig.Rmd
Null_models_dim.Rmd
Number_fruits_visit.Rmd
prep_dependencies_unique_interactions.Rmd
Prob_consumption_visit.Rmd
Prob_escape_seed_predators.Rmd
Prob_MH_use.Rmd
PV_merge_Puntal.Rmd
QTY.Rmd
SDE_QLTY.Rmd
variance_partitioning.Rmd
Videos_PV_indiv_bird.Rmd


## Sharing Information

Bird species' body mass data (file "BirdFuncDat.txt") was derived from the following source:

Wilman, H., Belmaker, J., Simpson, J., de la Rosa, C., Rivadeneira, M.M. and Jetz, W. (2014), **EltonTraits 1.0:** Species-level foraging attributes of the world's birds and mammals. Ecology, 95: 2027-2027. <https://doi.org/10.1890/13-1917.1> - <https://doi.org/10.6084/m9.figshare.c.3306933.v1>)

\-\-\-\-\-\--

References:

Schupp, E.W., Jordano, P. & Gómez, J.M. (2017). A general framework for effectiveness concepts in mutualisms. Ecol. Lett., 20, 577--590.\
