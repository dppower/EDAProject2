# Plot 3

NEI <- readRDS("summarySCC_PM25.rds")

#Subset the data on Baltimore

BMdata <- NEI[which(NEI$fips == "24510"),]

#Summarise the total emissions per type

Total.emissions3 <- ddply(BMdata, .(year, type), summarise, 
                                 Total.emissions = sum(Emissions))

#Tidy up the labels

Total.emissions3$type <- ordered(Total.emissions3$type, 
                                 levels = c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"),
                                 labels = c("point", "non-point", "on-road", "non-road"))

#Create the plot

library("ggplot2")

plot3 <- ggplot(data = Total.emissions3, aes(x = factor(year), y = Total.emissions, colour = type, group = type)) +
                    geom_line() +
                    labs(x = "Year", y = "Total emissions (tons)") +
                    labs(title = expression(Total~emissions~of~pm["2.5"]~per~year~"in"~Baltimore~by~type)) +
                    theme_bw() +
                    # Remove space at either side of graph
                    scale_x_discrete(expand = c(0.05, 0.05))

# Save the plot as a .png file

png(file = "plot3.png")

print(plot3)

dev.off()
                    