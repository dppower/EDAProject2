# PLot6

NEI <- readRDS("summarySCC_PM25.rds")

# Subset the data on Baltimore and by type = "ON-ROAD",
# which should include all motor vehicle sources. Same for LA.

BMdata <- NEI[which(NEI$fips == "24510" & NEI$type == "ON-ROAD"),]
BMdata$Area <- c("Baltimore City")

LAdata <- NEI[which(NEI$fips == "06037" & NEI$type == "ON-ROAD"),]
LAdata$Area <- c("LA County")

data1 <- rbind(BMdata, LAdata)

#Summarise the total emissions per type

Total.emissions6 <- ddply(data1, .(Area, year), summarise, 
                          Total.emissions = sum(Emissions))



#Create the plot

library("ggplot2")

plot6 <- ggplot(data = Total.emissions6, aes(x = factor(year), y = Total.emissions, group = Area, colour = Area)) +
    geom_line() +
    labs(x = "Year", y = "Total emissions (tons)") +
    labs(title = expression("Total motor vehicle emissions per year in \n Baltimore City and LA county")) +
    theme_bw() +
    # Remove space at either side of graph
    scale_x_discrete(expand = c(0.05, 0.05))

# Save the plot as a .png file

png(file = "plot6.png")

print(plot6)

dev.off()