#' Filter diseases from GIDEON database
#' @seealso \code{\link{lookup_gideon_id}}
#' @export
filter_diseases <- function(agent = NULL, vector = NULL, vehicle = NULL,
                            reservoir = NULL, country = NULL) {

  return(
    gideon::query_gideon_api(
      '/diseases/filter',
      Filter(Negate(is.null), list(agent=agent,
                                   vector=vector,
                                   vehicle=vehicle,
                                   reservoir=reservoir,
                                   country=country))
      )[1:2]
  )
}
