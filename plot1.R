## Plots the PM2.5 emissions versus year (1999~2008)
## using the base system
## for all sources (fips == *)
## in the 'summarySCC_PM25.rds' dataset.

## Assumes 'summarySCC_PM25.rds' and 'Source_Classification_Code.rds' are
## in the working directory.

plot1 <- function() {
    
    # install a special package which aggregates columns faster, with filtering
    library("data.table")
    
    # read and condition the data
    DT <- data.table(readRDS("summarySCC_PM25.rds"))
    
    # this file is not needed for this plot
    # SCCodes <- readRDS("Source_Classification_Code.rds")
    
    totalEmissions <- DT[, list(Emissions = sum(Emissions)), by = year]
    
    # open the file device and plot
    png(file = "plot1.png")
    with(totalEmissions, {
        plot(year, Emissions, type = "b", lty = 2, 
             main = "Total Emissions from 1999 to 2008",
             xlab = "Year", xaxt = "n", 
             xlim = c(1998, 2009), xaxp = c(1999, 2008, 4),
             ylab = "Total Emissions (tons)",  
             yaxt = "n", yaxs = "i", 
             ylim = c(2500000, 8500000), yaxp = c(3000000, 8000000, 5),
             )
        axis(1, at = years, labels = years)
        axis(2, at = 1000000*c(1:6) + 2000000, cex.axis = 1)
        grid(NA, 12, col = "gray", lty = 1)
    })
    
    #close the file device  
    dev.off()
}