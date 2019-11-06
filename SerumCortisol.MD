# BTEC330 Hipolito Project2

## Install necessary packages
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
```

#  Single Regressions for BMI vs. SerumCortisol
###### Data was obtained from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
###### http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
###### http://r-statistics.co/Linear-Regression.html

# Single Regression Test, BMI vs. SerumCortisol parameter
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


# ANOVA: IBS-subtype vs. SerumCortisol parameter
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

# Boxplots
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

