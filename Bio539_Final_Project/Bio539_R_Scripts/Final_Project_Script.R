#Import data from https://github.com/A-Presley/Bio539_Final_Project 
library(tidyverse)
library(dplyr)
#Place .csv files from github on desktop to use existing import code
library(readr)
diatom_relabund_osp <- read_csv("~Desktop/diatom_relabund_osp.csv")
pn_asv_relabun_osp <- read_csv("~Desktop/pn_asv_relabund_osp.csv")

#Input varriables for var.1 - var.4 below flowing instructions above each line
## Input Original Relative Abundance File; format requirements detailed in README.md
var.1 <- diatom_relabund_osp 
## Input ASV data count file; format requirements detailed in README.md
var.2 <- pn_asv_relabun_osp 
## Input number of ASVs in var.2 file
var.3 = 10 
##Input name of Genus/Class being broken down to species/OTU level
var.4 = "Pseudo-nitzschia" 
##Input number of data columns in var.1 column (all columns not including Sample ID and Treatment) leave '- 1' text in place for proper function
var.5 = 13 

#creates new file where only the desired genus (in this case Psuedo-nitzschia) and the Sample ID are left
  selected_genus_only <- var.1  %>% select(`Sample ID`, all_of(var.4))
#Takes the file specified in var.2 and mutates it to convert the sample counts into ratios of the total  
   asv_ratios <- var.2 %>%
      mutate_at(.funs = list(Ratio = ~./Totals), .vars = c(3:(var.3 + 2)))  %>% 
      select(`Sample ID`, (var.3 + 4):(var.3 + 13))
#Takes calculated ratios and uses them to generate new relative abundance values   
  asv_relabund <- left_join(selected_genus_only, asv_ratios, by = c("Sample ID")) %>%
    mutate_at(.funs = list(RelAbun = ~. * get(var.4)), .vars = c(3:(var.3 + 2) ) ) %>% 
    select("Sample ID", (var.3 + 3):(var.3 + 12) )
#Left joins new ASV Relative Abundances with exisitng relative abundances for samples
   asv_relabund_final <- left_join(asv_relabund, diatom_relabund_osp, by = c("Sample ID")) %>% 
     select(-Treatment, -all_of(var.4))

##RENAME ASVs as desired (Optional, See README.md for details)
   asv_relabund_final <- rename(asv_relabund_final, c("Pn turgidula" = "ASV1_Ratio_RelAbun", "Fragilariopsis_New" = "ASV2_Ratio_RelAbun", "ASV3" = "ASV3_Ratio_RelAbun", "ASV4" = "ASV4_Ratio_RelAbun", 
                                                      "ASV5" = "ASV5_Ratio_RelAbun", "Pn delicatissima" = "ASV6_Ratio_RelAbun", "Pn hemii" = "ASV7_Ratio_RelAbun", "ASV8" = "ASV8_Ratio_RelAbun",
                                                      "ASV9" = "ASV9_Ratio_RelAbun", "ASV10" = "ASV10_Ratio_RelAbun"))
#OPTIONAL: Generates a .RData file for export to other scripts for graphing if desired
   save(asv_relabund_final, file= "asv_relabund_final.RData")   
#Convert dataframe to long format for use in ggplot 
   relabund_long <- asv_relabund_final %>% gather(Taxonomy, Relabund, c(2:(var.3 + var.5)), factor_key = TRUE)
#Generate plot of data 
   library(ggplot2)
   ggplot(relabund_long, aes(x = `Sample ID`, y = Relabund, fill = Taxonomy)) + 
     geom_bar( stat = "identity", width = 0.9) + labs(y = "Relative Abundance") + 
      theme_bw() 
   ggsave('ASV_Relative_Abundance_Plot.png', width = 8, height= 6)
   