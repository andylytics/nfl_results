
# NOTE: the d data frame is imported/created in the global.R file

library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(function(input, output) {

  output$p <- renderPlot({

    # subset data
    d <- filter(d, year == input$var)
    
    if (input$radio == 1){
      ggplot(d, aes(x = factor(TeamName), y = week, colour = Game.Result)) +
        geom_point(size = 10, shape = 15) +
        coord_flip() +
        theme(axis.title.y = element_blank(), axis.title.x = element_blank(), legend.title = element_blank()) +
        scale_colour_manual(values = c("#00BA38", "#F8766D", "#619CFF")) +
        scale_y_discrete(breaks = unique(d$week)) +
        ggtitle(paste0("GAME RESULTS ", input$var,  " by Team and Week"))
    }
    else {
       ggplot(d, aes(x = factor(TeamName), y = week, colour = ATS.Result)) +
         geom_point(size = 10, shape = 15) +
         coord_flip() +
         theme(axis.title.y = element_blank(), axis.title.x = element_blank(), legend.title = element_blank()) +
         scale_colour_manual(values = c("#00BA38", "#F8766D", "#619CFF")) +
         scale_y_discrete(breaks = unique(d$week)) +
         ggtitle(paste0("ATS RESULTS ", input$var,  " by Team and Week"))
    }
    

  })

})
