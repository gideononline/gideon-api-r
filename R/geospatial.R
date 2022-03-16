row_to_feature_object <- function(df, i, col_names,
                                  lat = "latitude", lon = "longitude") {
  # Produce GeoJSON Geomerty Object as a Point
  geometry = list(
    type = jsonlite::unbox("Point"),
    coordinates = c(as.numeric(df[i, lon]), as.numeric(df[i, lat]))
  )
  # Properties without latitude and longitude as list
  # Elements wrapped in unbox for toJSON to produce desired format
  properties = as.list(df[i, !colnames(df) %in% c(lat, lon)])
  for (i in 1:length(properties)) {
    properties[[i]] = jsonlite::unbox(properties[[i]])
  }
  return(list(type = jsonlite::unbox("Feature"),
              geometry = geometry,
              properties = as.list(properties)))
}

#' Dataframe export as GeoJSON
#'
#' Exports a dataframe to a GeoJSON file where latitude/longitude data is
#' available.
#' @param dataframe An input dataframe to convert
#' @param filename The exported filename, relative to the current working
#'      directory. If the file already exists and overwrite is not set to TRUE,
#'      an error will be thrown
#' @param overwrite Indicates if an existing file in the current directory
#'      should be overwritten by the new file. Defaults to FALSE.
#' @param pretty Indicates if file is formatted with whitespace as newlines,
#'      indentations and spaces to make the JSON data more readable.
#'      Defaults to FALSE.
#' @param lat The name of the column with latitude data. Defaults to "latitude".
#' @param lon The name of the column with longitude data. Defaults to "longitude".
#' @export
to_geojson <- function(dataframe, filename, overwrite = FALSE, pretty = FALSE,
                       lat='latitude', lon='longitude') {
  # Check if it is okay to write the file first
  if (!overwrite & file.exists(filename)) {
    stop(paste('The file "', filename, '" already exists and overwrite is set to FALSE', sep = ""))
  }
  df_cols <- colnames(dataframe)
  if (!(lat %in% df_cols & lon %in% df_cols)) {
    stop(paste('Columns "', lat, '" and/or "', lon, '" not found', sep = ""))
  }
  rows <- c()
  for(i in 1:nrow(dataframe)) {
    if (is.na(dataframe[i, lat]) | is.na(dataframe[i, lon])) {next}
    rows <- append(rows, list(row_to_feature_object(dataframe, i, df_cols)))
  }
  geojson = jsonlite::toJSON(list(type=jsonlite::unbox("FeatureCollection"),
                                  features=rows),
                             pretty = pretty)
  write(geojson, filename)
}
