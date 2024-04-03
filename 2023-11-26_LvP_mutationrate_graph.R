
rm(list = ls())
library(readxl)
library(ggplot2)
library(scales)
library(ggtext)

fig4 <- read_excel("C:/Users/baehr/Desktop/LynchLab/Somatic Mutation/2023-11-26_Lvp_mutationrate_datasets_4ma-exps.xlsx")
#"C:\Users\baehr\Desktop\LynchLab\Somatic Mutation\2023-11-26_Lvp_mutationrate_datasets_4ma-exps.xlsx"


#factor to force order on x axis (not jumbled)
fig4$Experiment <- factor(fig4$Experiment, levels = c("WT Plate Lee 2012",
                                                      "WT Plate Wei 2022",
                                                      "MMR- Plate Lee 2012", 
                                                      "MMR- Plate Wei 2022", 
                                                      "MMR- Plate 2023", 
                                                      "MMR- Liquid 2023" ))
#plot
tryme <- ggplot(fig4, aes(Experiment, another)) +  # this is the X and Y variables to be plotted. 
  geom_point(aes(color =c("blue","red","#da6a9d","#66A61E","#D95F02","#1B9E77")), size = 2.50) + #type of graph, color scheme if needed
  geom_errorbar(aes(ymin = alow, ymax = ahigh), width = .2, position = position_dodge(.9)) + # error bars
  xlab("Experiment") +
  ylab("BPS/site/gen x10<sup>-10</sup>") + 
  theme(axis.text.x=element_text(angle=45,hjust=1), legend.position="none")+ #angle X axis words 45 degrees, show no legend.
  scale_color_identity() #force order of colors as listed above

print(tryme)  + 
  scale_y_continuous(limits = c(2, 400), trans='log10') + #change Y axis as needed
  labs(title = "*E. coli*  MA Mutation Rate Estimates") + #title
  theme(plot.title = element_text(hjust = 0.5)) + #this centers the title.
  theme(plot.title = ggtext::element_markdown()) + #allows italics in title
  annotation_logticks(sides = "l") + #logticks if graphing orders of magnitude. 
  theme(
    axis.title.x = element_markdown(),
    axis.title.y = element_markdown()
)
  #scale_y_log10(name= "BPS/site/gen", breaks = c(3e-08, 1e-08, 3e-09, 1e-09, 3e-10), labels = trans_format("log10", math_format(10^.x)))
  

#+ scale_y_log10(name="mutation rate",breaks=c(1e-5,1e-6,1e-7,1e-8), labels = trans_format("log10", math_format(10^.x)))