# Loading packages
library(tidyverse)
library(rvest)
#install.packages("xml2")
library(xml2)

# Read the saved restaurant pages
link_final_dennys = list.files(path = "data/dennys", full.names = TRUE)

# Extract information using these URLs
## must: latitude, longitude, address, phone number
latitude = c()
longitude = c()
street = c()
city = c()
state = c()
postal_code = c()
phone_number = c()
week = data.frame(matrix(data = NA, nrow = length(link_final_dennys), ncol = 7))

for (i in 1:length(link_final_dennys)){
  # Read the html and save
  web = read_html(link_final_dennys[i])
  
  # Latitude and longitude
  lat_long = web |>
    html_nodes("span.coordinates > meta") |>
    html_attr("content") |>
    unique()
  latitude = c(latitude, as.numeric(lat_long[1]))
  longitude = c(longitude, as.numeric(lat_long[2]))
  
  # Address
  ad1 = web |>
    html_nodes(".c-address-street-1") |>
    html_text()
  street = c(street, ad1)
  
  ad2 = web |>
    html_nodes(".c-address-city")|>
    html_text()
  city = c(city, ad2)
  
  ad3 = web |>
    html_nodes(".c-address-state")|>
    html_text()
  state = c(state, ad3)
  
  ad4 = web |>
    html_nodes(".c-address-postal-code") |>
    html_text()
  postal_code = c(postal_code, ad4)
  
  # Phone number
  pn = web |>
    html_nodes("#phone-main") |>
    html_text()
  phone_number = c(phone_number, pn)
  
  # Hours
  hour = web|>
    html_nodes("span.c-hours-today-day-hours-intervals-instance") |>
    html_text()
  if (length(hour) == 0) {
    hour = web |>
      html_nodes("div div div span.c-hours-today-day-status") |>
      html_text()
  }
  for (j in 1:7) {week[i, j] = str_trim(hour[j])}
}

# Change column names
colnames(week) = 
  c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

# Combine the information we extracted
dennys = cbind(latitude, longitude, street, 
               city, state, postal_code, phone_number, week)

# Save the data frame to data/
saveRDS(dennys, file = "data/dennys.rds")