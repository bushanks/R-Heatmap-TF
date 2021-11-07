##generate heatmap for COVID data.  
##In order for this to work:
## 1. Place the qpcr export file in C:\\R
## 2. save as "HBN.CSV" 

HBN <- c(2937753
         )

#load libraries
library(dplyr)
library(readxl)
library(platetools)
library(ggplot2)

for(batch in HBN){
    #load file and subset data
    setwd("C:\\R")
    covid <- read.csv(paste(batch, "csv", sep = "."), skip = 12)
    covid <- subset(covid, grepl(paste('B=', batch, sep = ''), Sample.Name))
    
    
    #create plot for N, ORF, and S viral targets
    N <- raw_map(data = as.numeric(covid$N.gene.Ct),
                 well = covid$Well, 
                 plate = 384)
    
    ORF <- raw_map(data = as.numeric(covid$ORF1ab.Ct),
                   well = covid$Well, 
                   plate = 384)
    
    S <- raw_map(data = as.numeric(covid$S.gene.Ct),
                 well = covid$Well, 
                 plate = 384)
    
    #print heatmaps to .png
    png(filename = paste(batch, " - N - 96.png", sep = ""))
    print(N + ggtitle(paste(batch, " - N", sep = "")))
    dev.off()
    
    png(filename = paste(batch, " - ORF - 96.png", sep = ""))
    print(ORF + ggtitle(paste(batch, " - ORF", sep = "")))
    dev.off()
    
    png(filename = paste(batch, " - S - 96.png", sep = ""))
    print(S + ggtitle(paste(batch, " - S", sep = "")))
    dev.off()
}