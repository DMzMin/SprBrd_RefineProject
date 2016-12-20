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

companysub <-  gsub(SP_philips, "philips", refine_original$company) +
  gsub(SP_akzo, "akzo", refine_original$company) +
  gsub(SP_van_houten, "van houten", refine_original$company) +
  gsub(SP_unilever, "unilever", refine_original$company)

companysub
