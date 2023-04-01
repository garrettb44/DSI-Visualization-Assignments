#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(gapminder)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("GDP and Life Expectancy with Shiny"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("year",
                        "Choose year:",
                        choices = unique(gapminder$year))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
      # modify graph based on input$year from ui.R
      plotdata <- gapminder |>
        filter(year == input$year)
      
      p <- ggplot(plotdata, aes(x = gdpPercap,
                                y=lifeExp, 
                                size = pop, 
                                colour = country)) +
        geom_point(show.legend = FALSE, alpha = 0.7) +
        scale_color_viridis_d() +
        scale_size(range = c(2, 12)) +
        scale_x_log10() +
        labs(x = "GDP per capita",
             y = "Life expectancy")
      p
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
