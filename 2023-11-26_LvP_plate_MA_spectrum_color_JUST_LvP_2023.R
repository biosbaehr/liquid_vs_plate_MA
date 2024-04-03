# This makes an acceptable graph detailing mutation rates with confidence intervals

rm(list = ls())
library(readxl)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(ggtext)

brewer.pal(6, "Dark2")
#"C:\Users\baehr\Desktop\LynchLab\Somatic Mutation\2023-07-18_mutation_spectrum_liquid_plate_combined_color.xlsx"
# PLATE will be orange, #D95F02

mutspec <- read_excel("C:/Users/baehr/Desktop/LynchLab/Somatic Mutation/2023-11-26_mutation_spectrum_liquid_plate_combined_color.xlsX")
mutspec$type <- factor(mutspec$type, levels = c("A:T > G:C", "G:C > A:T", "G:C > C:G", "G:C > T:A", "A:T > C:G", "A:T > T:A"))

#this creates point plots. i am looking for a bar plot.
#lookinpretty <- ggplot(mutspec, aes(mutation, rates)) + geom_point() + geom_errorbar(aes(ymin = low, ymax = high), width = .2, position = position_dodge(.9)) +xlab("Mutation Type") +ylab("??, base-sub/site/generation")
#print(lookinpretty)  + scale_y_continuous(limits = c(1*10^-10, 5*10^-7), trans='log10') + labs(title = "DNB-seq Mu-seq Mutation Spectrum") + theme(plot.title = element_text(hjust = 0.5)) + annotation_logticks(sides = "l")
#library(ggplot2)

#series %>%
#  ggplot(aes(time, value, group=factor(type, levels=1987:1984)))+
#  geom_col(aes(fill= factor(type)))+
#  guides(fill=guide_legend(title="type"))

lookinpretty <- ggplot(mutspec, aes(type, arate, group = factor(growth, levels = c("2023 Plate", "2023 Liquid")))) + 
  geom_col(aes(fill = factor(growth)), position="dodge") +
  geom_errorbar(aes(ymin = alow, ymax = ahigh), width = .2, position = position_dodge(.9)) +
  xlab("Mutation Type") +
  ylab("base-sub/site/gen x10<sup>-10</sup>") +
  #geom_text(aes(label = rate), vjust = -0.5) +
  scale_fill_manual(values = c("#D95F02", "#1B9E77"), limits= c("2023 Plate", "2023 Liquid")) +
  labs(fill = "Condition") +
  theme(legend.text = element_text(size = 16),
        legend.title = element_text(size = 16),
        axis.text.x=element_text(size=12),
        axis.text.y = element_text(size=12),
        axis.title.y = element_text(size=14),
        axis.title.x = element_text(size=14))





#lookinpretty <- ggplot(mutspec, aes(type, rate, fill = growth)) + 
#  geom_col(color = "black", position="dodge") +
#  xlab("Mutation Type") +
#  ylab("base-sub/site/gen") +
#  #geom_text(aes(label = rate), vjust = -0.5) +
#  scale_fill_manual(values = c("#D95F02", "#1B9E77")) +
#  labs(fill = "Condition")
  
#Graph  
print(lookinpretty) + 
  scale_y_continuous(limits = c(0, 510)) +
  labs(title = "Mutation Spectra Liquid vs. Plate MA") +
  theme(plot.title = element_text(hjust = 0.5, size = 18),
        axis.title.x = element_markdown(),
        axis.title.y = element_markdown(),
        legend.position = c(0.82, 0.8))
  



############################################ T TEST INFO
#2023-07-18
# I DREW the Confidence Interval onto the mutation spectrum graph.
# Doy. Oy vey. Look. CHI square calculator
# then load into powerpoint, draw it on, save the image. Right. Okay
# fine. 
#looks like there is no good way to draw the p value of the chi-square.
#just mention it in the text. 




#T test extract p value
#fulltest <- t.test(liquid$xform, plate$xform)
#print(fulltest)

#res <- t.test(liquid$xform, plate$xform)$p.value
#print(res)

#result <- c(.000000000000000064)
#result

# T test make data frame
#df_p_val <- data.frame(
#  group1 = "G:C > A:T",
#  #group2 = "Liquid 2023",
#  label = result,
#  y.position = 2.25*10^-8
#)

# add p value to plot
#boromir <- lookinpretty + add_pvalue(df_p_val,
#                                label = "p = {label}")

#remake the graph
#print(boromir) + 
#  scale_y_continuous(limits = c(0, 5.1*10^-8)) +
#  labs(title = "Mutation Spectra Liquid vs. Plate MA") +
#  theme(plot.title = element_text(hjust = 0.5))
#### LETS SEE ABOUT confidence intervals

#load Low and High counts to excel file, re-calculate new rates.
#plate counts
library(epitools)
pois.approx(807)
pois.approx(272)
pois.approx(18)
pois.approx(41)
pois.approx(6)
pois.approx(7)

#liquid counts
pois.approx(995)
pois.approx(198)
pois.approx(15)
pois.approx(12)
pois.approx(4)
pois.approx(5)

#2012 counts
pois.approx(1141)
pois.approx(447)
pois.approx(14)
pois.approx(10)
pois.approx(10)
pois.approx(3)

#2022 counts
pois.approx(6462)
pois.approx(1937)
pois.approx(112)
pois.approx(449)
pois.approx(94)
pois.approx(79)
