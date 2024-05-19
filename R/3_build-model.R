# Title: 606 Life Span Project

# MODELING FILE

# Purpose: 
# - load the rds data
# - make a linear model
# - check conditions


# Packages & Sources ----------------------------------

# ReadRDS ------
nlms <- readRDS("data/clean/nlms_factored.rds")
deaths <- readRDS("data/clean/deaths_only.rds")

# Save Data used to build models to shiny
saveRDS(nlms, "shiny/data/logistic_nlms-DATA.rds")

# logistic regression with variables with cramer V value > 0.1
nlms_logistic <- glm(inddeaF ~ msF + hhnum + vtF + healthF + esrF + 
                       hitypeF,
                         data = nlms, 
                         family = binomial)

# save as rds object
saveRDS(nlms_logistic,
        "data/models/logistic_nlms.RDS")

# save as rds object
saveRDS(nlms_logistic,
        "shiny/data/logistic_nlms-MODEL.RDS")







# RANDOM FOREST REGRESSION ----
deaths_ind <- deaths[, c("age", "sexF", "hispF", "urbanF", 
                         "msF", "educF", "vtF", "hhnum", "healthF", 
                         "esrF", "hitypeF", "follow")]

saveRDS(deaths_ind,
        "shiny/data/randomForest_deaths-DATA.rds")

# Fit Random Forest Regression model
deaths_rf <- randomForest::randomForest(follow ~ ., 
                                        data = deaths_ind,
                                        na.action = na.omit,
                                        importance = TRUE,
                                        keep.forest=FALSE)

# save as rds object
saveRDS(deaths_rf,
        "data/models/randomForest_deaths-MODEL.RDS")
saveRDS(deaths_rf,
        "shiny/data/randomForest_deaths-MODEL.RDS")


# SESSION INFO ----------------------------------------------------
sessionInfo()
