## BTEC330 Hipolito Project2

library("ggplot2")

data <- read.csv("data/RobinsonEtAl_Sup1.csv")
df<-na.omit(IBS1)

#Single Regression for BMI vs. SerumCortisol

single.regression <- lm(BMI ~ SerumCortisol, data=IBS1)
summary(single.regression)
print(single.regression)

ggplot(IBS1, aes(x=BMI, y=SerumCortisol)) +
  geom_point() +
  geom_smooth(method=lm) 

png("Rplot01.png")
