# BTEC330 PROJECT 2
## Submitted by Charmaine Hipolito
###### When opening this file in R, please set up working directory to AnalyzeSerumCortisol-master folder


# Install necessary packages

install.packages("ggplot2")
library(ggplot2)

# Read data
IBS <- read.csv("Data/RobinsonEtAl_Sup1.csv", header = TRUE)
head(IBS)
write.csv(IBS, "Data_Output/output.csv")

IBS$SerumCortisol_result <- "NA"

# Assign "HIGH", "NORMAL", or "LOW" based on clinical range to the SerumCortisol_result parameter
###### Range was obtained from https://emedicine.medscape.com/article/2088826-overview

IBS$SerumCortisol_result[IBS$SerumCortisol > 28] <- "HIGH"

IBS$SerumCortisol_result[IBS$SerumCortisol <= 28 & IBS$SerumCortisol >= 7] <- "NORMAL"

IBS$SerumCortisol_result[IBS$SerumCortisol < 7] <- "LOW"


#  Single Regressions for BMI vs. SerumCortisol
######  Data was obtained from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
######  http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
######  http://r-statistics.co/Linear-Regression.html

# Single Regression Test, BMI vs. SerumCortisol parameter
SerumCortisol.regression <- lm(BMI ~ SerumCortisol, data=IBS)
summary(SerumCortisol.regression)

# Output the results to a file
sink('Data_Output/SerumCortisol1.txt', append = TRUE)
print(SerumCortisol.regression)
sink()


# ANOVA: IBS-subtype vs. SerumCortisol parameter
###### http://www.sthda.com/english/wiki/one-way-anova-test-in-r
SerumCortisol.aov <- aov(SerumCortisol ~ IBS.subtype, data=IBS)
summary(SerumCortisol.aov)
sink('Data_Output/SerumCortisol1.txt', append = TRUE)
print(SerumCortisol.aov)
sink()

## Scatterplots
###### https://www.statmethods.net/graphs/scatterplot.html


ggplot(IBS, aes(x=BMI, y=SerumCortisol)) +
  geom_point() +    
  geom_smooth(method=lm) 

png("Fig_Output/Rplot.png")
SerumCortisol_scatterplot <- ggplot(IBS, aes(x = BMI, y = SerumCortisol)) +
  geom_point() +
  geom_smooth(method = lm)

print(SerumCortisol_scatterplot)
dev.off()


# Boxplots
###### https://www.statmethods.net/graphs/boxplot.html
SerumCortisol_boxplot <- boxplot(SerumCortisol ~ IBS.subtype, data = IBS, main="SerumCortisol by IBS subtype",
        xlab = "IBS.subtype", ylab = "SerumCortisol",
        col=(c("goldenrod1","lightcoral","plum2")),
        staplelwd = 3,
        staplecol = "sienna4",
        medcol = "sienna4",
        outpch = 10,
        outcol = "palevioletred4",
        outcex = 2,
        whisklty = 10,
        whiskcol = "salmon4"
        )
print(SerumCortisol_boxplot)
dev.off()


