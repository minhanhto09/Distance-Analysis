# Distance-Analysis

In this project, we are tasked with gathering and processing data from [La Quinta hotels](http://www2.stat.duke.edu/~cr173/data/lq/www.wyndhamhotels.com/laquinta/locations.html) and [Denny's restaurants](http://www2.stat.duke.edu/~cr173/data/dennys/locations.dennys.com/index.html). Here's what each file does:

`get_lq.R`: This script is responsible for retrieving data from the La Quinta website. It might fetch either summarized information about La Quinta hotels or individual pages for each hotel. Once the data is fetched, it is stored locally in the data/lq/ directory. If these directories do not exist, the script creates them to ensure proper organization of the downloaded data.

`parse_lq.R`: After the data is collected and stored in data/lq/ by get_lq.R, this script takes over the task of processing it. It reads the saved files, parses the information, and organizes it into a structured format, typically a data frame or tibble. Each row of this structured data represents a hotel, while the columns contain various characteristics such as latitude, longitude, state, and amenities. Finally, this processed data is saved as lq.rds in the data/ directory for future analysis.

`get_dennys.R`: Similar to get_lq.R, this script is responsible for fetching data, but this time from Denny's restaurant pages. It downloads information from individual restaurant pages, gathering details about each location. The results are stored in the data/dennys/ directory. Like before, if these directories do not exist, the script creates them to maintain organization.

`parse_dennys.R`: Once the Denny's data is collected and stored in data/dennys/, this script swings into action. It reads the saved files, processes the information, and structures it into a usable format, likely a data frame or tibble. Each row of this structured data represents a restaurant, with columns containing relevant restaurant characteristics. The processed data is then saved as dennys.rds in the data/ directory for further analysis.

`Description.qmd`: This document serves as a comprehensive guide to our data acquisition and processing methodology. It details how we obtained the data and the steps taken to clean and organize it. Additionally, it includes our distance analysis, which examines spatial relationships between La Quinta hotels and Denny's restaurants. Importantly, this analysis exclusively utilizes data from data/lq.rds and data/dennys.rds, ensuring consistency and accuracy.

`Makefile`: Acting as the conductor of our project orchestra, the Makefile specifies the dependencies between our script files and their respective outputs. It ensures that each script is executed in the correct sequence and that any changes to input files trigger the appropriate updates downstream. In essence, the Makefile streamlines our data pipeline, facilitating efficient and reproducible data processing.
