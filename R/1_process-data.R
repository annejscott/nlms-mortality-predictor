# Title: 606 Life Span Project

# PROCESSING FILE FILE

# Purpose: 
# - load the rds data
# - perform descriptive statistics
# - generate plots and summary statistics
# - code all categorical variables as new factor columns and 
# - export as new addl .rds file


# Packages & Sources ----------------------------------
library(tidyverse)

# Hard-coded lines
source("R/functions.R")

# CODE ----------------------
## READ RDS FILES ----------
nlms <- readRDS("data/processed/nlms6c.rds")

## SUMMARY STATISTICS ----------
# examine variables individually
# independent variables ----
# gender ---
labels <- c("Male", "Female")
levels <- 1:2
nlms <- factor_cols(df = nlms,
                    col = 'sex',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Participants by Sex",
                    x_axis = "Sex")

# urban/rural status ---
labels <- c("Urban", "Rural")
levels <- 1:2
nlms <- factor_cols(df = nlms,
                    col = 'urban',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Urban or Rural Location",
                    x_axis = "Location")


# age ---
sum_stats_hist(nlms$age, 
               title = "Age At Interview",
               x_axis = "Age",
               bins = 80)
#bimodal, rightskewed

# make a new column with race as factors
labels <- c("White", "Black", 
            "Native American", 
            "AAPI", "Other nonwhite")
levels <- 1:5
nlms <- factor_cols(df = nlms,
                    col = 'race',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Race",
                    x_axis = "Race")

# hispanic origin -----
labels <- c("Mexican", "Other Hispanic", "Non-Hispanic")
levels <- 1:3
nlms <- factor_cols(df = nlms,
                    col = 'hisp',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Hispanic Origin",
                    x_axis = "Hispanic Origin")

# martial status -----
# recode for fewer levels
nlms$ms <- ifelse(nlms$ms == 4, 3, nlms$ms)
labels <- c("Married", "Widowed", "Divorced", "Never married")
levels <- c(1, 2, 3, 5)
nlms <- factor_cols(df = nlms,
                    col = 'ms',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Marital Status",
                    x_axis = "Martial Status")

# number of people in the household
sum_stats_hist(nlms$hhnum, 
               title = "Number of People in the Household",
               x_axis = "Household",
               bins = 20)

# Homeownership ----
labels <- c("Owns home", "Rents home", "Rents home non-cash")
levels <- 1:3
nlms <- factor_cols(df = nlms,
                    col = 'tenure',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Homeownership",
                    x_axis = "Homeownership")

# Highest Grade Completed -----
# recode for fewer levels
nlms$educ <- ifelse(nlms$educ >= 1 & nlms$educ <= 7, 7, nlms$educ)
nlms$educ <- ifelse(nlms$educ >= 14, 12, nlms$educ)
labels <- c("Didn't complete high school", "Completed high school", 
            "Bachelor's degree", "Graduate degree")
levels <- c(7, 8, 11, 12)
nlms <- factor_cols(df = nlms,
                    col = 'educ',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Highest Grade Completed",
                    x_axis = "Highest Grade")

# Veteran Status -------
labels <- c("Not a veteran", "Veteran")
levels <- c(0, 1)
nlms <- factor_cols(df = nlms,
                    col = 'vt',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Veteran Status",
                    x_axis = "Veteran Status")

# Citizenship ---------
# recode for fewer levels
nlms$citizen <- ifelse(nlms$citizen >= 1 & nlms$citizen <= 3, 3, nlms$citizen)
labels <- c("Native citizen", "Naturalized citizen", 
            "Not a citizen")
levels <- 3:5
nlms <- factor_cols(df = nlms,
                    col = 'citizen',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Citizenship",
                    x_axis = "Citizenship")

# Health Quality -----
labels <- c("Excellent", "Very good", "Good", "Fair", "Poor")
levels <- 1:5
nlms <- factor_cols(df = nlms,
                    col = 'health',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by General Health",
                    x_axis = "General Health")

# Employment status -----
# recode for fewer levels
nlms$esr <- ifelse(nlms$esr == 2 | nlms$esr == 4, 5, nlms$esr)

labels <- c("Employed", "Looking for Work", "Not in Labor Force")
levels <- c(1, 3, 5)
nlms <- factor_cols(df = nlms,
                    col = 'esr',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Employment Status",
                    x_axis = "Employment Status")

# Major Industry ----
# recode for fewer levels
blue_collar <- c(2, 3, 4, 6, 12, 14)
white_collar <- c(5, 7, 8, 9, 10, 11, 13)
nlms$majind <- ifelse(nlms$majind == blue_collar, 1, nlms$majind)
nlms$majind <- ifelse(nlms$majind == white_collar, 2, nlms$majind)

labels <- c("Blue collar", "White collar")
levels <- 1:2
nlms <- factor_cols(df = nlms,
                    col = 'majind',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Industry",
                    x_axis = "Industry")

# Major industry, again ------
blue_collar <- c(3, 6, 7, 8, 9, 10, 11)
white_collar <- c(1, 2, 4, 5)
nlms$majocc <- ifelse(nlms$majocc == blue_collar, 1, nlms$majocc)
nlms$majocc <- ifelse(nlms$majocc == white_collar, 2, nlms$majocc)

labels <- c("Blue collar", "White collar")
levels <- 1:2
nlms <- factor_cols(df = nlms,
                    col = 'majocc',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Industry",
                    x_axis = "Industry")
# Combine two major columns
nlms$occF <- coalesce(nlms$majindF, nlms$majoccF)

# Plot the counts as a bar plot
barplot(table(nlms$occF),
        main = "NLMS Particpants by Industry", 
        xlab = "Industry", 
        ylab = "Counts", 
        col = "skyblue", 
        border = "black",
        yaxt = "n")

# Income as Percent Poverty Level -------
# recode for fewer levels
# 1 remains 1
nlms$povpct <- ifelse(nlms$povpct >= 2 & nlms$povpct <= 3, 2, nlms$povpct)
nlms$povpct <- ifelse(nlms$povpct >= 4 & nlms$povpct <= 7, 3, nlms$povpct)
nlms$povpct <- ifelse(nlms$povpct >= 8 & nlms$povpct <= 13, 4, nlms$povpct)
nlms$povpct <- ifelse(nlms$povpct >= 14 & nlms$povpct <= 19, 5, nlms$povpct)
nlms$povpct <- ifelse(nlms$povpct >= 20, 6, nlms$povpct)

labels <- c("Below 50% PL", "PL", "200% PL", "350% PL", "550% PL", 
            "More than 600% PL")
levels <- 1:6
nlms <- factor_cols(df = nlms,
                    col = 'povpct',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "NLMS Particpants by Income (Percent Poverty Level)",
                    x_axis = "Income as Percent of Poverty Level")

# Health Insurance status ------
labels <- c("Not insuranced", "Insured")
levels <- c(0, 1)
nlms <- factor_cols(df = nlms,
                    col = 'histatus',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "Insured Vs Not Insured",
                    x_axis = "Insurance Status")

# Health Insurance Type -------
# recode for fewer levels
# 0 remains 0
nlms$hitype <- ifelse(nlms$hitype >= 1 & nlms$hitype <= 3, 1, 
                      nlms$hitype)
labels <- c("Not insured", "Government insurance", "Employer insurance", 
            "Private insurance")
levels <- c(0, 1, 4, 5)
nlms <- factor_cols(df = nlms,
                    col = 'hitype',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "Health Insurance Type",
                    x_axis = "Health Insurance Type")

# dependent variable -----
# death indicator ---
labels <- c("Didn't die", "Died")
levels <- c(0, 1)
nlms <- factor_cols(df = nlms,
                    col = 'inddea',
                    factor_levels = levels,
                    factor_labels = labels,
                    title = "Deaths During the Study",
                    x_axis = "Death Status")

# select only factors
nlms <- nlms |> 
  select(record, age, sexF, raceF, hispF, urbanF, msF, tenureF, educF,
         vtF, citizenF, hhnum, healthF, esrF, occF, povpctF, histatusF, 
         hitypeF, inddeaF, follow)

# Save nlms file with extra columns
saveRDS(nlms,
        "data/clean/nlms_factored.rds")

# days from interview until death
deaths_only <- filter(nlms, !is.na(follow))

sum_stats_hist(deaths_only$follow, 
               title = "Days Survived After Interview",
               x_axis = "Days",
               bins = 50)

# Save nlms file with extra columns
saveRDS(deaths_only,
        "data/clean/deaths_only.rds")

# SESSION INFO ----------------------------------------------------
sessionInfo()