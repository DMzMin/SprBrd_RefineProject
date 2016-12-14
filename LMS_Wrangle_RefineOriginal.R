# script to wrangle Sbringboard data wrangle project 1: refine.csv

# install and load dplyr and tidyr

install.packages("dplyr")
install.packages("tidyr")

library(dplyr)
library(tidyr)

# load refine_original.csv file into RStudio and review

refine_original <- read.csv("~/Desktop/CAPSTONE/refine_original.csv")

glimpse(refine_original)
# after glimpsing refine_original data frame it is noted that all columns are currently classed as factors and must be converted to characters

refine_charconvert <- data.frame(lapply(refine_original, as.character), stringsAsFactors = FALSE)

# step 1: clean up brand names - clean 'company' column to have consistent brand names:
# philips, akzo, van houten and unilever (all lower case)

refine_company <- as.data.frame(refine_charconvert %>%
  gsub("Phillips", "philips") & gsub("phillips", "philips")
)

refine_company <- refine_charconvert %>% 
  mutate(
    company = ifelse(company = "Phillips" | company = "phillips" | company = "philips" | company = "phllips" | company = "phillps" | company = "phillipS", "philips", 
        ifelse(company = "akzo" | company = "Akzo" | company = "AKZO" | company = "akz0" | company = "ak zo", company = "akzo", 
               ifelse(company = "Van Houten" | company = "van Houten" | company = "van houten", company = "van houten",
                      ifelse(company = "unilver" | company = "unilever" | company = "Unilever", company = "uniliver", NA)))))




#refine_company <- refine_charconvert %>% 
 # mutate(company = ifelse(company == "Phillips", "philips", "NOT Philips"))

#refine_company <- mutate(refine_charconvert$company, company_name = ifelse(company = "Phillips", "philips", "testing_NON"))

#refine_charconvert <- refine_charconvert %>%
 # sub("Phillips","phillips")
      
  #    || "phillips" || "phllips" || "phillipS", "phillips", fixed = TRUE)
