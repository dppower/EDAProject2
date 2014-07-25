#Plot 4

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Examine the data:
# length(unique(SCC[,7]))
# table(unique(SCC[,7]))
# ...
# g1 <- grep("[cC][oO][aA][lL]", SCC[,9], value = T)
# g2 <- grep("[bB][iI][tT][uU]|[aA][nN][tT][hH]", SCC[,9], value = T)
# g3 <- grep("^[cC][oO][aA][lL]$", SCC[,9], value = T)
# Main sources are bituminous and anthracite coal

# g2 <- grep("[bB][iI][tT][uU]|[aA][nN][tT][hH]", SCC[,9])
# c1 <- SCC[g2, 8]
# df1 <- data.frame(table(c1))
# df1 <- df1[which(df1$Freq > 0), ]


g <- grep("[bB][iI][tT][uU]|[aA][nN][tT][hH]", SCC[,9])
df1 <- data.frame(SCC = as.character(SCC[g, 1]))

# Function to assign a source of emissions given a SCC code
Sources <- function(x){
    output <- as.character(SCC[which(as.character(SCC[,1]) %in% x), 8])
    return(output)
}

coalNEI <- NEI[which(NEI$SCC %in% df1[,1]),]

library("plyr")

coalNEI <- ddply(coalNEI, .(SCC, year), summarise, emissions = sum(Emissions), sources = Sources(SCC))

coalNEI <- ddply(coalNEI, .(year, sources), summarise, total = sum(emissions))

# Remove some small, less meaningful groupings
df2 <- coalNEI[-grep("Area", coalNEI$sources),]
df2 <- df2[-grep("n-p", df2$sources),]

#Create the plot

library("ggplot2")

plot4 <- ggplot(df2, aes(x = factor(year), y = total / 1000, group = sources, colour = sources)) +
            geom_line() + theme_bw() +
            scale_x_discrete(expand = c(0,0)) + 
            labs(x = "Year", y = "Total emissions (1000 tons)") + 
            labs(title = "Total emissions from coal combustion sources per year")

#Save plot as a .png file

png("plot4.png")

print(plot4)

dev.off()