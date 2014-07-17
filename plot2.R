# Plot2 

NEI <- readRDS("summarySCC_PM25.rds")

BMdata <- NEI[which(NEI$fips == "24510"),]

library("plyr")

Total.emissions2 <- ddply(BMdata, .(year), summarise, 
                                 Total.emissions = sum(Emissions))

png(file = "plot2.png")

with(Total.emissions2, plot(year, Total.emissions, type = "l",
                                   xlab = "Year", ylab = "Total emissions (tons)",
                                   main = expression(Total~emissions~of~pm["2.5"]~per~year~"in"~Baltimore),
                                   xaxt = "n"))

axis(1, at = c("1999", "2002", "2005", "2008"), labels = c("1999", "2002", "2005", "2008"))

dev.off()