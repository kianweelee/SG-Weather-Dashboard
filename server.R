shinyServer(function(input, output) {
    # Gather data from API
    res <- GET(paste("https://api.data.gov.sg/v1/environment/air-temperature?date=",
                     Sys.Date(),sep = ""))
    data <- fromJSON(rawToChar(res$content))
    
    # Convert data to a dataframe
    ## Clean the timestamp
    ### Remove the last 6 character (i.e +08:00)
    data$items$timestamp <- substr(data$items$timestamp,1,nchar(data$items$timestamp)-6)
    ### Convert T to whitespace
    data$items$timestamp <- gsub("T"," ",data$items$timestamp)
    ## Set name for index
    data_list <- setNames(data$items$readings, data$items$timestamp)
    ## Convert list to dataframe
    final_data <- do.call(rbind, data_list)
    final_data <- as.data.frame(final_data)
    ## Convert index to row name 
    final_data$DATETIME <- rownames(final_data)
    ## Remove row name
    rownames(final_data) <- NULL
    ## Clean up the timestamp
    final_data$DATETIME <- gsub("\\..*","",final_data$DATETIME)
    ## Convert timestamp from char to datetime
    final_data$DATETIME <- as.POSIXct(final_data$DATETIME)
    
    # Choose required columns in metadata-station
    station_data <- data$metadata$stations %>%
        select(id,name)
    # Link station data to final_data
    final_weather_data <- final_data %>%
        left_join(station_data, by = c('station_id'='id')) %>%
        select(DATETIME,name,value)
})