#' GIDEON API Query
#'
#' Wrapper to the GIDEON API
#' @param path The API path according to the API documentation
#' @param query Additional URL query parameters to send as a named list
#' @param to_dataframe Automatically convert the response to a dataframe.
#'
#' @returns
#' A dataframe representing the response or a string of the JSON response if
#' \code{to_dataframe} is set to \code{FALSE}
#'
#' @examples
#' # Most calls only need the path
#' query_gideon_api("/diseases/10050/incubation-periods")
#'
#' # Some calls can include a named list to be used as query parameters
#' query_gideon_api("/diseases/filter",
#'                  list(agent=1014,
#'                       vector="T",
#'                       vehicle="MI",
#'                       reservoir="A",
#'                       country="G100"))
#'
#' @seealso \url{https://api-doc.gideononline.com/}
#'
#' @export
query_gideon_api <- function(path, query = NULL, to_dataframe = TRUE){
  user_api_key <- Sys.getenv('GIDEON_API_KEY')
  if (user_api_key == "") {
    stop(paste("Cannot find GIDEON_API_KEY environment variable.",
               "Set the GIDEON_API_KEY variable in your .Renviron file"))
  }

  r <- httr::GET(
    paste('https://api.gideononline.com', path, sep = ''),
    query = query,
    httr::add_headers(Authorization = paste('api_key', user_api_key))
  )

  resp_status_code <- httr::status_code(r)
  if (resp_status_code == 200) {
    if (to_dataframe) {
      return(jsonlite::fromJSON(httr::content(r, 'text'))$data)
    }
    return(httr::content(r, 'text'))
  }
  if (resp_status_code == 401) {
    stop(paste("The GIDEON_API_KEY environment variable provided is not a",
               "valid GIDEON API key"))
  }
  if (resp_status_code == 404) {
    stop(paste("'", path, "'", " is not a valid GIDEON API path", sep = ""))
  }

  stop(paste("GIDEON API query returned a",
             resp_status_code,
             "HTTP status code"))
}
