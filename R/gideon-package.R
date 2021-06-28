#' gideon: A package for accessing the GIDEON API
#'
#' The gideon package provides functions to access the GIDEON API without the
#' need of writing your own REST API queries.
#'
#' @section Authentication:
#' All calls to the GIDEON API require an API key to work.
#' Provide your GIDEON API key as an R environment variable by appending the
#' following line to your \emph{.Renviron} file:
#' \code{GIDEON_API_KEY=<YOUR API KEY>}.
#' The \emph{.Renviron} file can be edited. by running the command
#' \code{usethis::edit_r_environ()} in the R console.
#'
#' @section GIDEON ID codes:
#' Many of the items in the GIDEON database use an id code, such as diseases,
#' bacteria, drugs, etc. Use \code{\link{lookup_gideon_id}} to know what
#' specific code to use when calling the GIDEON API.
#'
#' @section Outbreak functions:
#' The functions to query outbreaks are:
#' \itemize{
#'  \item \code{\link{outbreaks_by_year}},
#'  \item \code{\link{outbreaks_by_country_year}},
#'  \item \code{\link{latest_outbreaks_by_country}},
#'  \item \code{\link{outbreaks_by_disease}},
#'  \item \code{\link{endemic_countries_by_disease}},
#'  \item \code{\link{endemic_diseases_by_country}},
#' }
#'
#' @section GIDEON access functions:
#' Functions to access the GIDEON API directly
#' \itemize{
#'  \item \code{\link{query_gideon_api}}
#' }
#'
#' @examples
#' cholera_code <- lookup_gideon_id("diseases", "Cholera")
#' cholera_outbreaks <- outbreaks_by_disease(cholera_code)
#'
#' us_country_code <- lookup_gideon_id("countries", "United States")
#' outbreaks_us_2007 <- outbreaks_by_country_year(us_country_code, 2007)
#'
#' mosquito_vector_code <- lookup_gideon_id("vectors", "Mosquito")
#' horse_reservoir_code <- lookup_gideon_id("reservoirs", "Horse")
#' diseases_from_horses_via_mosquitos <- filter_diseases(
#'     vector = mosquito_vector_code,
#'     reservoir = horse_reservoir_code
#' )
#'
#' @docType package
#' @name gideon
#' @keywords internal
"_PACKAGE"
#> [1] "_PACKAGE"
