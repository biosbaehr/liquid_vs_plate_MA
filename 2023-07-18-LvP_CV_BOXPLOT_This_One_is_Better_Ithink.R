
rm(list = ls())
library(readxl)
library(ggplot2)
library(ggprism)
library(patchwork)
library(magrittr)

#filename to be copy pasta'd
#"C:\Users\baehr\Desktop\LynchLab\Liq_v_Plate_MA\Kc_comparison_firstround\2023_05-08_Kc_xform_ready_to_graph.xlsx"
# "C:\Users\baehr\Desktop\LynchLab\Somatic Mutation\2023-07-12_t-test_data_Coeff_var_celldiv_maybe_boxplot.xlsx"
#import
melted_ecoli <- read_excel("C:/Users/baehr/Desktop/LynchLab/Somatic Mutation/2023-07-12_t-test_data_Coeff_var_celldiv_maybe_boxplot_nostraininfo.xlsx")

#factor to ensure they are in correct order. P before L
melted_ecoli$condition <- factor(melted_ecoli$type, levels = c("Plate 2023", "Liquid 2023"))

#graphing time
#ggplot boxplot dark2 colors
#faramir <- ggplot(melted_ecoli, aes(strain, xform)) + 
#                  geom_boxplot()

faramir <- ggplot(melted_ecoli, aes(x=reorder(type, -CV), CV, group = factor(type, levels = c("Plate 2023", "Liquid 2023")))) + 
  geom_boxplot(aes(fill = factor(type))) +
  xlab("Condition") + 
  ylab("CV") +
  labs(fill = "Condition") +
  scale_fill_manual(values = c("#D95F02", "#1B9E77"), limits= c("Plate 2023", "Liquid 2023")) +
  theme(legend.position="none")+
  scale_color_identity()

#boxplot 
print(faramir) + labs(title = "CFU CV Liquid vs. Plate") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_y_continuous(limits = c(0, 1.5))

#T.test, make two data sets
liquidcv <- melted_ecoli[melted_ecoli$type == "Liquid 2023", "CV"] 
platecv <- melted_ecoli[melted_ecoli$type == "Plate 2023", "CV"]

#T test extract p value
res <- t.test(liquidcv$CV, platecv$CV)$p.value
print(res)
result <- signif(res, digits = 2)
result

# T test make data frame
df_p_val <- data.frame(
  group1 = "Plate 2023",
  group2 = "Liquid 2023",
  label = result,
  y.position = 1.5
)

# add p value to plot
boromir <- faramir + add_pvalue(df_p_val,
                                label = "p = {label}")

#remake the graph
print(boromir) + labs(title = "Cell Count Variation, 24hr") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_y_continuous(limits = c(0, 1.5))

