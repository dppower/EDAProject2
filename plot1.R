# Plot1

NEI <- readRDS("summarySCC_PM25.rds")

# Summarise the total emissions by year
library("plyr")
Total.emissions.by.year <- ddply(NEI, .(year), summarise, 
                                 Total.emissions = sum(Emissions))

png(file = "plot1.png")

with(Total.emissions.by.year, plot(year, Total.emissions / 10^6, type = "l",
                                   xlab = "Year", ylab = "Total emissions (millions tons)",
                                   main = expression(Total~emissions~of~pm["2.5"]~per~year),
                                   xaxt = "n"))

axis(1, at = c("1999", "2002", "2005", "2008"), labels = c("1999", "2002", "2005", "2008"))

dev.off()
