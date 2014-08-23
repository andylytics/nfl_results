# load packages
library(dplyr)

# set variable names
zip.file <- "nflstats.zip"
file.loc <- "./data/"
fileURL <- "http://www.repole.com/sun4cast/stats/nflstats.zip"

# download zip file
download.file(fileURL, paste0(file.loc, zip.file))

# get list of .csv files
file.names <- unzip(paste0(file.loc, zip.file), list = TRUE)
file.names <- grep(".csv", file.names$Name, value = TRUE)
years <- 2006:2013
years <- as.character(years)

# loop through each file and create data frame of selected years
i <- 1
for (i in i:length(years)){
  # read file
  df <- read.csv(unz(paste0(file.loc, zip.file), grep(years[i], file.names, value = TRUE)))
  
  # select needed variables
  df <- select(df, Date, TeamName, ScoreOff, ScoreDef, Line)
  
  # set year
  df$year <- as.integer(years[i])
  
  ####### set week
  # change Date class
  df$Date <- as.Date(df$Date, "%m/%d/%Y")
  
  ## initialize week vector
  wk <- c()
  
  ## for loop comparing the difference between each date to the first date of
  ## year
  ii <- 1
  for (ii in ii:nrow(df)) {
    dt_diff <- abs(as.integer(difftime(time1 = df[1, 1], time2 = df[ii, 1], units = "days")))
    wk <- append(wk, dt_diff)
  }
  # take integer of date diff values, add one (turn 0 to 1, etc)
  week <- as.integer((wk/7) + 1)
  
  ## combine week value to data frame
  df <- cbind(df, week)
  
  # create final data frame d
  if (i == 1){
    d <- df
  }
  else {
    d <- rbind_list(d, df)
  }
}

# clean up
rm(df, i, ii, week, wk, dt_diff)

# transform line so, for example, favorites are -3 (not +3)
d$Line <- d$Line * -1

# set Game.Result
d$Game.Result <- NA
d[(d$ScoreOff - d$ScoreDef) > 0, "Game.Result"] <- "Win"
d[(d$ScoreOff - d$ScoreDef) < 0, "Game.Result"] <- "Loss"
d[(d$ScoreOff - d$ScoreDef) == 0, "Game.Result"] <- "Tie"

# set ATS.Result
d$ATS.Result <- NA
d[((d$ScoreOff - d$ScoreDef) + d$Line) > 0, "ATS.Result"] <- "Win"
d[((d$ScoreOff - d$ScoreDef) + d$Line) < 0, "ATS.Result"] <- "Loss"
d[((d$ScoreOff - d$ScoreDef) + d$Line) == 0, "ATS.Result"] <- "Push"

write.table(d, paste0(file.loc, "nfldata.csv"), sep = ",", row.names = FALSE)
