# Singapore Weather Dashboard

## In this series, we will cover:
1. Data manipulation

### Step 1: Cleaning the timestamps - Removing characters we will not need
Here, we use ```substr``` to remove the last 6 characters in timestamp
```R
data$items$timestamp <- substr(data$items$timestamp,1,nchar(data$items$timestamp)-6)
```

### Step 2: Remove 'T' in timestamp
Here, we convert T to whitespace using gsub.
```R
data$items$timestamp <- gsub("T"," ",data$items$timestamp)
```

### Step 3: Convert index in list to timestamp for better identification
This can be easily achieved using ```setNames```
```R
data_list <- setNames(data$items$readings, data$items$timestamp)
```

### Step 4: Convert list to dataframe
Our end goal is to get a dataframe that we can put into ggplot
```R
final_data <- do.call(rbind, data_list)
final_data <- as.data.frame(final_data)
```

### Step 5: Convert index to a column name - DATETIME
```R
final_data$DATETIME <- rownames(final_data)
```

### Step 6: Remove row name
```R
rownames(final_data) <- NULL
```

### Step 7: Clean up timestamp and convert data type to timestamp
```R
final_data$DATETIME <- gsub("\\..*","",final_data$DATETIME)
final_data$DATETIME <- as.POSIXct(final_data$DATETIME)
```

### Step 8: Select the columns we need and left join to the final data
```R
    station_data <- data$metadata$stations %>%
        select(id,name)
    # Link station data to final_data
    final_weather_data <- final_data %>%
        left_join(station_data, by = c('station_id'='id')) %>%
        select(DATETIME,name,value)
```
