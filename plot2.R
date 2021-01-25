library(tidyverse)
library(ggplot2)


#let's import data into dataframes

scc <- readRDS("./_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./_data/summarySCC_PM25.rds")

str(summarySCC)


#total emissions for Baltimore City (fips == "24510")

total_emissions_Baltimore <- summarySCC %>% 
        filter(fips == "24510") %>% 
        filter(Pollutant == "PM25-PRI") %>% 
        group_by(year) %>% 
        summarise(total = sum(Emissions, na.rm = TRUE))


plot(x = total_emissions_Baltimore$year, y = total_emissions_Baltimore$total,
     xlab = "Year",
     ylab = "Total Emissions of PM 2.5",
     ylim = c(0, 3400),
     main = "Total Emissions of PM2.5 in Baltimore City per Year")  

