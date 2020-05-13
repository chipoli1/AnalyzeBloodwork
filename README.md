# <p align="center"> **BTEC330 PROJECT 2** </p>

### <p align="center"> *Submitted by Charmaine Hipolito* </p>

###### <p align="center"> IMPORTANT NOTE: When opening the AnalyzeSerumCortisol.R script in R Studio, please set working directory to source file location. </p>

## About the project
##### [AnalyzeSerumCortisol.R](https://github.com/chipoli1/AnalyzeSerumCortisol/blob/master/Scripts/AnalyzeSerumCortisol.R) will allow you to load a comma-delimited .csv with various datapoints, perform single regressions of Body Mass Index (BMI) vs. Serum Cortisol from the complete blood count with differential (CBC-D) results, and produce 2-D scatterplots, and boxplots for the results.

## Serum cortisol parameter  
### *What does the serum cortisol parameter in a CBC blood test tell you?*
###### Information obtained from [MedLinePlus](https://medlineplus.gov/lab-tests/cortisol-test/). 
> #### A cortisol test is used to help diagnose disorders of the adrenal gland. It does so by measuring the blood level of a stress hormone called cortisol. Cortisol plays an important role in stress response, infection control, blood sugar regulation, blood pressure maintenance, and metabolic regulation.


### *What is the normal range for serum cortisol?*
###### Information obtained from [Medscape](https://emedicine.medscape.com/article/2088826-overview). 
> #### The normal range for serum cortisol (in the mornings when cortisol levels are at their highest) is 7-28 μg/dL.




## Install necessary packages
```
install.packages("ggplot2")
library(ggplot2)

```

## Read data
```
IBS <- read.csv("Data/RobinsonEtAl_Sup1.csv", header = TRUE)
head(IBS)
write.csv(IBS, "Data_Output/output.csv")
df<-na.omit(IBS)
IBS$SerumCortisol_result <- "NA"
```

## Assign "HIGH", "NORMAL", or "LOW" based on clinical range to the SerumCortisol_result parameter
###### Range obtained from [Medscape](https://emedicine.medscape.com/article/2088826-overview).

```
IBS$SerumCortisol_result[IBS$SerumCortisol > 28] <- "HIGH"

IBS$SerumCortisol_result[IBS$SerumCortisol <= 28 & IBS$SerumCortisol >= 7] <- "NORMAL"

IBS$SerumCortisol_result[IBS$SerumCortisol < 7] <- "LOW"
```

##  Single regression test for BMI vs. SerumCortisol
###### Data obtained from [Robinson, et al. 2019](https://doi.org/10.1101/608208), [STHDA](http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/), [R-Statistics](http://r-statistics.co/Linear-Regression.html).

```
SerumCortisol.regression <- lm(BMI ~ SerumCortisol, data=IBS)
summary(SerumCortisol.regression)
```

## Output the results to a file
###### Information obtained from [Cookbook-R](http://www.cookbook-r.com/Data_input_and_output/Writing_text_and_output_from_analyses_to_a_file/).
```
sink('Data_Output/SerumCortisol1.txt', append = TRUE)
print(SerumCortisol.regression)
sink()
```


## ANOVA: IBS-subtype vs. SerumCortisol 
###### Information obtained from [STHDA](http://www.sthda.com/english/wiki/one-way-anova-test-in-r).
```
SerumCortisol.aov <- aov(SerumCortisol ~ IBS.subtype, data=IBS)
summary(SerumCortisol.aov)
sink('Data_Output/SerumCortisol1.txt', append = TRUE)
print(SerumCortisol.aov)
sink()
```

## Print scatterplot and box plot as .png files into "fig_output" project directory.
###### Information obtained from [STHDA](http://www.sthda.com/english/wiki/ggsave-save-a-ggplot-r-software-and-data-visualization).

### <p align="center"> Scatterplots </p>
###### <p align="center"> Information obtained from [Stat Methods](https://www.statmethods.net/graphs/scatterplot.html). </p>
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
  

### <p align="center"> Boxplots </p>
###### <p align="center"> Information obtained from [Stat Methods](https://www.statmethods.net/graphs/boxplot.html). </p>
```
SerumCortisol_boxplot <- boxplot(SerumCortisol ~ IBS.subtype, data = IBS, main="SerumCortisol by IBS subtype",
        xlab = "IBS.subtype", ylab = "SerumCortisol"
        )
print(SerumCortisol_boxplot)
dev.off()
```
<p align="center">
  <img width="410" height="500" src="../master/Images/Boxplot2.png">
</p>


## <p align="center"> Data Transformation and Volcano Plots </p>
###### <p align="center"> IMPORTANT NOTE: When opening the AnalyzeSerumCortisol.R script in R Studio, please set working directory to source file location. </p>

## Read in the table of fold changes
```FCdata <- read.csv("../data/FCSerum.csv", row.names = 1, header = FALSE)```

## Read in the table of expression data
```IBS <- read.csv("../data/GXdata.csv", header = TRUE)```

## Access only the columns with RNA Expression (subsetting)
```names(IBS)[28:277]``

## Make a list of anova(lm()) results for bloodwork parameter
```storage <- list()

for(i in names(IBS)[28:277]){
  storage[[i]]  <- anova(lm(get(i) ~ Cortisol, IBS))
}

## Extract the p-values into a new list
pVals <- list()

for(i in names(storage)){
  pVals[[i]] <- -(log10(storage[[i]]$'Pr(>F)'))
}
```

## Convert the pValues list into a data frame. 
```DFpvalues <- data.frame(matrix(unlist(pVals), nrow=length(pVals), byrow=T))```

## Combine the results dataframes and write column labels
```VolcanoPlotData <- cbind(FCdata, DFpvalues)
names(VolcanoPlotData)[1] <- paste("log2(SlopeDiff)")
names(VolcanoPlotData)[2] <- paste("-log10(Pval)")
```

## Add a column to evaluate significance
```VolcanoPlotData$Sig <- ifelse(VolcanoPlotData$`-log10(Pval)` > 1.3, "Sig", "Insig");```
  
## Make a volcano-style scatterplot for these results
```install.packages("ggplot2")
library(ggplot2)
# library(ggrepel)
```
```
png("../fig_output/IL10plot.png")
IL10plot <- ggplot(VolcanoPlotData, aes(x = `log2(SlopeDiff)`, y = `-log10(Pval)`, label=rownames(VolcanoPlotData), color=Sig)) +
  geom_point(aes(color = Sig)) +
  scale_color_manual(values = c("grey", "red")) +
  theme_bw(base_size = 12) + theme(legend.position = "bottom") +
  geom_text(aes(x = `log2(SlopeDiff)`,y = `-log10(Pval)`, fontface = 1, size=3,  label=row.names(VolcanoPlotData)))
  

print(IL10plot + ggtitle("Gene Expression vs. IL-10 Level"))
dev.off()
```


