# EGU-DTW_Calculations

This repository contains the necessary .csv files for the industrial sites. The files contain depth and gamma ray values for the sites.

A seperate R file exists that contains the code for the custom step pattern. This code has to be run before performing the DTW calculations.

The R file 'Perform_DTW.R' contains the line of codes to process the data as per requirement and then perform dtw. 
First, dtw is carried out without the application of custom window and the second time with custom window. 
'Perform_DTW.R' file in the custom window section provides the code to plot the DTW density plot which indicates the DTW custom window space.

To plot the results as seen on the poster, use the 'EGU-Result_Plot.R' file.

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
