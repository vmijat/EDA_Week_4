library(tidyverse)
library(ggplot2)


#let's import data into dataframes

scc <- readRDS("./_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./_data/summarySCC_PM25.rds")

str(summarySCC)


#calculate total emissions for all
total_emissions <- summarySCC %>% 
        filter(Pollutant == "PM25-PRI") %>% 
        group_by(year) %>% 
        summarise(total = sum(Emissions, na.rm = TRUE))

plot(x = total_emissions$year, y = total_emissions$total,
     pch = 25,
     xlab = "Year",
     ylim = c(0, 8e+06),
     ylab = "Total Emissions of PM 2.5",
     main = "Total Emissions of PM2.5 per Year",
)  
