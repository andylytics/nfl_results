# NOTE: the d data frame is imported/created in the global.R file

shinyUI(fluidPage(
  titlePanel("NFL Visualized Results: Game and Against the Spread (ATS)"),
  
  sidebarLayout(
    sidebarPanel(
      
      
      selectInput("var",
                  label = h4("Choose a Year:"),
                  choices = years,
                  selected = years[1]),
      br(),
      
      #       checkboxInput("cbvar",
      #                     label = "Add Smoothing",
      #                     value = FALSE),
      br(),
      radioButtons("radio", label = h5("Choose Result Type:"),
                   choices = list("Game" = 1, "Against the Spread" = 2),selected = 1),
      
      br(),
      
      p(strong("Documentation:"), " This application visualizes NFL results by team and week for 2006 - 2013. Select a year from the drop-down box above and choose either ", strong("Game"), "or ", strong("Against the Spread"), " results from the radio button options. The absence of a result (colored square) indicates a bye week (each team plays in 16 of 17 weeks in the season)."),
      
      br(),
      
      p(strong("NOTE:"), " you may experience issues with the drop-down box behavior in Internet Explorer. The application performs well in Safari (desktop and mobile), Chrome and Firefox"),      
      br(),      
      
      p("Data Source: ", a("Sunshine Forecast / Repole", href = "http://www.repole.com/sun4cast/data.html")),
      p("Code: ", a("Github Repository", href = "https://github.com/andylytics/nfl_results")),
      p("Created by: ", a("Andy Rosa", href = "https://www.linkedin.com/pub/andrew-rosa/99/787/a64"))
          
      
      
    ),
    mainPanel(
      plotOutput("p", width = 624, height = 780)
    )
  )
))