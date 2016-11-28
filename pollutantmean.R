# 
# Part 1
# 
# Write a function named 'pollutantmean' that calculates the mean of a pollutant
# (sulfate or nitrate) across a specified list of monitors. The function
# 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'.
# Given a vector monitor ID numbers, 'pollutantmean' reads that monitors'
# particulate matter data from the directory specified in the 'directory'
# argument and returns the mean of the pollutant across all of the monitors,
# ignoring any missing values coded as NA.

#' Title
#'
#' @param directory 
#' @param pollutant 
#' @param id 
#'
#' @return
#' @export
#'
#' @examples
pollutantmean <- function(directory, pollutant, id = 1:332) {
    pollutant_data <- NULL
    for(i in id) {
        monitors <- read.csv(file.path(directory, sprintf('%03d.csv', i)))
        # data.frame
        
        good_obs <- !is.na(monitors[ , pollutant])
        # logical vector
        
        pollutant_data <- c(pollutant_data,monitors[good_obs,pollutant])
        # numerical vector
    }
    mean(pollutant_data)
}
