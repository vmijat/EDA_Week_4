library(tidyverse)
library(ggplot2)


#let's import data into dataframes

scc <- readRDS("./_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./_data/summarySCC_PM25.rds")


#6 Compare emissions from motor vehicle sources 
# in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California 
#(\color{red}{\verb|fips == "06037"|}fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?


total_emissions_Baltimore_LA_motor_vehicles <- summarySCC %>% 
        filter(fips %in% c("24510", "06037") & type == "ON-ROAD") %>% 
        group_by(year, fips) %>% 
        summarise(total = sum(Emissions, na.rm = TRUE))

names(total_emissions_Baltimore_LA_motor_vehicles) <- c("year", "county", "total")

total_emissions_Baltimore_LA_motor_vehicles$county <- factor(total_emissions_Baltimore_LA_motor_vehicles$county, 
                                                              levels = c("24510", "06037"),
                                                              labels = c("Baltimore City", "Los Angeles County"))

png("plot6.png",width=800,height=800,units="px",bg="transparent")

ggplot(data = total_emissions_Baltimore_LA_motor_vehicles, aes(x = year, y = total))+
        geom_bar(stat = "Identity", aes(fill = county), position = "dodge")

dev.off()
