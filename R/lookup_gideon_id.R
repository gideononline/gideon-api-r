gideon_category_path_id_name <- list(
  diseases = c('/diseases', 'disease_code', 'disease'),
  drugs = c('/drugs', 'drug_code', 'drug'),
  vaccines = c('/vaccines', 'vaccine_code', 'vaccine'),
  agents = c('/diseases/fingerprint/agents', 'agent_code', 'agent'),
  vectors = c('/diseases/fingerprint/vectors', 'vector_code', 'vector'),
  vehicles = c('/diseases/fingerprint/vehicles', 'vehicle_code', 'vehicle'),
  reservoirs = c('/diseases/fingerprint/reservoirs', 'reservoir_code', 'reservoir'),
  bacteria = c('/microbiology/bacteria', 'bacteria_code', 'bacteria'),
  mycobacteria = c('/microbiology/mycobacteria', 'mycobacteria_code', 'mycobacteria'),
  yeasts = c('/microbiology/yeasts', 'yeast_code', 'yeast'),
  countries = c('/countries', 'country_code', 'country'),
  regions = c('/travel/regions', 'region_code', 'region')
)

#' GIDEON Item Identification Code Lookup
#'
#' Finds the ID for a disease, bacteria, etc. in the GIDEON database.
#' HINT: Copy and paste the item name from the GIDEON dashboard.
#'
#' @param category A string that is one of the following categories: diseases,
#'     drugs, vaccines, agents, vectors, vehicles, reservoirs, bacteria,
#'     mycobacteria, yeasts, countries, regions
#' @param item A string of the name of the item to search. If this parameter is
#'     omitted, the function will return a dataframe representing all items and
#'     related GIDEON identification codes.
#' @param error_msg Throw an error message if the lookup does not find the
#'     specified item rather than returning \code{NULL}.
#'
#' @return
#' \itemize{
#'  \item If the \emph{item parameter matches} an entry from the item category,
#'      the string or integer code will be returned.
#'  \item If the \emph{item parameter fails to match} an entry from the item
#'      category, \code{NULL} will be returned.
#'  \item If the \emph{item parameter is omitted}, return a dataframe with all
#'      items in the category, including the name and code.
#' }
#'
#'
#'
#' @examples
#' \donttest{
#' # Find the disease code given the name.
#' ebola_code <- lookup_gideon_id("diseases", "Ebola")
#'
#' # Find a country code given the country name
#' us_code <- lookup_gideon_id("countries", "United States")
#'
#' # List all the disease vectors
#' all_vectors <- lookup_gideon_id("vectors")
#' }
#'
#' @export
lookup_gideon_id <- function(category, item = NULL, error_msg = TRUE) {
  # Ensure the category is from the list
  if (!is.element(category, names(gideon_category_path_id_name))) {
    stop(paste('Category "',
               category,
               '" is not one of: ',
               paste(names(gideon_category_path_id_name), collapse = ', '),
               sep = ''))
  }

  api_path <- gideon_category_path_id_name[[category]][1]
  item_id <- gideon_category_path_id_name[[category]][2]
  item_name <- gideon_category_path_id_name[[category]][3]

  full_item_list <- gideon::query_gideon_api(api_path)

  if (is.null(item)) {
    return(full_item_list[1:2])
  }

  matches <- dplyr::filter(full_item_list, !!dplyr::sym(item_name) == item)

  if (nrow(matches)==1) {
    return(matches[[item_id]])
  }
  if (error_msg) {
    stop(paste("GIDEON item ID code lookup could not find any matches for ",
               "'",
               item,
               "'",
               " in the ",
               "'",
               category,
               "'",
               " category",
               sep = ""))
  }

}
