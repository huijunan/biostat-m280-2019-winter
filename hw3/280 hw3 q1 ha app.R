library(shiny)

# Define UI ----
ui <- fluidPage(
  navbarPage("My Application",
             tabPanel("Component 1",  titlePanel("title 1"),
                      sidebarLayout(
                        sidebarPanel("sidebar panel"),
                        mainPanel(mainPanel(plotOutput("plot",height=400,width=700))))),
             tabPanel("Component 2",  titlePanel("title 2"),
                      sidebarLayout(
                        sidebarPanel("sidebar panel",
                                     selectInput(inputId = "Year",
                                                 label = "Choose a Year:",
                                                 choices = c("2017", "2013", "2014", "2015", "2016", "2018")),
                                     
                                     # Input: Numeric entry for number of obs to view ----
                                     numericInput(inputId = "individuals",
                                                  label = "Number of individuals to view:",
                                                  value = 10, min = 1)
                                     ),
                        mainPanel("main panel",
                                  tableOutput("view")
                                  ))),
             
             tabPanel("Component 3",  
                      titlePanel("title 3"),
                      sidebarLayout(
                        sidebarPanel("sidebar panel", 
                                     radioButtons("Method", "Method:",
                                                  c("Median" = "Median",
                                                    "Mean" = "Mean")),
                                     selectInput(inputId = "Year2",
                                                 label = "Choose a Year:",
                                                 choices = c("2013", "2014", "2015", "2017", "2016", "2018"),
                                                 selected = "2017"),
                                     
                                     # Input: Numeric entry for number of obs to view ----
                                     numericInput(inputId = "departments",
                                                  label = "Number of departments to view:",
                                                  value = 5, min = 1)
                        ),
                        mainPanel("main panel",tableOutput("view2")))),
             
             tabPanel("Component 4",  
                      titlePanel("title 4"),
                      sidebarLayout(
                        sidebarPanel("sidebar panel", 
                                     selectInput(inputId = "Year3",
                                                 label = "Choose a Year:",
                                                 choices = c("2013", "2014", "2015", "2016", "2017", "2018"),
                                                 selected = "2017"),
                                     
                                     # Input: Numeric entry for number of obs to view ----
                                     numericInput(inputId = "departments2",
                                                  label = "Number of departments to view:",
                                                  value = 5, min = 1)
                        ),
                        mainPanel("main panel",tableOutput("view3")))),
             
             tabPanel("Component 5",  
                      titlePanel("title 5"),
                      sidebarLayout(
                        sidebarPanel("sidebar panel", 
                                     radioButtons("Method2", "Method:",
                                                  c("Median" = "Median",
                                                    "Mean" = "Mean")),
                                     selectInput(inputId = "Year4",
                                                 label = "Choose a Year:",
                                                 choices = c("2013", "2014", "2015", "2017", "2016", "2018"),
                                                 selected = "2017"),
                                     
                                     # Input: Numeric entry for number of obs to view ----
                                     numericInput(inputId = "jobclass",
                                                  label = "Number of job titles to view:",
                                                  value = 5, min = 1)
                        ),
                        mainPanel("main panel",tableOutput("view4"))))
  )
)

# Define server logic ----
server <- function(input, output) {

  output$plot <- renderPlot({
    function1(payroll_by_year_long)})
  
  output$view <- renderTable({
    head(only_pay %>% filter(only_pay$Year == input$Year),
         n = input$individuals)})
  
  data <- reactive({  
    Method <- switch(input$Method,
                   Mean = department_mean %>% filter(department_mean$Year == input$Year2),
                   Median = department_median %>% filter(department_median$Year == input$Year2))
  })
  
  output$view2 <- renderTable({
    head(data() ,
         n = input$departments)})
  
  output$view3 <- renderTable({
    head(cost_order %>% filter(cost_order$Year == input$Year3),
         n = input$departments2)})
  
  data2 <- reactive({  
    Method <- switch(input$Method2,
                     Mean = job_mean %>% filter(job_mean$Year == input$Year4),
                     Median = job_median %>% filter(job_median$Year == input$Year4))
  })
  
  output$view4 <- renderTable({
    head(data2() ,
         n = input$jobclass)})
}
# Run the app ----
shinyApp(ui = ui, server = server)
