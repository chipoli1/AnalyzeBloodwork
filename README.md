
# <p align="center"> **BTEC330 PROJECT 2** </p>

## <p align="center"> *Submitted by Charmaine Hipolito* </p>

# Serum Cortisol Parameter  
#### *What does the serum cortisol parameter in a CBC blood test tell you?*
> ##### A cortisol test is used to help diagnose disorders of the adrenal gland. It does so by measuring the blood level of a stress hormone called cortisol.

#### *What is the normal range for serum cortisol?*  
> ##### The normal range for serum cortisol (in the mornings) is 7-28 μg/dL.

###### https://medlineplus.gov/lab-tests/cortisol-test/
###### https://emedicine.medscape.com/article/2088826-overview


# Install necessary packages
```
install.packages("ggplot2")
library(ggplot2)
df<-na.omit(IBS)
```

# Read data
```
IBS <- read.csv("Data/RobinsonEtAl_Sup1.csv", header = TRUE)
head(IBS)
write.csv(IBS, "Data_Output/output.csv")

IBS$SerumCortisol_result <- "NA"
```

# Assign "HIGH", "NORMAL", or "LOW" based on clinical range to the SerumCortisol_result parameter
###### Range was obtained from https://emedicine.medscape.com/article/2088826-overview

```
IBS$SerumCortisol_result[IBS$SerumCortisol > 28] <- "HIGH"

IBS$SerumCortisol_result[IBS$SerumCortisol <= 28 & IBS$SerumCortisol >= 7] <- "NORMAL"

IBS$SerumCortisol_result[IBS$SerumCortisol < 7] <- "LOW"
```

#  Single Regressions for BMI vs. SerumCortisol
###### Data was obtained from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
###### http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
###### http://r-statistics.co/Linear-Regression.html

# Single Regression Test, BMI vs. SerumCortisol
```
SerumCortisol.regression <- lm(BMI ~ SerumCortisol, data=IBS)
summary(SerumCortisol.regression)
```

# Output the results to a file
```
sink('Data_Output/SerumCortisol1.txt', append = TRUE)
print(SerumCortisol.regression)
sink()
```


# ANOVA: IBS-subtype vs. SerumCortisol 
###### http://www.sthda.com/english/wiki/one-way-anova-test-in-r
```
SerumCortisol.aov <- aov(SerumCortisol ~ IBS.subtype, data=IBS)
summary(SerumCortisol.aov)
sink('Data_Output/SerumCortisol1.txt', append = TRUE)
print(SerumCortisol.aov)
sink()
```

# Scatterplots
###### https://www.statmethods.net/graphs/scatterplot.html
```
ggplot(IBS1, aes(x=BMI, y=SerumCortisol)) +
  geom_point() +    
  geom_smooth(method=lm) 
```
```
png("Fig_Output/Rplot.png")
SerumCortisol_scatterplot <- ggplot(IBS, aes(x = BMI, y = SerumCortisol)) +
  geom_point() +
  geom_smooth(method = lm)

print(SerumCortisol_scatterplot)
dev.off()
```
<p align="center">
  <img width="410" height="500" src="../master/Images/Rplot02.png">
</p>
  

# Boxplots
###### https://www.statmethods.net/graphs/boxplot.html
```
SerumCortisol_boxplot <- boxplot(SerumCortisol ~ IBS.subtype, data = IBS, main="SerumCortisol by IBS subtype",
        xlab = "IBS.subtype", ylab = "SerumCortisol"
        )
print(SerumCortisol_boxplot)
dev.off()
```
<p align="center">
  <img width="410" height="500" src="../master/Images/Boxplot.png">
</p>


