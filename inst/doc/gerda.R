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
#  # Load the municipal harmonized dataset
#  municipal_harm_data <- load_gerda_web("municipal_harm", verbose = TRUE, file_format = "rds")

## -----------------------------------------------------------------------------
gerda_data_list()

## ----eval=FALSE---------------------------------------------------------------
#  federal_cty_harm <- load_gerda_web("federal_cty_harm", verbose = TRUE)

