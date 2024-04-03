rm(list=ls())

library(dplyr)
se <- function(x){sqrt(var(x)/length(x))}

myDF <- read.table("/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/all_mut_snm_removed_rep.txt", header=T, stringsAsFactors=F)

#myDF <- cbind(myDF, day=as.numeric(substr(myDF$line,2,3)) )
myDF <- cbind(myDF, lp=substr(myDF$line,1,1))
myDF <- cbind(myDF, rep=substr(myDF$line,2,3))

myDF <- cbind(myDF, mut_spec_type_0 = paste0(myDF$ref,myDF$mut), stringsAsFactors=F)
myDF <- cbind(myDF, mut_spec_type = myDF$mut_spec_type_0, stringsAsFactors=F)

myDF$mut_spec_type[myDF$mut_spec_type=="AG"|myDF$mut_spec_type=="TC"] <- "AT2GC"
myDF$mut_spec_type[myDF$mut_spec_type=="AC"|myDF$mut_spec_type=="TG"] <- "AT2CG"
myDF$mut_spec_type[myDF$mut_spec_type=="AT"|myDF$mut_spec_type=="TA"] <- "AT2TA"
myDF$mut_spec_type[myDF$mut_spec_type=="GC"|myDF$mut_spec_type=="CG"] <- "GC2CG"
myDF$mut_spec_type[myDF$mut_spec_type=="GA"|myDF$mut_spec_type=="CT"] <- "GC2AT"
myDF$mut_spec_type[myDF$mut_spec_type=="GT"|myDF$mut_spec_type=="CA"] <- "GC2TA"

myDF <- cbind(myDF, spec_count=1)

#myDF <- subset(myDF, myDF$day>=20)

myDFByLine <- aggregate(cbind(line_count=spec_count)~lp+rep, data=myDF, FUN=sum)

myDFSpecByLine <- aggregate(spec_count~lp+rep+mut_spec_type, data=myDF, FUN=sum)

myDFSpec <- aggregate(spec_count~lp+mut_spec_type, data=myDF, FUN=sum)
myDFSpec <- myDFSpec[order(myDFSpec$lp, myDFSpec$mut_spec_type),]

myDFTotalMutCount <- aggregate(cbind(total_count=spec_count)~lp, data=myDF, FUN=sum)

myDFSpec <- left_join(myDFSpec, myDFTotalMutCount, by="lp")
myDFSpec <- cbind(myDFSpec, prct=myDFSpec$spec_count/myDFSpec$total_count)

myDFMutCount <- aggregate(spec_count~lp+rep, data=myDF, FUN=sum)

myDFMutCountMean <- aggregate(spec_count~lp, data=myDFMutCount, FUN=mean)
myDFMutCountSE <- aggregate(cbind(se=spec_count)~lp, data=myDFMutCount, FUN=se)
myDFMutCountSampleSize <- aggregate(cbind(n=spec_count)~lp, data=myDFMutCount, FUN=length)
myDFMutMeanSE <- left_join(myDFMutCountMean, myDFMutCountSE, by="lp")
myDFMutMeanSE <- left_join(myDFMutMeanSE, myDFMutCountSampleSize, by="lp")

myDFSpecByLineMean <- aggregate(spec_count~lp+mut_spec_type, data=myDFSpecByLine, FUN=mean)
myDFSpecByLineSE <- aggregate(cbind(se=spec_count)~lp+mut_spec_type, data=myDFSpecByLine, FUN=se)
myDFSpecByLineMeanSE <- left_join(myDFMutCountMean, myDFMutCountSE, by="lp")
myDFSpecByLineMeanSE <- left_join(myDFMutMeanSE, myDFMutCountSampleSize, by="lp")

write.table(myDFSpec, "/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/snm_count_spec.txt", quote = FALSE, row.names=F)