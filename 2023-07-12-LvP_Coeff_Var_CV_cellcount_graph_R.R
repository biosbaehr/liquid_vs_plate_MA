
rm(list = ls())
library(readxl)
library(ggplot2)

fig4 <- read_excel("C:/Users/baehr/Desktop/LynchLab/Somatic Mutation/2023-07-12_Coeff_Var_CV_cellcount_LvP_Graph_data_for_R.xlsx")
#"C:\Users\baehr\Desktop\LynchLab\Somatic Mutation\2023-07-12_Coeff_Var_CV_cellcount_LvP_Graph_data_for_R.xlsx"


#factor to force order on x axis (not jumbled)
fig4$condition <- factor(fig4$condition, levels = c("Plate", "Liquid"))
#plot
tryme <- ggplot(fig4, aes(condition, CV)) + 
  geom_col(aes(fill = factor(condition))) + 
  geom_errorbar(aes(ymin = low, ymax = high), width = .2, position = position_dodge(.9)) +
  xlab("Condition") +
  ylab("CV") + 
  theme(legend.position="none")+  #axis.text.x=element_text(angle=45,hjust=1), 
  scale_fill_manual(values = c("#D95F02", "#1B9E77"), limits= c( "Plate", "Liquid")) +
  scale_color_identity()

#faramir <- ggplot(melted_ecoli, aes(x=reorder(strain, xform), xform, group = factor(strain, levels = c("Ancestor", "Plate 2023", "Liquid 2023")))) + 
#  geom_boxplot(aes(fill = factor(strain))) +
#  xlab("Condition") + 
#  ylab("Relative Carrying Capacity") +
#  labs(fill = "Condition") +
#  scale_fill_manual(values = c("#7570B3","#D95F02", "#1B9E77"), limits= c("Ancestor", "Plate 2023", "Liquid 2023")) +
#  theme(axis.text.x=element_text(angle=45,hjust=1), legend.position="none")+
#  scale_color_identity()


print(tryme)  + 
  scale_y_continuous(limits = c(0, 1)) +
  labs(title = "CFU CV Comparison, Liquid vs. Plate") + 
  theme(plot.title = element_text(hjust = 0.5))# + 
  #annotation_logticks(sides = "l") 
