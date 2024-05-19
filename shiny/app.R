#
# This is a Shiny web application for 606 Final Project
#
library(shiny)
library(bslib)
library(shinydashboard)

# ReadRDS ------
# datasets that **TRAINED THE MODELS**
nlms <- readRDS("data/logistic_nlms-DATA.rds")
deaths <- readRDS("data/randomForest_deaths-DATA.rds")
logistic_nlms <- readRDS("data/logistic_nlms-MODEL.RDS")
randomForest_deaths <- readRDS("data/randomForest_deaths-MODEL.RDS")


# User interface ----
# UI ----
ui <- dashboardPage(
  dashboardHeader(title = "Mortality Predictor"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(
        infoBoxOutput("logistic"),
        infoBoxOutput("regression")
    ),
      fluidRow(
        box(
         title = "",
         height = 300,
          # widgets for user input
          # age
         sliderInput(
            "age",
            "Age",
            min = 0,
            max = 90,
            value = 50
         ),
         # sex
         selectInput(
           "sexF",
           "Sex",
           choices = list("Male" = "Male", "Female" = "Female"),
           selected = "Female"
        ),
        # hisp
        selectInput(
          "hispF",
          "Hispanic",
          choices = list("Mexican" = "Mexican", 
                         "Other Hispanic" = "Other Hispanic",
                         "Non-Hispanic" = "Non-Hispanic"),
          selected = "Mexican")
        ),
        box(
          title = "",
          height = 300,
         # marriage status
          selectInput(
            "msF",
            "Marriage status",
            choices = list("Never married" = "Never married", 
                           "Married" = "Married",
                           "Widowed" = "Widowed",
                          "Divorced" = "Divorced"),
            selected = "Never married"
          ),
          # veteran
          selectInput(
            "vtF",
            "Veteran status",
            choices = list("Veteran" = "Veteran", 
                           "Not a veteran" = "Not a veteran"),
            selected = "Veteran"
          ),
          # employment
          selectInput(
            "esrF",
            "Employment status",
             choices = list("Employed" = "Employed", 
                            "Looking for Work" = "Looking for Work",
                            "Not in Labor Force" = "Not in Labor Force"),
             selected = "Employed"
          )),
        box(
          title = "",
          height = 300,
          # Household Memember
          sliderInput(
            "hhnum",
            "Household Size",
            min = 1,
            max = 5,
            value = 1
          ),
          # education
          selectInput(
            "educF",
            "Education",
            choices = list("Didn't complete high school" = "Didn't complete high school", 
                           "Completed high school" = "Completed high school",
                           "Bachelor's degree" = "Bachelor's degree",
                           "Graduate degree" = "Graduate degree"),
            selected = "Completed high school"
          ),
          # urban vs rural
          selectInput(
             "urbanF",
             "Location",
             choices = list("Urban" = "Urban", 
                            "Rural" = "Rural"),
             selected = "Urban"
          )
        ),
        box(
          title = "",
          height = 300,
          # insurance type
          selectInput(
              "hitypeF",
              "Health Insurance",
              choices = list("Not insured" = "Not insured", 
                             "Government insurance" = "Government insurance",
                             "Employer insurance" = "Employer insurance",
                             "Private insurance" = "Private insurance"),
              selected = "Not insured"
          ),
          #health
          selectInput(
              "healthF",
              "Health",
              choices = list("Excellent" = "Excellent", 
                             "Very good" = "Very good",
                             "Good" = "Good",
                             "Fair" = "Fair",
                             "Poor" = "Poor"),
              selected = "Excellent"
          
        )
      )
    )
  )
)

# Server ----
server <- function(input, output) {
  
  # WILL YOU DIE Model output
  output$logistic <- renderInfoBox({
    
    # Get values from inputs
    msF1 <- input$msF
    hhnum1 <- input$hhnum
    vtF1 <- input$vtF
    healthF1 <- input$healthF
    esrF1 <- input$esrF
    hitypeF1 <- input$hitypeF
    
    # Create a new data frame with values for the independent variables
    user_data1 <- data.frame(msF = msF1,  
                             hhnum = hhnum1, 
                             vtF = vtF1,  
                             healthF = healthF1, 
                             esrF = esrF1,   
                             hitypeF = hitypeF1) 
    
    # Predict using the model
    chance_death <- round((predict(logistic_nlms, 
                                   newdata = user_data1, 
                                   type = "response") * 100), 1)
    
    infoBox(
      title="Possibility of Death", 
      paste(chance_death, "%"), 
      icon = icon("remove-sign", lib="glyphicon"),
      color = "olive", fill = TRUE, width = 12
    )
  })
  
  output$regression <- renderInfoBox({
    
    # Get values from inputs
    age <- input$age
    msF2 <- input$msF
    hhnum2 <- input$hhnum
    vtF2 <- input$vtF
    healthF2 <- input$healthF
    esrF2 <- input$esrF
    hitypeF2 <- input$hitypeF
    hispF <- input$hispF
    urbanF <- input$urbanF
    educF <- input$educF
    sexF <- input$sexF
    
    # Create a new data frame with values for the independent variables
    # Create a new data frame with values for the independent variables
    user_data2 <- data.frame(msF = as.factor(msF2),  
                             hhnum = as.numeric(hhnum2),  
                             vtF = as.factor(vtF2),   
                             healthF = as.factor(healthF2), 
                             esrF = as.factor(esrF2), 
                             hitypeF = as.factor(hitypeF2),
                             age = as.numeric(age),
                             sexF = as.factor(sexF),
                             hispF = as.factor(hispF),
                             urbanF = as.factor(urbanF),
                             educF = as.factor(educF))
    
  
    
    # Predict using the model
    countdown <- round(predict(randomForest_deaths, newdata = user_data2, 
                               type = "response"), 0)
    
    infoBox(
      "Days Left", 
      countdown,
      icon = icon("calendar", lib="glyphicon"),
      color = "purple", fill = TRUE, width = 12
    )
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
