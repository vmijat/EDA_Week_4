library(tidyverse)
library(ggplot2)


#let's import data into dataframes

scc <- readRDS("./_data/Source_Classification_Code.rds")
summarySCC <- readRDS("./_data/summarySCC_PM25.rds")

str(summarySCC)


# 4 
# Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999–2008?



coal_levels <- scc %>% 
        filter(grepl("Coal", Short.Name, ignore.case = TRUE),
               grepl("Coal", EI.Sector, ignore.case = TRUE))
dim(coal_levels)


coal_data_frame <- inner_join(summarySCC, coal_levels, by = "SCC")
dim(coal_data_frame)
coal_data_frame <- coal_data_frame %>% 
        group_by(year, type) %>% 
        summarize(total = sum(Emissions, na.rm = TRUE))

png("plot4.png",width=800,height=800,units="px",bg="transparent")

ggplot(data = coal_data_frame, aes(x = year,
                                   y = total), color = "black") +
        geom_bar(stat = "Identity", aes(fill = type)) + 
        labs(
                x = "Year",
                y = "Total Emissions",
                title = "Total Coal-related emissions"
        ) 
        


dev.off()
