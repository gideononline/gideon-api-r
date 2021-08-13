#' Dataframe export as GeoJSON
#'
#' Exports a dataframe to GeoJSON where latitude/longitude data is available
#' @param dataframe An input dataframe to convert
#' @param filename The exported filename, relative to the current working
#'      directory
#' @param overwrite_layer Indicates if an existing file in the current directory
#'      should be overwritten by the new file
#' @param lat The name of the column with latitude data
#' @param lon The name of the column with longitude data
#' @export
to_geojson <- function(dataframe, filename, overwrite_layer = FALSE,
                       lat='latitude', lon='longitude') {
  df_cols <- colnames(dataframe)
  if (lat %in% df_cols & lon %in% df_cols) {
    # Create a copy
    df <- data.frame(dataframe)
    # Filter out columns where lat/lon data is not avalible
    df <- dplyr::filter(df,
                        !is.na(!!dplyr::sym(lat)) & !is.na(!!dplyr::sym(lon)))
    # Convert the lat/lon columns to floats
    df[lat] <- lapply(df[lat], as.numeric)
    df[lon] <- lapply(df[lon], as.numeric)

    # Convert filtered dataframe to SpatialPointsDataFrame and export
    rgdal::writeOGR(sp::SpatialPointsDataFrame(df[,c(lon,lat)],
                                               dplyr::select(df,-c(lon,lat))),
                    filename, 'gideon-export', 'GeoJSON',
                    overwrite_layer = overwrite_layer)
  } else {
    stop(paste('Columns "', lat, '" and/or "', lon, '" not found', sep = ""))
  }
}
