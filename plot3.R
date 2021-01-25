library(tidyverse)
library(ggplot2)


#let's import data into dataframes

scc <- readRDS("./_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./_data/summarySCC_PM25.rds")

str(summarySCC)



#different sources (point, nonpoint, onroad, nonroad) - 
# which one has decreased?

total_emissions_Baltimore_per_type <- summarySCC %>% 
        filter(fips == "24510") %>% 
        filter(Pollutant == "PM25-PRI") %>% 
        group_by(year, type) %>% 
        summarise(total = sum(Emissions, na.rm = TRUE))

png("plot3.png",width=800,height=800,units="px",bg="transparent")

ggplot(data = total_emissions_Baltimore_per_type, aes(x = year, 
                                                      y = total,
                                                      color = type)) +
        geom_point() +
        geom_smooth() +
        facet_wrap(.~type) 
        

dev.off()

#cliearly, NON-ROAD, NON-POINT and ON-ROAD have decreased

