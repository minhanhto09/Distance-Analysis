# Loading packages
library(tidyverse)
library(rvest)
library(datasets)
library(stringr)

# Create the directory

dir.create("data/lq", showWarning = FALSE, recursive = TRUE)


# Initial URL
url_lq = "http://www2.stat.duke.edu/~cr173/data/lq/www.wyndhamhotels.com/laquinta/locations.html"
url_lq_0 = "http://www2.stat.duke.edu/~cr173/data/lq/www.wyndhamhotels.com/laquinta/"
polite::bow('http://www2.stat.duke.edu/~cr173/data/lq/www.wyndhamhotels.com/laquinta/locations.html')

# Extract all the overview pages of hotels
link_all_lq = read_html(url_lq) |>
  html_nodes(".property a:nth-child(1)") |>
  html_attr("href") 

link_all_lq = paste0(url_lq_0, link_all_lq)

# USA states names
state.usa = gsub(" ", "-", state.name)
state_pattern = paste(tolower(state.usa), collapse = "|")

# Keep only the hotels in the United States
link_final_lq = link_all_lq[grep(pattern = state_pattern, x = link_all_lq)]

# Save the pages
for (i in seq_along(link_final_lq)) {
  file = file.path("data/lq", paste0(i, ".html"))
  download.file(link_final_lq[i], file, quiet = TRUE, mode = "wb")
}