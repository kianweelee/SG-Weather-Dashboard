shinyServer(function(input, output) {
    # Gather data from API
    res <- GET(paste("https://api.data.gov.sg/v1/environment/air-temperature?date=",Sys.Date(),sep = ""))
    data <- fromJSON(rawToChar(res$content))
})