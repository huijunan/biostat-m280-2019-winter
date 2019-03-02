library("readr")
library("rio")
library("tidyverse")
library("magrittr")
library("dplyr")
library("shiny")
library("rsconnect")
options(shiny.sanitize.errors = F)
payroll <- read.csv("City_Employee_Payroll.csv")
export(payroll,"payroll.rds")
payrolls <- read_rds("payroll.rds")
payrolls[is.na(payrolls)] <- 0

sapply(payrolls, class)
#2
payroll_by_year <- as.data.frame(
  aggregate(
    list(payrolls$Total.Payments, 
         payrolls$Base.Pay, 
         payrolls$Overtime.Pay, 
         payrolls$Other.Pay..Payroll.Explorer.
    ), 
    by = list(payrolls$Year), 
    sum)
)
colnames(payroll_by_year) <- c("Year", 
                               "Total.Payments", 
                               "Base.Pay", 
                               "Overtime.Pay", 
                               "Other.Pay")
library("tidyr")
payroll_by_year_long <- gather(payroll_by_year, 
                               type, 
                               value, 
                               Base.Pay:Other.Pay)

#3 Who earned most? 

only_pay <- payrolls[ -c(4, 5, 7:15, 18:21, 23, 25:35) ]
only_pay <- only_pay[order(only_pay$Total.Payments, decreasing = T),]

#4 Which departments earn most? 

department_mean <- as.data.frame(
  aggregate(
    list(payrolls$Total.Payments, 
         payrolls$Base.Pay, 
         payrolls$Overtime.Pay, 
         payrolls$Other.Pay..Payroll.Explorer.
    ), 
    by = list(payrolls$Department.Title, payrolls$Year), 
    mean)
)
colnames(department_mean) <- c("Department.Title", 
                               "Year", 
                               "Mean.Total.Payments", 
                               "Mean.Base.Pay", 
                               "Mean.Overtime.Pay", 
                               "Mean.Other.Pay")

department_median <- as.data.frame(
  aggregate(
    list(payrolls$Total.Payments, 
         payrolls$Base.Pay, 
         payrolls$Overtime.Pay, 
         payrolls$Other.Pay..Payroll.Explorer.), 
    by = list(payrolls$Department.Title, payrolls$Year), 
    median)
)
colnames(department_median) <- c("Department.Title",
                                 "Year", 
                                 "Median.Total.Payments", 
                                 "Median.Base.Pay", 
                                 "Median.Overtime.Pay", 
                                 "Median.Other.Pay")




department_order <- as.data.frame(
  aggregate(
    list(payrolls$Total.Payments, 
         payrolls$Base.Pay, 
         payrolls$Overtime.Pay, 
         payrolls$Other.Pay..Payroll.Explorer.), 
    by = list(payrolls$Department.Title, payrolls$Year), 
    sum)
)
colnames(department_order) <- c("Department.Title", 
                                "Year", 
                                "Total.Payments", 
                                "Base.Pay", 
                                "Overtime.Pay", 
                                "Other.Pay")

department_mean <- 
  department_mean[order(department_mean$Mean.Total.Payments, decreasing = T),]
department_median <- 
  department_median[order(
    department_median$Median.Total.Payments, decreasing = T
  ),]



#5 Which departments cost most? 
cost_order <- as.data.frame(
  aggregate(
    list(payrolls$Total.Payments, 
         payrolls$Base.Pay, 
         payrolls$Overtime.Pay, 
         payrolls$Other.Pay..Payroll.Explorer.,
         payrolls$Average.Benefit.Cost), 
    by = list(payrolls$Department.Title, payrolls$Year), 
    sum)
)
colnames(cost_order) <- c("Department.Title", 
                          "Year", 
                          "Total.Payments", 
                          "Base.Pay", 
                          "Overtime.Pay", 
                          "Other.Pay", 
                          "Average.Benefit.Cost")
cost_order <- cost_order[order(
  cost_order$Average.Benefit.Cost, decreasing = T
),]

#5 what kind of jobs earn the most in average? 
job_mean <- as.data.frame(
  aggregate(
    list(payrolls$Total.Payments, 
         payrolls$Base.Pay, 
         payrolls$Overtime.Pay, 
         payrolls$Other.Pay..Payroll.Explorer.), 
    by = list(payrolls$Job.Class.Title, payrolls$Year), 
    mean)
)
colnames(job_mean) <- c("Job.Class.Title", 
                        "Year", 
                        "Mean.Total.Payments", 
                        "Mean.Base.Pay", 
                        "Mean.Overtime.Pay", 
                        "Mean.Other.Pay")

job_mean <- job_mean[order(job_mean$Mean.Total.Payments, decreasing = T),]

job_median <- as.data.frame(
  aggregate(
    list(payrolls$Total.Payments, 
         payrolls$Base.Pay, 
         payrolls$Overtime.Pay, 
         payrolls$Other.Pay..Payroll.Explorer.), 
    by = list(payrolls$Job.Class.Title,payrolls$Year), 
    median)
)
colnames(job_median) <- c("Job.Class.Title", 
                          "Year", 
                          "Median.Total.Payments", 
                          "Median.Base.Pay", 
                          "Median.Overtime.Pay", 
                          "Median.Other.Pay")
job_median <- job_median[order(
  job_median$Median.Total.Payments, decreasing = T
),]




# Define UI ----
ui <- fluidPage(
  navbarPage(inverse = T, 
             p(em("LA City Employee Payroll Exploration"), 
               style = "color: salmon ; 
               font-size: 30px ; 
               font-family: 'times'"), 
             tabPanel("Total Payroll by LA City",  
                      titlePanel("Total Payroll by LA City"),
                      h5(em("Visualize the total LA City payroll of each year, 
                            with breakdown into base pay, overtime pay, 
                            and other pay.")),
                      sidebarLayout(
                        sidebarPanel( 
                          sliderInput(inputId = "Year0",
                                      label = "Year Range:",
                                      min = 2013,
                                      max = 2018,
                                      value = 2018)
                          
                        ),
                        mainPanel( 
                          plotOutput("barPlot"), 
                          tableOutput("table")))),
             #verbatimTextOutput("table")
             tabPanel("Most Earning Individuals",  
                      titlePanel("Who earned most? "),
                      h5(em("Visualize the payroll information 
                            (total payment with breakdown into base pay, 
                            overtime pay, and other pay, Department, Job Title) 
                            of the top highest paid LA City employees in a 
                            specific year.")),
                      sidebarLayout(
                        sidebarPanel("sidebar panel",
                                     selectInput(inputId = "Year",
                                                 label = "Choose a Year:",
                                                 choices = c("2013", 
                                                             "2014", 
                                                             "2015", 
                                                             "2017", 
                                                             "2016", 
                                                             "2018"), 
                                                 selected = "2017"),
                                     
                                     # Input: Numeric entry for number of obs 
                                     numericInput(
                                       inputId = "individuals",
                                       label = "Number of individuals to view:",
                                       value = 10, min = 1)
                        ),
                        mainPanel(tableOutput("view")
                        ))),
             
             tabPanel("Most Earning Departments",  
                      titlePanel("Which departments earn most?"),
                      h5(em("Visualize the mean or median payroll, 
                            with breakdown into base pay, overtime pay, 
                            and other pay, of top earning departments.")), 
                      sidebarLayout(
                        sidebarPanel(radioButtons("Method", "Method:",
                                                  c("Median" = "Median",
                                                    "Mean" = "Mean")),
                                     selectInput(inputId = "Year2",
                                                 label = "Choose a Year:",
                                                 choices = c("2013", 
                                                             "2014", 
                                                             "2015", 
                                                             "2017", 
                                                             "2016", 
                                                             "2018"),
                                                 selected = "2017"),
                                     
                                     # Input: Numeric entry for number of obs 
                                     numericInput(
                                       inputId = "departments",
                                       label = "Number of departments to view:",
                                       value = 5, min = 1)
                        ),
                        mainPanel(tableOutput("view2")))),
             
             tabPanel("Most Benifit Cost Departments",  
                      titlePanel("Which departments cost most? "),
                      h5(em("Visualize the total payroll, with breakdown into 
                            base pay, overtime pay, and other pay, 
                            of top expensive departments.")), 
                      sidebarLayout(
                        sidebarPanel(selectInput(inputId = "Year3",
                                                 label = "Choose a Year:",
                                                 choices = c("2013", 
                                                             "2014", 
                                                             "2015", 
                                                             "2016", 
                                                             "2017", 
                                                             "2018"),
                                                 selected = "2017"),
                                     
                                     # Input: Numeric entry for number of obs 
                                     numericInput(
                                       inputId = "departments2",
                                       label = "Number of departments to view:",
                                       value = 5, min = 1)
                        ),
                        mainPanel(tableOutput("view3")))),
             
             tabPanel("Most Earning Jobs",  
                      titlePanel("What kind of jobs earn most?"),
                      h5(em("Visualize the mean or median payroll, 
                            with breakdown into base pay, overtime pay, 
                            and other pay, of top earning jobs.")),
                      sidebarLayout(
                        sidebarPanel(radioButtons("Method2", "Method:",
                                                  c("Median" = "Median",
                                                    "Mean" = "Mean")),
                                     selectInput(inputId = "Year4",
                                                 label = "Choose a Year:",
                                                 choices = c("2013", 
                                                             "2014", 
                                                             "2015", 
                                                             "2017", 
                                                             "2016", 
                                                             "2018"),
                                                 selected = "2017"),
                                     
                                     # Input: Numeric entry for number of obs 
                                     numericInput(
                                       inputId = "jobclass",
                                       label = "Number of job titles to view:",
                                       value = 5, min = 1)
                        ),
                        mainPanel(tableOutput("view4"))))
                      ) 
  
                      )

# Define server logic ----
server <- function(input, output) {
  
  data0 <- reactive({  
    payroll_by_year_long %>% filter(Year <= input$Year0)
  })
  
  output$barPlot <- renderPlot({
    ggplot(data0(), aes(fill = type, y = as.numeric(value) / 1000000, x=Year)) + 
      geom_bar(stat ="identity") +
      xlab("Year") + ylab("Payroll in Million $") + 
      ggtitle("Total payroll by LA City") +
      theme(plot.title = element_text(hjust = 0.5, size = 22), 
            axis.title = element_text(hjust = 0.5, size = 15), 
            axis.text = element_text(size = 12), 
            legend.title = element_text(size = 15), 
            legend.text = element_text(size = 12))
  })
  
  output$table <- renderPrint(payroll_by_year)
  output$table <- renderTable({
    payroll_by_year %>% filter(payroll_by_year$Year <= input$Year0)})
  
  output$view <- renderTable({
    head(only_pay %>% filter(only_pay$Year == input$Year),
         n = input$individuals)})
  
  data <- reactive({  
    Method <- switch(input$Method,
                     Mean = department_mean %>% 
                       filter(department_mean$Year == input$Year2),
                     Median = department_median %>% 
                       filter(department_median$Year == input$Year2))
  })
  
  output$view2 <- renderTable({
    head(data() ,
         n = input$departments)})
  
  output$view3 <- renderTable({
    head(cost_order %>% filter(cost_order$Year == input$Year3),
         n = input$departments2)})
  
  data2 <- reactive({  
    Method <- switch(input$Method2,
                     Mean = job_mean %>% 
                       filter(job_mean$Year == input$Year4),
                     Median = job_median %>% 
                       filter(job_median$Year == input$Year4))
  })
  
  output$view4 <- renderTable({
    head(data2() ,
         n = input$jobclass)})
}
# Run the app ----
shinyApp(ui = ui, server = server)
