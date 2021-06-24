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

#' GIDEON Item ID Lookup
#'
#' Looks up the ID for a disease, bacteria, etc. in the GIDEON database.
#'
#' @param category One of the following: diseases, drugs, vaccines, agents,
#'     vectors, vehicles, reservoirs, bacteria, mycobacteria, yeasts,
#'     countries, regions
#' @param item The name of the item
#' @param fail_silently Only return NULL instead of all options.
#'
#' @export
lookup_gideon_id <- function(category, item, fail_silently = TRUE) {
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

  matches <- dplyr::filter(gideon::query_gideon_api(api_path),
                           !!dplyr::sym(item_name) == item)

  if (nrow(matches)==1) {
    return(matches[[item_id]])
  }
  if (fail_silently) {
    return(NULL)
  }
  return(matches[1:2])
}
