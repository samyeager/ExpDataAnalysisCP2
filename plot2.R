## Plots the PM2.5 emissions versus year (1999~2008)
## using the base system
## for Baltimore (fips == 24510)
## in the 'summarySCC_PM25.rds' dataset.

## Assumes 'summarySCC_PM25.rds' and 'Source_Classification_Code.rds' are
## in the working directory.

plot2 <- function() {
    
    # install a special package which aggregates columns faster, with filtering
    library("data.table")
    
    # read and condition the data
    DT <- data.table(readRDS("summarySCC_PM25.rds"))
    
    # this file is not needed for this plot
    # SCCodes <- readRDS("Source_Classification_Code.rds")
    
    totalEmissions <- DT[fips == "24510", 
                         list(fips = levels(factor(fips)), Emissions = sum(Emissions)), 
                         by = year
                        ]
    
    # open the file device and plot
    png(file = "plot2.png")
    with(totalEmissions, {
        plot(year, Emissions, type = "b", lty = 2, 
             main = "Total Emissions in Baltimore \nfrom 1999 to 2008",
             xlab = "Year", 
             xlim = c(1998, 2009), xaxp = c(1999, 2008, 3),
             ylab = "Total Emissions (tons)",  
             )
    })
    
    #close the file device  
    dev.off()
}