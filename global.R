# read data
d <- read.csv("data/nfldata.csv")

# create vector of years
years <- unique(d$year)

# reorder factor levels for plot legend
d$Game.Result <- factor(d$Game.Result, levels = c("Win", "Loss", "Tie"))
d$ATS.Result <- factor(d$ATS.Result, levels = c("Win", "Loss", "Push"))