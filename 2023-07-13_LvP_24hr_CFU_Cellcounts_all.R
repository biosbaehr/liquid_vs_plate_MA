rm(list = ls())
library(readxl)
library(ggplot2)

fig4 <- read_excel("C:/Users/baehr/Desktop/LynchLab/Somatic Mutation/2023-07-12_LvP_cellcount_24hour_updated_graph_me.xlsx")
#"C:\Users\baehr\Desktop\LynchLab\Somatic Mutation\2023-07-12_LvP_cellcount_24hour_updated_graph_me.xlsx"


#factor to force order on x axis (not jumbled)
fig4$strain <- factor(fig4$strain, levels = c("P00", "P25", "P26", "P27", "P28", "P29",
                                                  "P30", "P31", "P32", "P33", "P34", "P35",
                                                  "P36", "P37", "P38", "P39", "P40", 
                                                  "L00", "L01", "L02", "L03", "L04", "L05",
                                                  "L06", "L07", "L08", "L09", "L10", "L11",
                                                  "L12", "L13", "L14", "L15", "L16" ))
#plot
tryme <- ggplot(fig4, aes(strain, cellsperday)) +  # this is the X and Y variables to be plotted.
  geom_point(size = 2.0) + #type of graph, color scheme if needed
  geom_errorbar(aes(ymin = low, ymax = high), width = .2, position = position_dodge(.9)) + # error bars
  xlab("Strain") +
  ylab("Cell Count per 24hr") +
  theme(axis.text.x=element_text(angle=45,hjust=1), legend.position="none") #angle X axis words 45 degrees, show no legend.
  #scale_color_identity() #force order of colors as listed above

#geom_errorbar(aes(ymin = low, ymax = high),
print(tryme)  +
  scale_y_continuous(limits = c(7*10^6, 2*10^9), trans='log10') + #change Y axis as needed
  labs(title = "24 Hour Cell Count, Liquid vs. Plate") + #title
  theme(plot.title = element_text(hjust = 0.5)) +  #this centers the title
  annotation_logticks(sides = "l")  #logticks if graphing orders of magnitude.
