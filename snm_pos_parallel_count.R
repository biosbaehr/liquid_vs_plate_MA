rm(list=ls())

myDF <- read.table("/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/all_mut_snm.txt", header=F, stringsAsFactors=F)
colnames(myDF) <- c("line","pos","ref","mut")

myDF <- cbind(myDF, count=1)

myDFCount <- aggregate(cbind(parallel_count=count)~pos+ref+mut, data=myDF, FUN=sum)
#myDFCount2 <- subset(myDFCount, count>=2)
myDFCount2 <- myDFCount
myDFCount2 <- myDFCount2[order(-myDFCount2$parallel_count, myDFCount2$pos),]

myDFPosCount <- aggregate(cbind(parallel_count=count)~pos, data=myDF, FUN=sum)
#myDFCount2 <- subset(myDFCount, count>=2)
myDFPosCount2 <- myDFPosCount
myDFPosCount2 <- myDFPosCount2[order(-myDFPosCount2$parallel_count, myDFPosCount2$pos),]

write.table(myDFCount2, "/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/snm_parallel_count.txt", quote = FALSE, row.names=F)
write.table(myDFPosCount2, "/Users/wei-chinho/Documents/growth_curve_SB/liquid_plate_ma/snm_pos_parallel_count.txt", quote = FALSE, row.names=F)
