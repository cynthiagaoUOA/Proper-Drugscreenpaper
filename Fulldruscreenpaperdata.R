# install.packages("pak")

# pak::pak("JamesHucklesby/vascr")



library(vascr)
library(tidyverse)
library(ggplot2)
library(patchwork)

# Loading in data ---------------------------------------------------------

#run 1
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

#run 2
run2<- vascr_import("ECIS", 
                    raw="ECIS_260418_MFT_1_CG_newdrugscreenpaper2.abp",
                    model="ECIS_260418_MFT_1_CG_newdrugscreenpaper2_RbA.csv", experiment="exp2")


run2key<- tribble(~SampleID, ~Row, ~ Column, ~ Sample, 
                  1, "F", "7 8 9", "High fingolimod",
                  2, "G", "7 8 9", "High melatonin",
                  3, "H", "7 8 9", "High riluzole",
                  4, "B", "7 8 9", "High ibuprofen",
                  5, "D", "7 8 9", "High cilostazol",
                  6, "E", "7 8 9", "High pravastatin",
                  
                  7, "F", "10 11 12", "Low fingolimod",
                  8, "G", "10 11 12", "Low melatonin",
                  9, "H", "10 11 12", "Low riluzole",
                  10, "A", "10 11 12", "Low ibuprofen",
                  11, "D", "10 11 12", "Low cilostazol",
                  12, "E", "10 11 12", "Low pravastatin",
                  
                  13, "E", "1 2 3", "High ticagrelor",
                  14, "G", "1 2 3", "High icatibant",
                  15, "A", "1 2 3", "High VPA",
                  16, "B", "1 2 3", "High imatinib",
                  17, "C", "1 2 3", "High doxycycline",
                  18, "D", "1 2 3", "High rapamycin",
                  
                  19, "E", "4 5 6", "Low ticagrelor",
                  20, "G", "4 5 6", "Low icatibant",
                  21, "A", "4 5 6", "Low VPA",
                  22, "B", "4 5 6", "Low imatinib",
                  23, "C", "4 5 6", "Low doxycycline",
                  24, "D", "4 5 6", "Low rapamycin",
                  
                  25, "C", "7 8 9", "Highest sapropterin",
                  26, "H", "4 5 6", "Low sapropterin",
                  27, "C", "10 11 12", "High sapropterin",
                  
                  100, "A", "7 8 9", "vehicle",
                  100, "B", "10 11 12", "vehicle",
                  
                  103, "F", "1 2 3", "High dipyridamole",
                  103, "F", "4 5 6", "Low dipyridamole")

run2labeled<- vascr:::vascr_apply_map(run2, run2key)

#run 3
run3<- vascr_import("ECIS", 
                    raw="ECIS_260424_MFT_1_CG_newdrugscreenpaper3icc.abp",
                    model="ECIS_260424_MFT_1_CG_newdrugscreenpaper3icc_RbA.csv", experiment="exp3")


run3key<- tribble(~SampleID, ~Row, ~ Column, ~ Sample, 
                  1, "A", "7 8 9", "High fingolimod",
                  2, "E", "1 2 3", "High melatonin",
                  3, "D", "10 11 12", "High riluzole",
                  4, "D", "2 3", "High ibuprofen", # D1 excluded
                  5, "E", "7 8 9", "High cilostazol",
                  6, "H", "1 2 3", "High pravastatin",
                  
                  7, "A", "10 11 12", "Low fingolimod",
                  8, "E", "4 5 6", "Low melatonin",
                  9, "D", "7 8 9", "Low riluzole",
                  10, "D", "4 5 6", "Low ibuprofen",
                  11, "E", "10 11 12", "Low cilostazol",
                  12, "H", "4 5 6", "Low pravastatin",
                  
                  13, "B", "7 8 9", "High ticagrelor",
                  14, "G", "1 2 3", "High icatibant",
                  15, "B", "1 2 3", "High VPA",
                  16, "C", "7 8 9", "High imatinib",
                  17, "F", "7 8 9", "High doxycycline",
                  18, "C", "1 2 3", "High rapamycin",
                  
                  19, "B", "10 11 12", "Low ticagrelor",
                  20, "G", "4 5 6", "Low icatibant",
                  21, "B", "4 5 6", "Low VPA",
                  22, "C", "10 11 12", "Low imatinib",
                  23, "F", "10 11 12", "Low doxycycline",
                  24, "C", "4 5 6", "Low rapamycin",
                  
                  25, "G", "7 8 9", "Highest sapropterin",
                  26, "H", "7 8 9", "Low sapropterin",
                  27, "G", "10 11 12", "High sapropterin",
                  
                  100, "A", "4 5 6", "vehicle",
                  
                  103, "F", "1 2 3", "High dipyridamole",
                  103, "F", "4 5 6", "Low dipyridamole")

run3labeled<- vascr:::vascr_apply_map(run3, run3key)


# JH grant plot -----------------------------------------------------------

plot_data_1 = run1labeled %>% vascr_zero_time(65.234) 
plot_data_2 = run2labeled %>% vascr_zero_time(65.965)
plot_data_3 = run3labeled %>% vascr_zero_time(63.774)

combineddata <- vascr_combine(plot_data_1,plot_data_2, plot_data_3)

plotdata = combineddata %>% 
  vascr_subset(unit = "Rb") %>% 
  vascr_resample_time(500) %>% 
  vascr_normalise(-1, divide = TRUE) 

plotdata %>% vascr_subset (sampleid = c(100,15,17,18), time=c(-4,24)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0.75,1.1) + geom_vline(xintercept=0, colour="black", linetype="dashed", alpha=0.5)


# wrangling and plotting --------------------------------------------------

plot_data_1 = run1labeled %>% vascr_zero_time(65.234) 
plot_data_2 = run2labeled %>% vascr_zero_time(65.965)
plot_data_3 = run3labeled %>% vascr_zero_time(63.774)

combineddata <- vascr_combine(plot_data_1,plot_data_2, plot_data_3)

plotdata = combineddata %>% 
  vascr_subset(unit = "Rb") %>% 
  vascr_resample_time(500) %>% 
  vascr_normalise(-1, divide = TRUE) 

#vehicle
plotdata %>% vascr_subset(sampleid = c(100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0, 1.1)

#fingolimod
fin<- plotdata %>% vascr_subset (sampleid = c(1,7,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)

#melatonin#
mel<- plotdata %>% vascr_subset (sampleid = c(2,8,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)

#riluzole
ril<- plotdata %>% vascr_subset (sampleid = c(3,9,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)

#ibuprofen
ibu<- plotdata %>% vascr_subset (sampleid = c(4,10,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)


#cilostazol
cilo<- plotdata %>% vascr_subset (sampleid = c(5,11,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)

#pravastatin
prava<- plotdata %>% vascr_subset (sampleid = c(6,12,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)

#ticagrelor
tica<- plotdata %>% vascr_subset (sampleid = c(13,19,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)

#icatibant
icat<- plotdata %>% vascr_subset (sampleid = c(14,20,100),time=c(-4,30)) %>% 
  vascr_exclude(well="D12") %>%  vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1) 

# VPA
vpa<- plotdata %>% vascr_subset (sampleid = c(15,21,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.25) # different axes from the rest

#long timeline
plotdata %>% vascr_subset (sampleid = c(15,21,100),time=c(-4,70)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.25) # different axes from the rest

#imatinib
iman<- plotdata %>% vascr_subset (sampleid = c(16,22,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)

plotdata %>% vascr_subset (sampleid = c(16,22,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1) 
#toxcity

#doxycycline
doxy<- plotdata %>% vascr_subset (sampleid = c(17,23,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)
#low toxic but high is protective?

#rapamycin
rapa<- plotdata %>% vascr_subset (sampleid = c(18,24,100),time=c(-4,50)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)
#initially high then declines below vehicle. Very interesting.

#sapropterin

#two conc for paper
saprop<- plotdata %>% vascr_subset (sampleid = c(26,27,100),time=c(-4,30)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0,1.1)

mel+ ril+ibu+cilo+prava+icat+ saprop & ylim(0, 1.1) & theme_bw() & ylab("Rb (ohm cm^2)")


#protective
vpa+doxy+rapa & theme_bw() & ylab("Rb (ohm cm^2)")


#disruptive

tica+iman+fin& theme_bw() & ylab("Rb (ohm cm^2)")



# Stats -------------------------------------------------------------------

# stats dataframe input should be resampled but not normalised, and should contain the full timeframe. 
# Using vascr dunnett allows the use of a reference 'vehicle' condition, rather than the default that compares every condition to each other


stats_data<- combineddata %>% 
  vascr_subset(unit = "Rb") %>% #only looking at Rb atm. Need to repeat code from here for alpha, Cm, etc
  vascr_resample_time(500) %>% 
  vascr_subset(sampleid=c(1:100)) #

#stats is on unnorm data but plot shows norm

#do I need to correct for multiple comparisons


stats_data$Experiment <- factor(stats_data$Experiment)
stats_data$Sample   <- factor(stats_data$Sample)


# vascrline dunnet shows normalised lines, but performs the statistical analysis on the unnormlised data. Looks cleaner and is valid
stats_data %>%  vascr_subset(sampleid=c(100, 17)) %>% vascr:::vascr_plot_line_dunnett (unit = "Rb", frequency = "0", time = list(4,24,20), reference = "vehicle", normtime=-2) +
  xlim(-4,40) +ylim(-1,0.5)


sig_dunnett<- stats_data %>%  vascr_subset(sampleid=c(1:103)) %>% vascr_dunnett (unit = "Rb", frequency = "0", time = list(4,24,20), reference = "vehicle") 


sig_dunnett %>% filter(Label!="ns") %>%  filter(Label!="+")




# figure for scott --------------------------------------------------------
# for grant 
# VPA
highvpa<- plotdata %>% vascr_subset (sampleid = c(15,100),time=c(-4,48)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0.5,1.2) 

# VPA
highdoxy<- plotdata %>% vascr_subset (sampleid = c(17,100),time=c(-4,48)) %>% vascr_summarise(level = "summary") %>%
  vascr_plot_line() +ylim(0.5,1.20) +theme_bw()# different axes from the rest

highvpa+highdoxy &theme_bw()




# function for better plots -----------------------------------------------


# want vehicle in the background, overlay high and low of each drug, each drug titled

plot_drug<- function(data, drug, vehicle=100, time = c(-4, 30), ylim= c(0.5, 1.1)){ 
  
  library(stringr)
  drugdf<- data %>% vascr:::vascr_subset(sampleid= drug)
  drugname = str_extract(drugdf$Sample[1], "\\S+$")
  
  subset <- data %>% vascr:::vascr_subset(sampleid= c(drug,vehicle), time= time) %>% vascr_summarise(level="summary")
  plot <- subset %>% vascr_plot_line() + 
  theme_bw() +
  scale_fill_manual(values= c("turquoise2", "royalblue1", "grey40"))+ 
  scale_color_manual(values= c("turquoise2", "royalblue1", "darkgrey")) + ylim(ylim)+
    labs(title=drugname )
   
  return(plot)
}
  
  

# plots condensed ---------------------------------------------------------

plot_drug(plotdata, c(1,7)) #fingolimod
plot_drug(plotdata, c(2,8)) # ibuprofen



plot_drug(plotdata, c(26:27))
