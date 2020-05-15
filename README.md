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
###### Data obtained from [Robinson, et al. 2019](https://doi.org/10.1101/608208).
###### Information obtained from [STHDA](http://www.sthda.com/english/articles/40-regression-analysis/167-simple-linear-regression-in-r/), [R-Statistics](http://r-statistics.co/Linear-Regression.html).

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

______________________________________________________________________________________
______________________________________________________________________________________



# <p align="center"> **BTEC395 PROJECT** </p>
## <p align="center"> Data Transformation and Volcano Plots </p> 
###### <p align="center"> IMPORTANT NOTE: When opening the SerumCortisolGXVolcanoPlot.R script in R Studio, please set working directory to source file location. </p>
###### <p align="center"> Data & Information obtained from [Robinson, et al. 2019](https://doi.org/10.1101/608208), [BioStars](https://www.biostars.org/p/84487/), [R-Bloggers](https://www.r-bloggers.com/example-8-14-generating-standardized-regression-coefficients/), [Data Analytics](https://www.dataanalytics.org.uk/beta-coefficients-from-linear-models/), [StatMethods](https://www.statmethods.net/management/subset.html), [YouTube](https://www.youtube.com/watch?v=7RSHooCnrkk), [Science Matters](https://sciencematters.io/articles/201706000011). </p>


## About the project
##### [SerumCortisolFinalProject.R](https://github.com/chipoli1/AnalyzeSerumCortisol/blob/master/Scripts/SerumCortisolFinalProject.R) project will familiarize you with tasks necessary to produce differential expression results and a corresponding volcano plot.  These tasks include transforming data, handling data in R including extracting statistical results, combining rows and columns, writing FOR loops and IFELSE commands, and intermediate features of ggplot2.  You will become familiar with interpretation of volcano plots for displaying differential expression results. 




## Read in the table of fold changes
```
FCdata <- read.csv("../data/FCSerum.csv", row.names = 1, header = FALSE)
```



## Read in the table of expression data
```
IBS <- read.csv("../data/GXdata.csv", header = TRUE)
```

## Access only the columns with RNA Expression (subsetting)
```
names(IBS)[28:277]
```

## Make a list of anova(lm()) results for serum cortisol
###### Information obtained from [Stack Exchange](https://stats.stackexchange.com/questions/115304/interpreting-output-from-anova-when-using-lm-as-input).

```
storage <- list()

for(i in names(IBS)[28:277]){
  storage[[i]]  <- anova(lm(get(i) ~ Cortisol, IBS))
}

## Extract the p-values into a new list
pVals <- list()

for(i in names(storage)){
  pVals[[i]] <- -(log10(storage[[i]]$'Pr(>F)'))
}
```

## Convert the serum cortisol pValues list into a data frame. 
###### Information obtained from [Stack Overflow](https://stackoverflow.com/questions/4227223/convert-a-list-to-a-data-frame).
```
DFpvalues <- data.frame(matrix(unlist(pVals), nrow=length(pVals), byrow=T))
```

## Combine the results dataframes and write column labels
###### Information obtained from [StatMethods](https://www.statmethods.net/management/merging.html), [Stack Overflow](https://stackoverflow.com/questions/6081439/changing-column-names-of-a-data-frame).

```
VolcanoPlotData <- cbind(FCdata, DFpvalues)
names(VolcanoPlotData)[1] <- paste("log2(SlopeDiff)")
names(VolcanoPlotData)[2] <- paste("-log10(Pval)")
```

## Add a column to evaluate significance
###### Information obtained from [Stack Overflow](https://stackoverflow.com/questions/47764458/r-calculate-data-frame-and-assign-result-to-new-column)
```
VolcanoPlotData$Sig <- ifelse(VolcanoPlotData$`-log10(Pval)` > 1.3, "Sig", "Insig");
```

## Install necessary packages
```
install.packages("ggplot2")
library(ggplot2)
# library(ggrepel)
 ```
 
## Output the result of the serum cortisol volcano plot into Fig_Output folder
###### Information obtained from [STHDA](http://www.sthda.com/english/wiki/ggplot2-texts-add-text-annotations-to-a-graph-in-r-software), [Stack Overflow](https://stackoverflow.com/questions/52397363/r-ggplot2-ggrepel-label-a-subset-of-points-while-being-aware-of-all-points), [GGPlot2-Book](https://ggplot2-book.org/), [STHDA](http://www.sthda.com/english/wiki/ggplot2-scatter-plots-quick-start-guide-r-software-and-data-visualization), [Stack Overflow](https://stackoverflow.com/questions/15015356/how-to-do-selective-labeling-with-ggplot-geom-point), [R-Bloggers](https://www.r-bloggers.com/annotating-select-points-on-an-x-y-plot-using-ggplot2/), [STHDA](http://www.sthda.com/english/wiki/ggplot2-scatterplot-easy-scatter-plot-using-ggplot2-and-r-statistical-software).

```
png("../fig_output/SerumCortisolplot.png")
SerumCortisolplot <- ggplot(VolcanoPlotData, aes(x = `log2(SlopeDiff)`, y = `-log10(Pval)`, label=rownames(VolcanoPlotData), color=Sig)) +
  geom_point(aes(color = Sig)) +
  scale_color_manual(values = c("grey", "red")) +
  theme_bw(base_size = 12) + theme(legend.position = "bottom") +
  geom_text(aes(x = `log2(SlopeDiff)`,y = `-log10(Pval)`, fontface = 1, size=3,  label=row.names(VolcanoPlotData)))
  

print(SerumCortisolplot + ggtitle("Gene Expression vs. Serum Cortisol Level"))
dev.off()
```
### <p align="center"> Volcano Plot </p>

<p align="center">
  <img width="500" height="500" src="../master/Images/SerumCortisolplot.png">
</p>

## List all the differentially expressed/significant genes
### Significant Genes for Serum Cortisol 
###### Information obtained from [Gene Cards](https://www.genecards.org/) 


|***GENE***|***ALIAS***|
|:--:|:-------|
|**BHLHE40**|Basic Helix-Loop-Helix Family Member E40|
|**BTNL3**|Butyrophilin Like 3|
|**CD1E**|T-Cell Surface Glycoprotein CD1e, Membrane-Associated|
|**CD274**|Programmed Cell Death 1 Ligand 1|
|**CD4**|T-Cell Surface Antigen T4/Leu-3|
|**Ddit4**|DNA Damage Inducible Transcript 4|
|**Dusp5**|Dual Specificity Phosphatase 5|
|**Fzd4**|Frizzled Class Receptor 4|
|**IL4**|Interleukin 4|
|**KIT**|KIT Proto-Oncogene, Receptor Tyrosine Kinase|
|**MSR1**|Macrophage Scavenger Receptor 1|
|**RAB8B**|RAB8B, Member RAS Oncogene Family|
|**Tnfaip2**|Tumor Necrosis Factor Alpha-Induced Protein 2|


## Gene ontology analysis for the significant genes
##### Gene Ontology is a classification system that classifies the genes by its biological processes, cellular components, and molecular functions. [GOAnalysis.txt](https://github.com/chipoli1/AnalyzeSerumCortisol/blob/master/Documents/GoAnalysis.txt) interprets the differential gene expression results in order to provide a better biological meaning of these results. 
###### Data & Information obtained from [Panther](http://pantherdb.org/) & [GeneOntology](http://geneontology.org/docs/ontology-documentation/).

###### Analysis Type:	PANTHER Overrepresentation Test (Released 20200407)</br>
###### Annotation Version and Release Date:	PANTHER version 15.0 Released 2020-02-14</br>
###### Analyzed List:	Client Text Box Input (Homo sapiens)</br>
###### Reference List:	Homo sapiens (all genes in database)</br>
###### Test Type:	FISHER</br>
###### Correction: NONE


|PANTHER Pathways|Homo Sapiens REF#|Client Text Input (CTI) #|CTI Expected|CTI Fold Enrichment|CTI +/-|CTI Raw P value|
|----------------|-|-|--------|---------------|---|-----------|
|Oxidative stress response|55|1|.03|29.16|+|3.43E-02|

> ##### **PATHWAY DESCRIPTION:** Oxidative stress is a pathogenic condition that causes cellular damage. In a normal functioning cell, several transcription factors respond to this threat by modulating expression of genes whose products relieve the altered redox status. This pathway illustrates some of the intracellular signalling response regulating such gene expression (*[GeneOntology](http://pantherdb.org/pathway/pathDetail.do?clsAccession=P00046)*).
