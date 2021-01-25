library(tidyverse)
library(ggplot2)


#let's import data into dataframes

scc <- readRDS("./_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./_data/summarySCC_PM25.rds")



#5 
# How have emissions from motor vehicle sources 
# changed from 1999–2008 in Baltimore City?



#motor vehicles related levels are 43 - 52

motor_vehicles_levels <- scc[scc$EI.Sector == levels(scc$EI.Sector)[43:52], ]

#let's create join - to have subset only with motor_vehicles_levels

motor_vehicles_emissions <- inner_join(summarySCC, 
                                       motor_vehicles_levels, 
                                       by = "SCC")



total_emissions_Baltimore_motor_vehicles <- motor_vehicles_emissions %>% 
        filter(fips == "24510") %>% 
        group_by(year, type) %>% 
        summarise(total = sum(Emissions, na.rm = TRUE))

png("plot5.png",width=800,height=800,units="px",bg="transparent")

ggplot(data = total_emissions_Baltimore_motor_vehicles, aes(x = year,
                                                            y = total,
)) +
        geom_bar(stat = "Identity", aes(fill = type)) +
        geom_smooth(se = FALSE) 


dev.off()
