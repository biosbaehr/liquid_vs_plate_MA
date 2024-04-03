rm(list=ls())

library(dplyr)
se <- function(x){sqrt(var(x)/length(x))}

myDF <- read.table("/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/all_mut_snm_removed_rep.txt", header=T, stringsAsFactors=F)

#myDF <- cbind(myDF, day=as.numeric(substr(myDF$line,2,3)) )
myDF <- cbind(myDF, lp=substr(myDF$line,1,1))
myDF <- cbind(myDF, rep=substr(myDF$line,2,3))

myDF <- cbind(myDF, mut_type_count=1)

#myDF <- subset(myDF, myDF$day>=20)

myDFByLine <- aggregate(cbind(line_count=mut_type_count)~lp+rep, data=myDF, FUN=sum)

myDFTypeByLine <- aggregate(mut_type_count~lp+rep+mut_type, data=myDF, FUN=sum)

myDFType <- aggregate(mut_type_count~lp+mut_type, data=myDF, FUN=sum)
myDFType <- myDFType[order(myDFType$lp, myDFType$mut_type),]

myDFTotalMutCount <- aggregate(cbind(total_count=mut_type_count)~lp, data=myDF, FUN=sum)

myDFType <- left_join(myDFType, myDFTotalMutCount, by="lp")
myDFType <- cbind(myDFType, prct=myDFType$mut_type_count/myDFType$total_count)

myDFMutCountByLine <- aggregate(mut_type_count~lp+rep, data=myDF, FUN=sum)

myDFMutCountByLineMean <- aggregate(mut_type_count~lp, data=myDFMutCountByLine, FUN=mean)
myDFMutCountByLineSE <- aggregate(cbind(se=mut_type_count)~lp, data=myDFMutCountByLine, FUN=se)
myDFMutCountByLineSampleSize <- aggregate(cbind(n=mut_type_count)~lp, data=myDFMutCountByLine, FUN=length)
myDFMutMeanSE <- left_join(myDFMutCountByLineMean, myDFMutCountByLineSE, by="lp")
myDFMutMeanSE <- left_join(myDFMutMeanSE, myDFMutCountByLineSampleSize, by="lp")

myDFTypeByLineMean <- aggregate(mut_type_count~lp+mut_type, data=myDFTypeByLine, FUN=mean)
myDFTypeByLineSE <- aggregate(cbind(se=mut_type_count)~lp+mut_type, data=myDFTypeByLine, FUN=se)
myDFTypeByLineMeanSE <- left_join(myDFMutCountByLineMean, myDFMutCountByLineSE, by="lp")
myDFTypeByLineMeanSE <- left_join(myDFMutMeanSE, myDFMutCountByLineSampleSize, by="lp")

write.table(myDFType, "/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/snm_count_mut_type.txt", quote = FALSE, row.names=F)