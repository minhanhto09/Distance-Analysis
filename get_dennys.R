# Loading packages
library(tidyverse)
library(rvest)

# Create the directory
dir.create("data/dennys", showWarning = FALSE, recursive = TRUE)

# Initial URL
url = "http://www2.stat.duke.edu/~cr173/data/dennys/locations.dennys.com/index.html"
url_0 = "http://www2.stat.duke.edu/~cr173/data/dennys/locations.dennys.com/"
polite::bow('http://www2.stat.duke.edu/~cr173/data/dennys/locations.dennys.com/index.html')

# Set up
link_more = url # what we start with
link_final = c() # final links
link_continue = c() # save the links that needs to be continuously scraped
n = 0 # denotes which layer we are at

# Obtain the URLs for all Denny's location
## Check if the URL ends with number, which means it has reached the last layer
while(all(grepl("\\d+$", gsub(".html$", "", link_more))) == F) {
  n = n + 1
  for (j in 1:length(link_more)){
    if (grepl("\\d+$", gsub(".html$", "", link_more[j]))) {
      link_final = c(link_final, link_more[j])
    } else {
      web = read_html(link_more[j])
      href_more = web |>
        html_elements("section div ul li a") |>
        html_attr("href")
      if (n < 3 & str_ends(link_more[j], "WASHINGTON.html") == F) {
        link_continue = c(link_continue, paste0(url_0, href_more))
      } else {
        state = web |>
          html_elements(".c-bread-crumbs-item+ .c-bread-crumbs-item a .c-bread-crumbs-name")|>
          html_text()
        link_continue = c(link_continue, paste0(url_0, state[1], "/", href_more))
      }
    }
  }
  link_more = link_continue
  link_continue = c()
}

link_final_dennys = c(link_final, link_more)

# Save the pages
for (i in seq_along(link_final_dennys)) {
  file = file.path("data/dennys", paste0(i, ".html"))
  download.file(link_final_dennys[i], file, quiet = TRUE)
}