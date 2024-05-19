# Title: 606 Life Span Project

# FUNCTIONS FILE

# Purpose: 
# - write custom functions

# Packages & Sources ----------------------------------
library(tidyverse)

# DATA PROCESSING ---------
sum_stats_hist <- function(col, title, x_axis, bins) {
  # Print summary statistics
  # print(psych::describe(col, skew = FALSE, IQR = TRUE, fast = TRUE))
  
  # Plot histogram with specified number of bins
  hist(col, 
       main = title, 
       xlab = x_axis, 
       ylab = NULL,
       col = "skyblue", 
       border = "black",
       breaks = bins)
}

factor_cols <- function(df, col, factor_levels, factor_labels, title, x_axis) {
  # Create name for new column
  new_col <- paste0(col, "F")
  
  # Generate new column of factors
  df <- df |> 
    mutate(!!new_col := factor(!!sym(col), 
                               levels = factor_levels, 
                               labels = factor_labels))
  
  # Plot the counts as a bar plot
  barplot(table(df[[new_col]]),
          main = title, 
          xlab = x_axis, 
          ylab = "Counts", 
          col = "skyblue", 
          border = "black",
          yaxt = "n")
  
  return(df)
}

# COMPARE TO DEATH INDICATOR -----------
# numerical to death indicator
anova_to_death <- function(col, bins) {
  results <- aov(formula = col ~ inddeaF,
                 data = nlms)
  print(summary(results))
  # check homogeny of variance
  print(car::leveneTest(results))
  #check normal distribution
  hist(residuals(results), 
       col = "skyblue", 
       border = "black",
       breaks = bins)
}

#  categorical to death indicator
independence_test <- function(col) {

  # Create the contingency table
  frequency <- xtabs(~ col + inddeaF, data = nlms)
  
  # Perform chi-square test of independence
  print(chisq.test(frequency))
  
  # Calculate Cramer's V
  print(paste("Cramer's Association:", lsr::cramersV(frequency)))
}

# CHECK CONDITIONS ------------
# categorical to numerical
test_normality_and_variance <- function(col) {
  # NORMALITY
  # fit ANOVA model
  results <- aov(follow ~ col,
                 data=deaths) 
  summary(results)
  
  # histogram of residuals
  hist(x = residuals(results))
  
  # qq plot of residuals
  qqnorm(y = residuals(results))
  
  # VARIANCE
  # plot the variance
  boxplot(follow ~ col,
          data=deaths)
  
  # check homogeneity of variance with Brown-Forsythe test
  bf_result <- onewaytests::bf.test(follow ~ col, 
                                    data = deaths)
  
  # Print significant p-values
  bf_result$p.value[bf_result$p.value < 0.05]
  
}

