# script to wrangle Sbringboard data wrangle project 1: refine.csv

# install and load dplyr and tidyr

install.packages("dplyr")
install.packages("tidyr")

library(dplyr)
library(tidyr)

# load refine_original.csv file into RStudio and review

refine_original <- read.csv("~/Desktop/CAPSTONE/refine_original.csv")

glimpse(refine_original)

# step 1: clean up brand names - clean 'company' column to have consistent brand names:
# philips, akzo, van houten and unilever (all lower case)

refine_company <- refine_original %>% 
  mutate(company_name = ifelse(company = "Phillips" | company = "phillips" | company = "philips" | company = "phllips" | company = "phillps" | company = "phillipS", "philips",
        ifelse(company = "akzo" | company = "Akzo" | company = "AKZO" | company = "akz0" | company = "ak zo", company = "akzo", 
               ifelse(company = "Van Houten" | company = "van Houten" | company = "van houten", company = "van houten",
                      ifelse(company = "unilver" | "unilever" | "Unilever", "uniliver", NA))))) 