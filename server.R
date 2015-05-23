suppressMessages(library(UsingR))
suppressMessages(library(dplyr))
data(USArrests)

## create new dataframe DF - add new column of state names from rownames
DF <- cbind(State = rownames(USArrests), USArrests)

## create new column as a vector
DF$State <- as.vector(DF$State)


urbanPop_pct <- function(urbanPop,tolerance) {
        
        ## find nearest matches based on UI input to nearest tolerance level from UI slider input
        matched <- find.matches(DF$UrbanPop,urbanPop,tol=tolerance)
        matchlogic <- as.logical(matched$matches)
             
        ## arrange/sort the results by UrbanPop in ascending order. Print out matches
        if (sum(matchlogic) == 0) {
                print("No states match - Please select another Urban population or increase tolerance")        
        }
        else {
                print(arrange(DF[matchlogic == TRUE,c(1,4)],UrbanPop),row.names=FALSE)
        }
        }

perform_calc <- function(urbanPop) {
        ## Calculates percentile of input value - 
        ## this is used as reactive function - only re-called if Urban input changes
        round(mean(DF$UrbanPop <= urbanPop)*100,digits=0)    
} 


shinyServer(
        function(input, output) {
                ## reactive funciton only called if input value for Urban % changes 
                cal_percentile <- reactive({
                        perform_calc(input$urbanPop) })
                
                output$inputValue <- renderPrint({input$urbanPop})
                output$result <- renderPrint({urbanPop_pct(input$urbanPop,input$tolerance)})
                output$percentile <- renderPrint({cal_percentile()})
        }
              
                                    
)