
# Libraries ---------------------------------------------------------------
library(tidyverse)


#Summary of data

data <- read.csv('raw_data/data_extraction_OR_7FEB24.csv')

data <- janitor::clean_names(data)

colnames(data)

subset <- data %>% 
            filter(include == "Y") %>% 
            select(acc_num:time_since_restoration) # remove notes & variables to work with de-duplicated dataset

dup <- distinct(subset)  # remove duplicates    
write.csv(dup, "output/duplicates.csv")



