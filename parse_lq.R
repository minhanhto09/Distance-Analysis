# Loading packages
library(tidyverse)
library(rvest)
library(jsonlite)

# Read the saved restaurant pages
link_final_lq = list.files(path = "data/lq", full.names = TRUE)

# Extract information using these URLs
## must: latitude, longitude, address and phone number
name = c()
latitude = c()
longitude = c()
street = c()
city = c()
state = c()
postal_code = c()
phone_number = c()

for (i in 1:length(link_final_lq)){
  # Read the html and save
  web = read_html(link_final_lq[i])
  
  # Extract the JSON file
  parsed_json = web |>
    html_nodes(xpath = "//script[@type = 'application/ld+json']") |>
    html_text2() |>
    fromJSON()
  
  # Name
  name = c(name, parsed_json$name)
  # Latitude and longitude
  latitude = c(latitude, parsed_json$geo$latitude)
  longitude = c(longitude, parsed_json$geo$longitude)
  # Address
  street = c(street, parsed_json$address$streetAddress)
  city = c(city, parsed_json$address$addressLocality)
  state = c(state, parsed_json$address$addressRegion)
  postal_code = c(postal_code, parsed_json$address$postalCode)
  # Phone number
  phone_number = c(phone_number, parsed_json$telephone)
}

# Combine the information we extracted
lq = data.frame(name, latitude, longitude, street, city, 
                state, postal_code, phone_number)

# Save the data frame to data/
saveRDS(lq, file = "data/lq.rds")