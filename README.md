# Building A Mortality Predictor

## Abstract
This project investigates the impact of demographic and socioeconomic factors on mortality outcomes in the United States, utilizing the Public Use Microdata Sample of the National Longitudinal Mortality Study (NLMS) spanning from 1973 to 2011. The research seeks to uncover the underlying relationships between socioeconomic status and identity demographics and mortality risk by examining variables such as occupation, industry, income, education, race, and ethnicity and model these factors in a predictor application.

## Research Questions 

**What demographic variables are significant predictors of an individual's death within the next six years?**

**If that individual does pass away, what variables are significant predictors of the length of days that person survives from the initial interview?**

## Data Source

The NLMS Public Use Microdata Sample (PUMS) is a specialized extract of the full NLMS that is designed to provide easy access to an extract of the main study while protecting the confidentiality of those who have responded to the original surveys on which the NLMS is based.
The PUMS format actually describes three files, divided according to whether the original CPS surveys were taken in the early 1980s, File 6a, early 1990s, File 6b, or early 2000s for File 6c.
All of these three files have a maximum follow-up duration of six years.

Standard demographic and socio-economic variables such as education, income, and employment, as well as information collected from death certificates including cause of death are available for analyses.

This analysis used the six year followup study beginning in 2000, since this data is most recent.

## Analysis
-   Show the variation in life expectancy between groups is not just random chance
-   Develop a statistical model which:
    -   Show the relative weight of the effects of different demographics in overall life expectancy
    -   Calculate life expectancy based on those variables determined to be important as accurately as possible

## Deliverables
-   R Markdown paper outlining statistical analysis and findings
-   R scripts with all processing code
-   Shiny dashboard that visualizes significant findings and interactive dashboard allowing user to see how different demographics have different life expectancies.

## Model Application

The [Mortality Predictor](https://annejscott.shinyapps.io/mortality-predictor/) shiny application uses user input to predict the user's chance of death in the next six years with the Chance of Death model and also to predict that if the user does die, how many days they have left with the Days Left model.