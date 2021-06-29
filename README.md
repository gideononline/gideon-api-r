# GIDEON - R Interface (BETA)
A package for accessing the GIDEON API using R.

The gideon package provides functions to access the GIDEON API without the need of writing your own REST API queries.

## Installation
Execute the following commands in the the **R console**:
1. Install the R devtools package with the command `install.packages("devtools")`
2. Install the GIDEON R package using `devtools::install_bitbucket("gideononline/gideon-api-r")`
3. Load GIDEON R package with `library(gideon)`

## Package Help
Type `?gideon` or `help(gideon)` into the R console to get the package documentation and overview of capabilities.

## Authentication
All calls to the GIDEON API require an API key to work.
Provide your GIDEON API key as an R environment variable by appending the following line to your *.Renviron* file: `GIDEON_API_KEY=<YOUR API KEY>`.
The *.Renviron* file can be edited. by running the command `usethis::edit_r_environ()` in the R console.

## GIDEON ID Codes
Many of the items in the GIDEON database use an id code, such as diseases, bacteria, drugs, etc.
Use `lookup_gideon_id` to get specific item code to use when calling the GIDEON API.

## Outbreak Functions
The functions to query outbreaks are:
* outbreaks_by_year
* outbreaks_by_country_year
* latest_outbreaks_by_country
* outbreaks_by_disease
* endemic_countries_by_disease
* endemic_diseases_by_country
 
## GIDEON API access functions
Functions to access the GIDEON API directly
*  query_gideon_api

## Examples
```
library(gideon)

cholera_code <- lookup_gideon_id("diseases", "Cholera")
cholera_outbreaks <- outbreaks_by_disease(cholera_code)

us_country_code <- lookup_gideon_id("countries", "United States")
outbreaks_us_2007 <- outbreaks_by_country_year(us_country_code, 2007)

mosquito_vector_code <- lookup_gideon_id("vectors", "Mosquito")
horse_reservoir_code <- lookup_gideon_id("reservoirs", "Horse")
diseases_from_horses_via_mosquitos <- filter_diseases(
    vector = mosquito_vector_code,
    reservoir = horse_reservoir_code
)
```
