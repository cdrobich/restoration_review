
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
# see 'OpenRefine_script_24April2024" in "data"

data_cleaned <- read.csv('data/data_24April2024_openRefine.csv')
str(data_cleaned)

data_cleaned <- data_cleaned %>% select(ACC_NUM:Other)
data_cleaned <- janitor::clean_names(data_cleaned)         

data_includes <- data_cleaned %>% filter(include == 'Y')
write.csv(data_includes,'data/includes_cleanedup_24APR2024.csv', row.names = FALSE)


# Measured Outcome Variables ----------------------------------------------
data_includes <- read.csv('data/includes_cleanedup_24APR2024.csv')

write.csv(data_includes %>% count(measured_outcome), 'data/measure_in_outcomes.csv') 
outcomes <- data_includes %>% count(measured_outcome)

colnames(data_includes)

outcomes_fig <- ggplot(outcomes, aes(x = reorder(measured_outcome, +n), y = n)) +
            geom_col() +
            coord_flip()


outcomes_abiotic <- data_includes %>% 
            filter(measured_outcome == 'Abiotic') %>% 
            pivot_longer(cols = multivariate_community_composition:hydrology,
                         names_to = "method",
                         values_to = "count") %>% 
            select(method:count) %>% 
            group_by(method) %>% 
            summarize(Sum = sum(count))

outcomes_abiotic 
