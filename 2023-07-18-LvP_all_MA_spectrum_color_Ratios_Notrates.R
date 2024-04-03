# This makes an acceptable graph detailing mutation rates with confidence intervals

rm(list = ls())
library(readxl)
library(ggplot2)
library(RColorBrewer)

brewer.pal(6, "Dark2")
#"C:\Users\baehr\Desktop\LynchLab\Somatic Mutation\2023-07-10_NEWSPECTRA_ratios_not_rates-FML_CLEAN_USETHIS.xlsx
# LIQUID will be blue,#1B9E77 final answer.Slot 1.
# PLATE will be orange, #D95F02
#"#1B9E77" "#D95F02" "#7570B3" "#E7298A" "#66A61E" "#E6AB02"


mutspec <- read_excel("C:/Users/baehr/Desktop/LynchLab/Somatic Mutation/2023-07-18_NEWSPECTRA_ratios_not_rates-FML_CLEAN_USETHIS.xlsx")
mutspec$type <- factor(mutspec$type, levels = c("A:T > G:C", "G:C > A:T", "G:C > C:G", "G:C > T:A", "A:T > C:G", "A:T > T:A"))

#this creates point plots. i am looking for a bar plot.
#lookinpretty <- ggplot(mutspec, aes(mutation, rates)) + geom_point() + geom_errorbar(aes(ymin = low, ymax = high), width = .2, position = position_dodge(.9)) +xlab("Mutation Type") +ylab("??, base-sub/site/generation")
#print(lookinpretty)  + scale_y_continuous(limits = c(1*10^-10, 5*10^-7), trans='log10') + labs(title = "DNB-seq Mu-seq Mutation Spectrum") + theme(plot.title = element_text(hjust = 0.5)) + annotation_logticks(sides = "l")
#library(ggplot2)

#series %>%
#  ggplot(aes(time, value, group=factor(type, levels=1987:1984)))+
#  geom_col(aes(fill= factor(type)))+
#  guides(fill=guide_legend(title="type"))

lookinpretty <- ggplot(mutspec, aes(type, ratios, group = factor(growth, levels = c("2012 Plate", "2022 Plate", "2023 Plate", "2023 Liquid")))) + 
  geom_col(aes(fill = factor(growth)), position="dodge") +
  geom_errorbar(aes(ymin = low, ymax = high), width = .2, position = position_dodge(.9)) +
  xlab("Mutation Type") +
  ylab("Mutation Ratio") +
  #geom_text(aes(label = rate), vjust = -0.5) +
  scale_fill_manual(values = c("#da6a9d", "#66A61E", "#D95F02", "#1B9E77"), limits= c("2012 Plate", "2022 Plate", "2023 Plate", "2023 Liquid")) +
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
  
  
print(lookinpretty) + 
  scale_y_continuous(limits = c(0, 1)) +
  labs(title = "Mutation Spectra Liquid vs. Plate MA") +
  theme(plot.title = element_text(hjust = 0.5, size = 18))+
  theme(legend.position = c(0.82, 0.8))


### LETS SEE ABOUT confidence intervals
# the below is a poisson approximation to provide 95% confidence intervals of counts, for example counts loaded onto a mutation spectrum. This is the method Hongan Long reports using. 

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
