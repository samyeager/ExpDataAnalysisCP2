## Plots the PM2.5 emissions versus year (1999~2008) by source type
## using the ggplot2 system
## for Baltimore (fips == 24510)
## in the 'summarySCC_PM25.rds' dataset.

## Assumes 'summarySCC_PM25.rds' and 'Source_Classification_Code.rds' are
## in the working directory.

plot3 <- function() {
    
    library("ggplot2")
    library("data.table") # a special package which aggregates columns faster, with filtering
    
    # read and condition the data
    DT <- data.table(readRDS("summarySCC_PM25.rds"))
    
    # this file is not needed for this plot
    # SCCodes <- readRDS("Source_Classification_Code.rds")
    
    totalEmissions <- DT[fips == "24510",
                         list(fips = levels(factor(fips)), 
                              type = levels(factor(type)),
                              Emissions = sum(Emissions)), 
                         by = list(year, type)
                        ]
    types <- levels(factor(totalEmissions$type))
    
    # open the file device and plot
    png(file = "plot3.png")    
    with(totalEmissions, {
        g <- ggplot(totalEmissions, aes(year, Emissions, color = type))        
        g + geom_path() + labs(x = "Year", y = "Total Emissions (tons)") + ggtitle("Total Emissions in Baltimore\n by type, 1999-2008")
    })

    # close the file device  
    dev.off()
}