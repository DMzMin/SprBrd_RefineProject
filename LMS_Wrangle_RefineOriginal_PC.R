# script to wrangle Sbringboard data wrangle project 1: refine.csv

# install and load dplyr and tidyr

install.packages("dplyr")
install.packages("tidyr")

library(dplyr)
library(tidyr)

# load refine_original.csv file into RStudio and review

refine_original <- read.csv("~/Desktop/CAPSTONE/refine_original.csv")

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

# step 2: seperate refine_original$Product.code...number into 'product_code' 
# and'product_number'

refine_original <- refine_original %>% 
  separate(col = 'Product code / number',into = c("product_code", "product_number"), sep = "-")

# step 3: add a column with the 'product_category' for each record, where:
#         p = Smartphone, v = TV, x = Laptop, q = Tablet

product_category <- lapply(refine_original$product_code, p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")

refine_original$product_code[refine_original$product_code %in% "p"] <- "smartphone"

prod_cat_list <- c(p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")

product_category <- refine_original$product_code[p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet"]
  
  #refine_original %>% mutate(product_category = ifelse(product_code = "p")

