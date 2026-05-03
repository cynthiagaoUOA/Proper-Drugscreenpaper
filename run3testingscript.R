run3key<- tribble(~SampleID, ~Row, ~ Column, ~ Sample, 
                  1, "A", "7 8 9", "High fingolimod",
                  2, "E", "1 2 3", "High melatonin",
                  3, "D", "10 11 12", "High riluzole",
                  4, "D", "1 2 3", "High ibuprofen",
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
                  101, "H", "10 11", "test",
                  
                  103, "F", "1 2 3", "High dipyridamole",
                  103, "F", "4 5 6", "Low dipyridamole")

run3labeled<- vascr:::vascr_apply_map(run3, run3key)

plot_data_3 = run3labeled %>% vascr_zero_time(63.774)

check3<- plot_data_3  %>% 
  vascr_subset(unit = "Rb") %>% 
  vascr_resample_time(500) %>% 
  vascr_normalise(-2, divide = TRUE)

check3 %>% vascr_subset(sampleid = c(4,10,100),time=c(-4,30)) %>% vascr_summarise(level = "well") %>%
  vascr_plot_line() +ylim(0.5,1.1)


