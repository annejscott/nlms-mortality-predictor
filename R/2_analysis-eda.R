# Title: 606 Life Span Project

# PROCESSING FILE

# Purpose: 
# - load the rds data
# - analyze correlation
# - check conditions


# Packages & Sources ----------------------------------
source("R/functions.R")

# ReadRDS ------
nlms <- readRDS("data/clean/nlms_factored.rds")
deaths <- readRDS("data/clean/deaths_only.rds")

# plot dependent variable
hist(deaths$follow,
     main="Distribution of Days After",
     col="lightblue")

# check conditions, test relationship between variables ----
# age ------------
# age to death indicator
anova_to_death(nlms$age, 
               bins=80)

# age to days until death
# Kolmogorov-Smirnov Test for normality in a large sample
ks.test(x=nlms$age,
        y=nlms$follow)

ggplot(deaths, aes(x=age, y=follow)) +
  geom_jitter()

# sex ---------------
# independence test of age to death indicator
independence_test(nlms$sexF)

# sex to days until death
test_normality_and_variance(deaths$sexF)

# race -------------
# independence test of race to death indicator
independence_test(nlms$raceF)

# race to days until death
test_normality_and_variance(deaths$raceF)

# hisp ---------
# independence test of hisp to death indicator
independence_test(nlms$hispF)

# hisp to days until death
test_normality_and_variance(deaths$hispF)

# urban -----
# independence test of location to death indicator
independence_test(nlms$urbanF)

# location to days until death
test_normality_and_variance(deaths$urbanF)

# marital status ----
# independence test of marriage to death indicator
independence_test(nlms$msF)

# marriage to days until death
test_normality_and_variance(deaths$msF)


# homeownership ---
# independence test of homeownership to death indicator
independence_test(nlms$tenureF)

# marriage to days until death
test_normality_and_variance(deaths$tenureF)

# education ----
# independence test of education to death indicator
independence_test(nlms$educF)

# education to days until death
test_normality_and_variance(deaths$educF)


# health ----
# independence test of education to death indicator
independence_test(nlms$healthF)

# education to days until death
test_normality_and_variance(deaths$healthF)


# veteran -----
# independence test of veteran to death indicator
independence_test(nlms$vtF)

# veteran to days until death
test_normality_and_variance(deaths$vtF)


# citizen ----
# independence test of citizen to death indicator
independence_test(nlms$citizenF)

# citizen to days until death
test_normality_and_variance(deaths$citizenF)


# people in house ------------
# people in house to death indicator
anova_to_death(nlms$hhnum, 
               bins = 15)

# people in house to deaht to days until death

# Kolmogorov-Smirnov Test for normality in a large sample
ks.test(x=nlms$hhnum,
        y=nlms$follow)

ggplot(deaths, aes(x=hhnum, y=follow)) +
  geom_jitter()

# employment ----
# independence test of employment to death indicator
independence_test(nlms$esrF)

# employment to days until death
test_normality_and_variance(deaths$esrF)


# occupation -----
# independence test of occupation to death indicator
independence_test(nlms$occF)

# occupation to days until death
test_normality_and_variance(deaths$occF)


# poverty ----
# independence test of poverty to death indicator
independence_test(nlms$povpctF)

# poverty to days until death
test_normality_and_variance(deaths$povpctF)


# insured -----
# independence test of insured to death indicator
independence_test(nlms$histatusF)

# insured to days until death
test_normality_and_variance(deaths$histatusF)



# insurance type ----
# independence test of insurance type to death indicator
independence_test(nlms$hitypeF)

# insurance type to days until death
test_normality_and_variance(deaths$hitypeF)


# SESSION INFO ----------------------------------------------------
sessionInfo()