# Script: corr.R
# Author: Maurício Collaça
# Date: 28/Nov/2016
# Description: Takes a directory of data files and a threshold for complete
# cases and calculates the correlation between sulfate and nitrate for monitor 
# locations where the number of completely observed cases (on all variables) is 
# greater than the threshold. The function returns a vector of correlations for 
# the monitors that meet the threshold requirement. If no monitors meet the 
# threshold requirement, then the function returns a numeric vector of length 0.
# This function use the 'cor' function in R which calculates the correlation 
# between two vectors.

corr <- function(directory, threshold = 0) {
    monitor_nobs <- complete(directory)
    thresholded_ids <- monitor_nobs[,'nobs'] > threshold
    id <- monitor_nobs[thresholded_ids,'id']
    correlations <- numeric(length = 0)
    for(i in id) {
        monitors <- read.csv(file.path(directory, sprintf('%03d.csv', i)))
        good_obs <- complete.cases(monitors)
        pollutants <- monitors[good_obs,c('sulfate','nitrate')]
        correlations <- c(correlations,cor(pollutants[,'nitrate'],pollutants[,'sulfate']))
    }
    correlations
}