# Script: pollutantmean.R
# Author: Maurício Collaça
# Date: 28/Nov/2016
# Description: Calculates the mean of a pollutant (sulfate or nitrate) across a
# specified list of monitors. The function 'pollutantmean' takes three
# arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID
# numbers, 'pollutantmean' reads that monitors' particulate matter data from the
# directory specified in the 'directory' argument and returns the mean of the
# pollutant across all of the monitors, ignoring any missing values coded as NA.

pollutantmean <- function(directory, pollutant, id = 1:332) {
    pollutant_data <- NULL
    for(i in id) {
        monitors <- read.csv(file.path(directory, sprintf('%03d.csv', i)))
        good_obs <- !is.na(monitors[ , pollutant])
        pollutant_data <- c(pollutant_data,monitors[good_obs,pollutant])
    }
    mean(pollutant_data)
}
