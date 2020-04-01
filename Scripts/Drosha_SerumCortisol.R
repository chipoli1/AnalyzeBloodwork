# Set working directory to AnalyzeSerumCortisol-master

# Install necessary packages
# Install packages ("ggplot2")
install.packages("ggplot2")
library(ggplot2)

# Read data
IBS <- read.table("Data/IBS_GX_Data.txt", sep = "\t", header = TRUE)

# Single Regression Test
SerumCortisol.regression <- lm(DROSHA ~ Serum.Cortisol..ug.dL., data=IBS)
summary(SerumCortisol.regression)

# Scatterplot
ggplot(IBS, aes(x=DROSHA, y=Serum.Cortisol..ug.dL.)) +
  geom_point() +    
  geom_smooth(method=lm) 
