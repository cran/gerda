## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(gerda)

## -----------------------------------------------------------------------------
gerda_data_list()

## ----eval=FALSE---------------------------------------------------------------
# # Load the municipal harmonized dataset
# municipal_harm_data <- load_gerda_web(
#   "municipal_harm",
#   verbose = TRUE,
#   file_format = "rds",
#   on_error = "stop",
#   cache = TRUE
# )

## -----------------------------------------------------------------------------
catalog <- gerda_data_list(print_table = FALSE)
subset(catalog,
       election_type == "federal" &
       geographic_level == "municipality" &
       boundary == "2025")

## -----------------------------------------------------------------------------
gerda_data_list()

## ----eval=FALSE---------------------------------------------------------------
# federal_cty_harm <- load_gerda_web(
#   "federal_cty_harm",
#   verbose = TRUE,
#   on_error = "stop",
#   cache = TRUE
# )

## ----eval=FALSE---------------------------------------------------------------
# library(dplyr)
# 
# # Load election data and add covariates
# merged <- load_gerda_web(
#   "federal_cty_harm",
#   on_error = "stop",
#   cache = TRUE
# ) %>%
#   add_gerda_covariates(unmatched = "error")
# 
# join_report <- gerda_join_diagnostics(merged)

## ----eval=FALSE---------------------------------------------------------------
# # Get the codebook
# codebook <- gerda_covariates_codebook()
# print(codebook)
# 
# # Find variables with good coverage
# library(dplyr)
# codebook %>%
#   filter(missing_pct < 10) %>%
#   select(variable, label, category)

## ----eval=FALSE---------------------------------------------------------------
# # Get raw covariate data
# covs <- gerda_covariates()
# 
# # Inspect before merging
# summary(covs$unemployment_rate)
# 
# # Custom merge
# elections <- load_gerda_web("federal_cty_harm")
# merged <- elections %>%
#   left_join(covs, by = c("county_code" = "county_code", "election_year" = "year"))

## ----eval=FALSE---------------------------------------------------------------
# library(gerda)
# 
# # Add census data to municipal-level elections
# muni_merged <- load_gerda_web(
#   "federal_muni_harm_21",
#   on_error = "stop",
#   cache = TRUE
# ) |>
#   add_gerda_census(unmatched = "error")
# 
# # Also works with county-level data (aggregated from municipalities)
# county_merged <- load_gerda_web(
#   "federal_cty_harm",
#   on_error = "stop",
#   cache = TRUE
# ) |>
#   add_gerda_census(unmatched = "error")
# 
# gerda_join_diagnostics(muni_merged)

## ----eval=FALSE---------------------------------------------------------------
# # Get the census codebook
# census_cb <- gerda_census_codebook()
# print(census_cb)

## ----eval=FALSE---------------------------------------------------------------
# # Map GERDA party names to left-right positions
# parties <- c("cdu", "spd", "linke_pds", "fdp")
# left_right_scores <- party_crosswalk(parties, "left_right")
# print(left_right_scores)
# 
# # Map to English party names
# english_names <- party_crosswalk(parties, "party_name_english")
# print(english_names)

