#
#Part 3
#
#Write a function that takes a directory of data files and a threshold for 
#complete cases and calculates the correlation between sulfate and nitrate for 
#monitor locations where the number of completely observed cases (on all 
#variables) is greater than the threshold. The function should return a vector 
#of correlations for the monitors that meet the threshold requirement. If no 
#monitors meet the threshold requirement, then the function should return a 
#numeric vector of length 0. For this function you will need to use the 'cor'
#function in R which calculates the correlation between two vectors. Please read
#the help page for this function via '?cor' and make sure that you know how to
#use it.

#' Title
#'
#' @param directory 
#' @param threshold 
#'
#' @return
#' @export
#'
#' @examples
corr <- function(directory, threshold = 0) {
    
    monitor_nobs <- complete(directory)
    # data.frame
    
    #thresholded_ids <- monitor_nobs$nobs > threshold
    thresholded_ids <- monitor_nobs[,'nobs'] > threshold
    # logical vector
    
    id <- monitor_nobs[thresholded_ids,'id']
    # integer vector
    
    correlations <- numeric(length = 0)
    for(i in id) {
        monitors <- read.csv(file.path(directory, sprintf('%03d.csv', i)))
        # data.frame
        
        good_obs <- complete.cases(monitors)
        # logical vector
        
        #pollutants <- monitors[good_obs,c('sulfate','nitrate')]
        # data.frame
        
        pollutants <- data.matrix(monitors[good_obs,c('sulfate','nitrate')],rownames.force = FALSE)
        # data.matrix
        
        correlations <- c(correlations,cor(pollutants[,'nitrate'],pollutants[,'sulfate']))
        
    }
    correlations
    
}