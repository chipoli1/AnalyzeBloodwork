## BTEC330 Hipolito Project2

## Install necessary packages
```
install.packages("ggplot2")
library(ggplot2)
df<-na.omit(IBS1)

## Read data
IBS1 <- read.csv("Data/RobinsonEtAl_Sup1.csv", header = TRUE)
head(IBS1)
write.csv(IBS1, "Data_Output/output.csv")
```

##  Single Regressions for BMI vs. SerumCortisol
##  Data was obtained from Robinson, et al. 2019 (doi: https://doi.org/10.1101/608208)
##  https://statquest.org/2017/10/30/statquest-multiple-regression-in-r/
##  http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/
##  http://r-statistics.co/Linear-Regression.html
```
## Single Regression Test
single.regression <- lm(BMI ~ SerumCortisol, data=IBS1)
summary(single.regression)
```

## Scatterplots
## https://www.statmethods.net/graphs/scatterplot.html

```
ggplot(IBS1, aes(x=BMI, y=SerumCortisol)) +
  geom_point() +    
  geom_smooth(method=lm) 
```

