# Title: 606 Mortality Calculator Project

# Purpose: 
# - load the raw data
# - export to processed .rds files


# Packages & Sources ----------------------------------------------
library(tidyverse)

# CODE ------------------------------------------------------------
# Import files
col_types <- strrep("n", times = 43)

nlms11 <-read_csv('data/raw/NLMS_PublicUse_5.1_20210416/11_new.csv',
                  na=c(".", "", "000", "2192"),
                  col_types=col_types,
                  show_col_types = FALSE)
saveRDS(nlms11,
        "data/processed/nlms11.rds")

nlms6a <-read_csv('data/raw/NLMS_PublicUse_5.1_20210416/6a_new.csv',
                  na=c(".", "", "000", "2192"),
                  col_types=col_types,
                  show_col_types = FALSE)
saveRDS(nlms6a,
        "data/processed/nlms6a.rds")

nlms6b <-read_csv('data/raw/NLMS_PublicUse_5.1_20210416/6b_new.csv',
                  na=c(".", "", "000", "2192"), 
                  col_types=col_types,
                  show_col_types = FALSE)
saveRDS(nlms6b,
        "data/processed/nlms6b.rds")

nlms6c <-read_csv('data/raw/NLMS_PublicUse_5.1_20210416/6c_new.csv',
                  na=c(".", "", "000", "2192"), 
                  col_types=col_types,
                  show_col_types = FALSE)
saveRDS(nlms6c,
        "data/processed/nlms6c.rds")

nlms_tu <-read_csv('data/raw/NLMS_PublicUse_5.1_20210416/tu_new.csv',
                  na=c(".", "", "000", "2192"),
                  col_types=col_types,
                  show_col_types = FALSE)
saveRDS(nlms_tu,
        "data/processed/nlms_tu.rds")

# SESSION INFO ----------------------------------------------------
sessionInfo()
