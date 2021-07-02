#' Filter diseases from GIDEON database
#'
#' @param agent GIDEON agent code - Classification (e.g., virus, parasite) and
#'  taxonomic designation.
#' @param vector GIDEON vector code - An arthropod or other living carrier which
#'  transports an infectious agent from an infected organism or reservoir to a
#'  susceptible individual or immediate surroundings.
#' @param vehicle GIDEON vehicle code - The mode of transmission for an
#'  infectious agent. This generally implies a passive and inanimate
#'  (i.e., non-vector) mode.
#' @param reservoir GIDEON reservoir code - Any animal, arthropod, plant, soil
#'  or substance in which an infectious agent normally lives and multiplies, on
#'  which it depends primarily for survival, and where it reproduces itself in
#'  such a manner that it can be transmitted to a susceptible host.
#' @param country GIDEON country code - In general, this list of country names
#'  corresponds to accepted geographical and political designations. When
#'  Country filter is used, it will only retrieve diseases that are endemic to
#'  the country.
#' @seealso \url{https://api-doc.gideononline.com/#4272d285-ba04-435d-b7ad-deabe971330e}
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @examples
#' # The The user can specify none to all of the parameters
#' filter_diseases()
#'
#' physical_contact_vehicle_code <- lookup_gideon_id("vehicles",
#'                                                   "Direct physical contact")
#' filter_diseases(vehicle = physical_contact_vehicle_code)
#'
#' mosquito_vector_code <- lookup_gideon_id("vectors", "Mosquito")
#' us_country_code <- lookup_gideon_id("countries", "United States")
#' filter_diseases(vector = mosquito_vector_code, country = us_country_code)
#'
#' @export
filter_diseases <- function(agent = NULL, vector = NULL, vehicle = NULL,
                            reservoir = NULL, country = NULL) {
  gideon::query_gideon_api('/diseases/filter',
                           Filter(Negate(is.null),
                                  list(agent=agent,
                                       vector=vector,
                                       vehicle=vehicle,
                                       reservoir=reservoir,
                                       country=country)))[1:2]
}
