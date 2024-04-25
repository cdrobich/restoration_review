
# Libraries ---------------------------------------------------------------
library(tidyverse)

#Summary of data

data <- read.csv('raw_data/data-extraction-KG-24April2024_cleanup.csv')

data <- janitor::clean_names(data)

colnames(data)

subset <- data %>% 
            filter(include == "Y") %>% 
            select(acc_num:time_since_restoration) # remove notes & variables to work with de-duplicated dataset

dup <- distinct(subset)  # remove duplicates   

write.csv(dup, "output/duplicates.csv")

# highlight them in excel and correct the mistakes in Open Refine so there is a recorded script


