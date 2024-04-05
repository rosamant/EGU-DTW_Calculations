# EGU-DTW_Calculations

This repository contains the necessary .csv files for the industrial sites. The files contain depth and gamma ray values for the sites.

A seperate R file exists that contains the code for the custom step pattern.

The R file 'Perform_DTW.R' contains the line of codes to process the data as per requirement and then perform dtw. 

First, dtw is carried out without the application of custom window and the second time with custom window. 

To plot the results as seen on the poster, use the 'EGU-Result_Plot.R' file.
