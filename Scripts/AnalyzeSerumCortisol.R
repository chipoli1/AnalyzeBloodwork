# BTEC330 PROJECT 2
## Submitted by Charmaine Hipolito
###### IMPORTANT NOTE: When opening the AnalyzeSerumCortisol.R script in R Studio, please set working directory to AnalyzeSerumCortisol-master folder in order for the code to work

# Install necessary packages
install.packages("ggplot2")
library(ggplot2)

# Read data
IBS <- read.csv("Data/RobinsonEtAl_Sup1.csv", header = TRUE)
head(IBS)
write.csv(IBS, "Data_Output/output.csv")

IBS$SerumCortisol_result <- "NA"

# Assign "HIGH", "NORMAL", or "LOW" based on clinical range to the SerumCortisol_result parameter
## The normal range for serum cortisol (in the mornings) is 7-28 μg/dL
###### Range was obtained from https://emedicine.medscape.com/article/2088826-overview

IBS$SerumCortisol_result[IBS$SerumCortisol > 28] <- "HIGH"

IBS$SerumCortisol_result[IBS$SerumCortisol <= 28 & IBS$SerumCortisol >= 7] <- "NORMAL"

IBS$SerumCortisol_result[IBS$SerumCortisol < 7] <- "LOW"


# Single Regressions for BMI vs. SerumCortisol
######  Data was obtained from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
######  http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
######  http://r-statistics.co/Linear-Regression.html

# Single Regression Test, BMI vs. SerumCortisol parameter
SerumCortisol.regression <- lm(BMI ~ SerumCortisol, data=IBS)
summary(SerumCortisol.regression)

# Output the results to a file
###### http://www.cookbook-r.com/Data_input_and_output/Writing_text_and_output_from_analyses_to_a_file/
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

## Print scatterplot and box plots as .png files into "fig_output" project directory.
###### http://www.sthda.com/english/wiki/ggsave-save-a-ggplot-r-software-and-data-visualization

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
        col=(c("goldenrod1","lightcoral","plum2"))
        )
print(SerumCortisol_boxplot)
dev.off()


