# GIDEON
A package for accessing the GIDEON API

The gideon package provides functions to access the GIDEON API without the need of writing your own REST API queries.

## Installation
1. Install the R devtools package with the command `install.packages("devtools")` and load devtools library into R using `library(devtools)`
2. Install the GIDEON R package using `install_bitbucket(<PLACEHOLDER FOR GIDEON R REPOSITORY PATH>)`
3. Load GIDEON R package with `library(gideon)`

## Package Help
Type `?gideon` into the R console to get additional documentation for the package.

## Authentication
Provide your GIDEON API key as a key-value pair in your `.Renviron` file as GIDEON_API_KEY=\<YOUR API KEY\>

## GIDEON ID Codes
Many of the items in the GIDEON database use an id code, such as diseases,
bacteria, drugs, etc. Use `lookup_gideon_id` to know what
specific code to use when calling the GIDEON API.

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
* query_gideon_api
