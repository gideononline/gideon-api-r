#' Disease Outbreaks by Year
#'
#' @param year Numeric. 4 digit year.
#' @seealso \url{https://api-doc.gideononline.com/#038e2b12-0b61-4432-a642-7192a64f8a5c}
#' @return Returns a complete list of all outbreaks that occurred in a requested
#' year for every country.
#' @export
outbreaks_by_year <- function(year) {
  gideon::query_gideon_api('/diseases/outbreaks', list(year = year))
}

#' Disease Outbreaks by Country and Year
#'
#' @param country GIDEON country code
#' @param year Numeric. 4 digit year.
#' @seealso \url{https://api-doc.gideononline.com/#16616aab-57f9-477d-b611-892b7f19cd43}
#' @seealso \code{\link{lookup_gideon_id}}
#' @return Returns complete list of all outbreaks that were reported in a
#' requested country and year.
#' @export
outbreaks_by_country_year <- function(country, year) {
  gideon::query_gideon_api(paste('/diseases/outbreaks/distribution',
                                 country,
                                 sep = '/'),
                           list(year = year))
}

#' Latest Disease Outbreaks by Country
#'
#' @param country GIDEON country code
#' @seealso \url{https://api-doc.gideononline.com/#a331d79d-c265-48a3-a45a-dbca49c8d38d}
#' @seealso \code{\link{lookup_gideon_id}}
#' @return Returns information of latest outbreak of every disease for a
#' requested country.
#' @export
latest_outbreaks_by_country <- function(country) {
  gideon::query_gideon_api(paste('/diseases/countries',
                                 country,
                                 'latest-outbreaks',
                                 sep = '/'))
}

#' Countries with Given Disease Outbreaks
#'
#' @param disease GIDEON disease code
#' @seealso \url{https://api-doc.gideononline.com/#f1a87f41-a9a4-414a-b6f7-d15c1c8b9331}
#' @seealso \code{\link{lookup_gideon_id}}
#' @return Returns list of all countries that have reported outbreaks of a
#' disease.
#' @export
outbreaks_by_disease <- function(disease) {
  gideon::query_gideon_api(paste('/diseases',
                                 disease,
                                 'outbreaks',
                                 sep = '/'))
}

#' Endemic Countries of a Disease
#'
#' @param disease GIDEON disease code
#' @seealso \url{https://api-doc.gideononline.com/#20bc3345-8c15-4cc7-a6a3-24c8ac0ccf49}
#' @seealso \code{\link{lookup_gideon_id}}
#' @return Returns list of all endemic countries of a disease.
#' @export
endemic_countries_by_disease <- function(disease) {
  gideon::query_gideon_api(paste('/diseases',
                                 disease,
                                 'countries',
                                 sep = '/'))
}

#' Diseases Endemic to a Country
#'
#' @param country GIDEON country code
#' @seealso \url{https://api-doc.gideononline.com/#feab6f00-e926-49df-9a34-114cfafdf685}
#' @seealso \code{\link{lookup_gideon_id}}
#' @return Returns the list of all diseases that are endemic to the country.
#' @export
endemic_diseases_by_country <- function(country) {
  gideon::query_gideon_api(paste('/diseases/countries',
                                 country,
                                 sep = '/'))
}
