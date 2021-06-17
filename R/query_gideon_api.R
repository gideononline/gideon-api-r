#' Queries the GIDEON Informatics API
#'
#' @param path The API path according to the API documentation
#' @param query Additional URL query parameters to send as a named list
#' @param to_dataframe Automatically convert the response to a dataframe.
#'
#' @export
query_gideon_api <- function(path, query = NULL, to_dataframe = TRUE){
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
