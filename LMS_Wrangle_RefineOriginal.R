# script to wrangle Sbringboard data wrangle project 1: refine.csv

# install and load dplyr and tidyr

install.packages("dplyr")
install.packages("tidyr")

library(dplyr)
library(tidyr)

# load refine_original.csv file into RStudio and review

refine_original <- read.csv("~refine_original.csv")

glimpse(refine_original)

# collect all spelling versions into their vectors

SP_philips <- c("Phillips", "phillips", "phllips", "phillps", "phillipS", "fillips", "phlips", "philips")
SP_akzo <- c("Akzo", "AKZO", "akz0", "ak zo", "akzo")
SP_van_houten <- c("Van Houten", "van Houten", "van houten")
SP_unilever <- c("unilver", "unilever", "Unilever", "unilever")

# step 1: clean up brand names - clean 'company' column to have consistent brand names:
# philips, akzo, van houten and unilever (all lower case)

refine_original$company[refine_original$company %in% SP_philips] <- "philips"
refine_original$company[refine_original$company %in% SP_akzo] <- "akzo"
refine_original$company[refine_original$company %in% SP_van_houten] <- "van houten"
refine_original$company[refine_original$company %in% SP_unilever] <- "unilever"

glimpse(refine_original)

# step 2: seperate refine_original$Product.code...number into 'product_code' and 'product_number'

refine_original <- refine_original %>% 
  separate(col = Product.code...number,into = c("product_code", "product_number"), sep = "-")

# step 3: add a column with the 'product_category' for each record, where:
#         p = Smartphone, v = TV, x = Laptop, q = Tablet

ProdCatFunc <- function(x) {
  ifelse(x == "p", "Smartphone",
         ifelse(x == "v", "TV",
                ifelse(x == "x", "Laptop",
                       ifelse(x == "q", "Tablet", NA))))
}

refine_original <- refine_original %>% mutate(product_category = ProdCatFunc(product_code))

# step 4: condense the 3 address columns 'address', 'city' and 'country' into one new column
#         called 'full_address'

refine_original <- refine_original %>% unite(full_address, address:country, sep = ",", remove = FALSE)

# step 5: create dummy variables for company and product categories using the prefixes 'company_'
#         and 'product_'

# 'company_'
refine_original <- refine_original %>%
  mutate(company_philips = ifelse(company == "philips", 1, 0)) %>%
  mutate(company_akzo = ifelse(company == "akzo", 1, 0)) %>%
  mutate(company_van_houten = ifelse(company == "van houten", 1, 0)) %>%
  mutate(company_unilever = ifelse(company == "unilever", 1, 0))

# 'product_'
refine_original <- refine_original %>%
  mutate(product_smartphone = ifelse(product_category == "Smartphone", 1, 0)) %>%
  mutate(product_tv = ifelse(product_category == "TV", 1, 0)) %>%
  mutate(product_laptop = ifelse(product_category == "Laptop", 1, 0)) %>%
  mutate(product_tablet = ifelse(product_category == "Tablet", 1, 0))

glimpse(refine_original)

# generate new file called 'refine_clean'

refine_clean <- refine_original

write.csv(refine_clean, file = "refine_clean.csv")
