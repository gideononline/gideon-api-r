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
#' # Find the disease code given the name.
#' ebola_code <- lookup_gideon_id("diseases", "Ebola")
#'
#' # Find a country code given the country name
#' us_code <- lookup_gideon_id("countries", "United States")
#'
#' # List all the disease vectors
#' all_vectors <- lookup_gideon_id("vectors")
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

#' GIDEON Disease Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("diseases", disease)}
#'
#' @param disease Name of disease
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_disease_id <- function(disease) {
  lookup_gideon_id("diseases", disease)
}

#' GIDEON Drug Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("drugs", drug)}
#'
#' @param drug Name of drug
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_drug_id <- function(drug) {
  lookup_gideon_id("drugs", drug)
}

#' GIDEON Vaccine Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("vaccines", vaccine)}
#'
#' @param vaccine Name of vaccine
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_vaccine_id <- function(vaccine) {
  lookup_gideon_id("vaccines", vaccine)
}

#' GIDEON Agent Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("agents", agent)}
#'
#' @param agent Name of agent
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_agent_id <- function(agent) {
  lookup_gideon_id("agents", agent)
}

#' GIDEON Vector Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("vectors", vector)}
#'
#' @param vector Name of vector
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_vector_id <- function(vector) {
  lookup_gideon_id("vectors", vector)
}

#' GIDEON Vehicle Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("vehicles", vehicle)}
#'
#' @param vehicle Name of vehicle
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_vehicle_id <- function(vehicle) {
  lookup_gideon_id("vehicles", vehicle)
}

#' GIDEON Reservoir Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("reservoirs", reservoir)}
#'
#' @param reservoir Name of reservoir
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_reservoir_id <- function(reservoir) {
  lookup_gideon_id("reservoirs", reservoir)
}

#' GIDEON Bacteria Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("bacteria", bacteria)}
#'
#' @param bacteria Name of bacteria
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_bacteria_id <- function(bacteria) {
  lookup_gideon_id("bacteria", bacteria)
}

#' GIDEON Mycobacteria Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("mycobacteria", mycobacteria)}
#'
#' @param mycobacteria Name of mycobacteria
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_mycobacteria_id <- function(mycobacteria) {
  lookup_gideon_id("mycobacteria", mycobacteria)
}

#' GIDEON Yeast Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("yeasts", yeast)}
#'
#' @param yeast Name of yeast
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_yeast_id <- function(yeast) {
  lookup_gideon_id("yeasts", yeast)
}

#' GIDEON Country Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("countries", country)}
#'
#' @param country Name of country
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_country_id <- function(country) {
  lookup_gideon_id("countries", country)
}

#' GIDEON Region Code Lookup
#'
#' Shortcut for \code{lookup_gideon_id("regions", region)}
#'
#' @param region Name of region
#'
#' @seealso \code{\link{lookup_gideon_id}}
#'
#' @export
lookup_region_id <- function(region) {
  lookup_gideon_id("regions", region)
}
