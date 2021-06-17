# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


query_gideon_api <- function(path, query = NULL, to_dataframe = TRUE){
  #' Queries the GIDEON Informatics API
  #'
  #' @param path The API path according to the API documentation
  #' @param to_dataframe Automatically convert the response to a dataframe.
  r <- httr::GET(
    paste('https://api.gideononline.com', path, sep = ''),
    query = query,
    httr::add_headers(Authorization = paste('api_key',
                                            Sys.getenv('GIDEON_API_KEY')))
  )
  if (httr::status_code(r)==200){
    if (to_dataframe) {
      return(jsonlite::fromJSON(httr::content(r, 'text'))$data)
    }
    return(httr::content(r, 'text'))
  }
}

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


lookup_gideon_id <- function(category, item) {
  #' Finds the GIDEON specific ID for a disease, vaccine, etc.
  #'
  #' @param category One of the following: diseases, drugs, vaccines, agents,
  #'     vectors, vehicles, reservoirs, bacteria, mycobacteria, yeasts,
  #'     countries, regions
  #' @param item The name of the item
  if (is.element(category, names(gideon_category_path_id_name))) {
    api_path <- gideon_category_path_id_name[[category]][1]
    item_id <- gideon_category_path_id_name[[category]][2]
    item_name <- gideon_category_path_id_name[[category]][3]

    matches <- dplyr::filter(query_gideon_api(api_path),
                             !!dplyr::sym(item_name) == item)

    if (nrow(matches)==1) {
      return(matches[[item_id]])
    }
    return(matches[1:2])
  }
}
