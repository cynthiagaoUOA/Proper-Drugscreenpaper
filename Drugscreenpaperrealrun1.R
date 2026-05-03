library(vascr)
library(tidyverse)
library(ggplot2)

run1<- vascr_import("ECIS", 
                        raw="ECIS_260411_MFT_1_CG_newdrugscreenpaper1.abp",
                        model="ECIS_260411_MFT_1_CG_newdrugscreenpaper1_RbA.csv", experiment="exp1")

run1key<- tribble(~SampleID, ~Row, ~ Column, ~ Sample, 
                     1, "A", "1 2 3", "High fingolimod",
                     2, "B", "1 2 3", "High melatonin",
                     3, "C", "1 2 3", "High riluzole",
                     4, "D", "1 2 3", "High ibuprofen",
                     5, "E", "1 2 3", "High cilostazol",
                     6, "F", "1 2 3", "High pravastatin",
                  
                  7, "A", "4 5 6", "Low fingolimod",
                  8, "B", "4 5 6", "Low melatonin",
                  9, "C", "4 5 6", "Low riluzole",
                  10, "D", "4 5 6", "Low ibuprofen",
                  11, "E", "4 5 6", "Low cilostazol",
                  12, "F", "4 5 6", "Low pravastatin",
                  
                  13, "C", "7 8 9", "High ticagrelor",
                  14, "D", "7 8 9", "High icatibant",
                  15, "E", "7 8 9", "High VPA",
                  16, "F", "7 8 9", "High imatinib",
                  17, "G", "7 8 9", "High doxycycline",
                  18, "H", "7 8 9", "High rapamycin",

                  19, "C", "10 11 12", "Low ticagrelor",
                  20, "D", "10 11 12", "Low icatibant",
                  21, "E", "10 11 12", "Low VPA",
                  22, "F", "10 11 12", "Low imatinib",
                  23, "G", "10 11 12", "Low doxycycline",
                  24, "H", "10 11 12", "Low rapamycin",
                  
                  25, "H", "1 2 3", "Highest sapropterin",
                  26, "G", "4 5 6", "Low sapropterin",
                  27, "G", "1 2 3", "High sapropterin",
                  
                  100, "H", "4 5 6", "vehicle",
                  100, "B", "7 8 9", "vehicle")

run1labeled<- vascr:::vascr_apply_map(run1, run1key)

run1plotdata = run1labeled %>% 
  vascr_zero_time(65.234) %>% 
  vascr_subset(unit = "Rb") %>% 
  vascr_resample_time(500) %>% 
  vascr_normalise(-2, divide = TRUE) 


#did i actually do two vehicles? yes
run1plotdata %>% vascr_subset (sampleid = c(100,101),time=c(-5,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)

#fingolimod#fingolimodsampleid = 
fin<- run1plotdata %>% vascr_subset (sample = c(1,7,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)

#melatonin
mel<- run1plotdata %>% vascr_subset (sample = c(2,8,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)

#riluzole
ril<- run1plotdata %>% vascr_subset (sample = c(3,9,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)

#ibuprofen
ibu<- run1plotdata %>% vascr_subset (sample = c(4,10,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)

#cilostazol
cilo<- run1plotdata %>% vascr_subset (sample = c(5,11,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)

#pravastatin
prava<- run1plotdata %>% vascr_subset (sample = c(6,12,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)

#ticagrelor
tica<- run1plotdata %>% vascr_subset (sample = c(13,19,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)

#icatibant
icat<- run1plotdata %>% vascr_subset (sample = c(14,20,100),time=c(-4,30)) %>% 
  vascr_exclude(well="D12") %>%  vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1) 

# VPA
vpa<- run1plotdata %>% vascr_subset (sample = c(15,21,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.25) # different axes from the rest

#long timeline
run1plotdata %>% vascr_subset (sample = c(15,21,100),time=c(-4,70)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.25) # different axes from the rest

#imatinib
iman<- run1plotdata %>% vascr_subset (sample = c(16,22,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)
#toxcity

#doxycycline
doxy<- run1plotdata %>% vascr_subset (sample = c(17,23,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)
#low toxic but high is protective?

#rapamycin
rapa<- run1plotdata %>% vascr_subset (sample = c(18,24,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)
#initially high then declines below vehicle. Very interesting.

#sapropterin
run1plotdata %>% vascr_subset (sample = c(25:27,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)
#low is worse than high? Highest is used in cell culture. Higher than physiological. 

#two conc for paper
saprop<- run1plotdata %>% vascr_subset (sample = c(26,27,100),time=c(-4,30)) %>% vascr_summarise(level = "experiment") %>%
  vascr_plot_line() +ylim(0.5,1.1)



# combining figures
library(patchwork)

mel + ril




