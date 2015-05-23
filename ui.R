library(markdown)

shinyUI(navbarPage("Navbar",
        tabPanel("App",headerPanel("Urban Population - 1973"),
        sidebarLayout(
        ## Urban population from USArrests R dataset
        ## Source: World Almanac and Book of facts 1975 (Crime rates)
        ## Source: Statistical Abstracts of the United States 1975 (Urban rates)
        sidebarPanel(
                sliderInput('tolerance','Select tolerance level : 0 = exact match',value = 3, min=0, max=10, step=1,),
                numericInput('urbanPop', 'Percentage of Population in Urban areas',value = 75, min = 0, max = 100, step = 1),
                submitButton('Submit')
        ),
        mainPanel(
                h3('States nearest selected percentage and range'),
                h4('Your % selected'),
                verbatimTextOutput("inputValue"),
                h4('Urban population % of States matching within selected Tolerance'),
                verbatimTextOutput("result"),
                h5('Calculated Percentile of your input for Percentage of Urban Population rate = '),
                verbatimTextOutput("percentile"),
                h5('Source:Statistical Abstracts of the United States 1975')
                )
        )
        ),

        tabPanel("Instructions",includeMarkdown("instructions.md")
        )
)
)