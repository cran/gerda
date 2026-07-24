## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(gerda)

## -----------------------------------------------------------------------------
catalog <- gerda_data_list(print_table = FALSE)

candidates <- subset(
  catalog,
  election_type == "federal" &
    geographic_level == "municipality" &
    boundary == "2025"
)

candidates[, c(
  "data_name", "year_start", "year_end", "boundary", "formats"
)]
stopifnot(nrow(candidates) == 1L)
data_name <- candidates$data_name[[1]]

## ----eval = FALSE-------------------------------------------------------------
# elections <- load_gerda_web(
#   data_name,
#   file_format = "rds",
#   on_error = "stop",
#   cache = TRUE
# )
# 
# stopifnot(is.data.frame(elections), nrow(elections) > 0L)

## ----eval = FALSE-------------------------------------------------------------
# dir.create("data/derived", recursive = TRUE, showWarnings = FALSE)
# snapshot_path <- file.path("data/derived", paste0(data_name, ".rds"))
# saveRDS(elections, snapshot_path)
# 
# provenance <- list(
#   package = "gerda",
#   package_version = as.character(utils::packageVersion("gerda")),
#   dataset = data_name,
#   format = "rds",
#   retrieved_at_utc = format(Sys.time(), tz = "UTC", usetz = TRUE),
#   snapshot_path = snapshot_path,
#   snapshot_md5 = unname(tools::md5sum(snapshot_path))
# )
# saveRDS(provenance, "data/derived/gerda_provenance.rds")

## ----eval = FALSE-------------------------------------------------------------
# required <- c("ags", "election_year")
# stopifnot(all(required %in% names(elections)))
# 
# if (!is.character(elections$ags) ||
#     any(!is.na(elections$ags) & !grepl("^[0-9]{8}$", elections$ags))) {
#   stop("ags must contain eight-digit character identifiers")
# }
# if (any(!stats::complete.cases(elections[required]))) {
#   stop("Missing geographic or time keys require investigation")
# }
# if (anyDuplicated(elections[required])) {
#   stop("ags + election_year is not unique; identify additional row keys")
# }
# 
# expected_years <- sort(unique(elections$election_year))
# years_by_unit <- split(elections$election_year, elections$ags)
# units_with_gaps <- names(Filter(
#   function(x) !identical(sort(unique(x)), expected_years),
#   years_by_unit
# ))

## ----eval = FALSE-------------------------------------------------------------
# enriched <- elections |>
#   add_gerda_covariates(unmatched = "error") |>
#   add_gerda_census(unmatched = "error")
# 
# join_report <- gerda_join_diagnostics(enriched)
# print(join_report)
# 
# stopifnot(
#   all(join_report$input_rows == join_report$output_rows),
#   all(join_report$unexpected_unmatched_rows == 0L)
# )
# saveRDS(join_report, "data/derived/gerda_join_diagnostics.rds")

## -----------------------------------------------------------------------------
covariates <- gerda_covariates()
covariate_codebook <- gerda_covariates_codebook()
census <- gerda_census()
census_codebook <- gerda_census_codebook()

stopifnot(
  !anyDuplicated(covariates[c("county_code", "year")]),
  !anyDuplicated(census["ags"]),
  all(names(covariates) %in% covariate_codebook$variable),
  all(names(census) %in% census_codebook$variable)
)

