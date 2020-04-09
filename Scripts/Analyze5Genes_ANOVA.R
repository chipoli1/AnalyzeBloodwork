# Homework submitted by Charmaine Hipolito
# The genes used in this project are CD8 T-cell
# These are CD8A, GZMM, CD8B, PRF1, FLT3LG

# Install necessary packages
# Install packages ("ggplot2")
install.packages("ggplot2")
library(ggplot2)

# Set working directory to Source File Location or Script folder

# Read data
IBS <- read.table("../Data/IBS_GX_Data.txt", sep = "\t", header = TRUE)

# GENE 1: CD8A
# ANOVA Test
CD8A.aov <- aov(CD8A ~ IBSsubtype, data=IBS)
summary(CD8A.aov)
sink('../Data_Output/CD8A_ANOVA.txt', append = TRUE)
print(CD8A.aov)
sink()

# Print Out a Boxplot
png("../Fig_Output/CD8A.png")
CD8A_boxplot <- boxplot(CD8A ~ IBSsubtype, data = IBS, main="CD8A by IBS subtype",
                          xlab = "IBSsubtype", ylab = "CD8A"
                          
)
print(CD8A_boxplot)
dev.off()



# GENE 2: GZMM
# ANOVA Test
GZMM.aov <- aov(GZMM ~ IBSsubtype, data=IBS)
summary(GZMM.aov)
sink('../Data_Output/GZMM_ANOVA.txt', append = TRUE)
print(GZMM.aov)
sink()

# Print Out a Boxplot
png("../Fig_Output/GZMM.png")
GZMM_boxplot <- boxplot(GZMM ~ IBSsubtype, data = IBS, main="GZMM by IBS subtype",
                        xlab = "IBSsubtype", ylab = "GZMM"
                        
)
print(GZMM_boxplot)
dev.off()



# GENE 3: CD8B
# ANOVA Test
CD8B.aov <- aov(CD8B ~ IBSsubtype, data=IBS)
summary(CD8B.aov)
sink('../Data_Output/CD8B_ANOVA.txt', append = TRUE)
print(CD8B.aov)
sink()

# Print Out a Boxplot
png("../Fig_Output/CD8B.png")
CD8B_boxplot <- boxplot(CD8B ~ IBSsubtype, data = IBS, main="CD8B by IBS subtype",
                        xlab = "IBSsubtype", ylab = "CD8B"
                        
)
print(CD8B_boxplot)
dev.off()



# GENE 4: PRF1
# ANOVA Test
PRF1.aov <- aov(PRF1 ~ IBSsubtype, data=IBS)
summary(PRF1.aov)
sink('../Data_Output/PRF1_ANOVA.txt', append = TRUE)
print(PRF1.aov)
sink()

# Print Out a Boxplot
png("../Fig_Output/PRF1.png")
PRF1_boxplot <- boxplot(PRF1 ~ IBSsubtype, data = IBS, main="PRF1 by IBS subtype",
                        xlab = "IBSsubtype", ylab = "PRF1"
                        
)
print(PRF1_boxplot)
dev.off()



# GENE 5: FLT3LG
# ANOVA Test
FLT3LG.aov <- aov(FLT3LG ~ IBSsubtype, data=IBS)
summary(FLT3LG.aov)
sink('../Data_Output/FLT3LG_ANOVA.txt', append = TRUE)
print(FLT3LG.aov)
sink()

# Print Out a Boxplot
png("../Fig_Output/FLT3LG.png")
FLT3LG_boxplot <- boxplot(FLT3LG ~ IBSsubtype, data = IBS, main="FLT3LG by IBS subtype",
                        xlab = "IBSsubtype", ylab = "FLT3LG"
                        
)
print(FLT3LG_boxplot)
dev.off()

