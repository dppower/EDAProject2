# PLot5

NEI <- readRDS("summarySCC_PM25.rds")

# Subset the data on Baltimore and by type = "ON-ROAD",
# which should include all motor vehicle sources

BMdata <- NEI[which(NEI$fips == "24510" & NEI$type == "ON-ROAD"),]

#Summarise the total emissions per type

Total.emissions5 <- ddply(BMdata, .(year), summarise, 
                          Total.emissions = sum(Emissions))



#Create the plot

library("ggplot2")

plot5 <- ggplot(data = Total.emissions5, aes(x = factor(year), y = Total.emissions, group = 1)) +
    geom_line() +
    labs(x = "Year", y = "Total emissions (tons)") +
    labs(title = expression(Total~motor~vehicle~emissions~per~year~"in"~Baltimore)) +
    theme_bw() +
    # Remove space at either side of graph
    scale_x_discrete(expand = c(0.05, 0.05))

# Save the plot as a .png file

png(file = "plot5.png")

print(plot5)

dev.off()