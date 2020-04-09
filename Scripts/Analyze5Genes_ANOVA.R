# Homework submitted by Charmaine Hipolito
# Set working directory to Scripts folder

# Install necessary packages
# Install packages ("ggplot2")
install.packages("ggplot2")
library(ggplot2)

# Read data
IBS <- read.table("../Data/IBS_GX_Data.txt", sep = "\t", header = TRUE)

# GENE 1: AKT3
# ANOVA Test
AKT3.aov <- aov(AKT3 ~ IBSsubtype, data=IBS)
summary(AKT3.aov)
sink('../Data_Output/AKT3_ANOVA.txt', append = TRUE)
print(AKT3.aov)
sink()

# Print Out a Boxplot
png("../Fig_Output/AKT3.png")
AKT3_boxplot <- boxplot(AKT3 ~ IBSsubtype, data = IBS, main="AKT3 by IBS subtype",
                          xlab = "IBSsubtype", ylab = "AKT3",
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
print(AKT3_boxplot)
dev.off()



# GENE 2: AGO2
# ANOVA Test
AGO2.aov <- aov(AGO2 ~ IBSsubtype, data=IBS)
summary(AGO2.aov)
sink('../Data_Output/AGO2_ANOVA.txt', append = TRUE)
print(AGO2.aov)
sink()

# Print Out a Boxplot
png("../Fig_Output/AGO2.png")
AGO2_boxplot <- boxplot(AGO2 ~ IBSsubtype, data = IBS, main="AGO2 by IBS subtype",
                        xlab = "IBSsubtype", ylab = "AGO2",
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
print(AGO2_boxplot)
dev.off()
