# Script: complete.R
# Author: Maurício Collaça
# Date: 28/Nov/2016
# Description: Reads a directory full of files and reports the number of 
# completely observed cases in each data file. The function returns a data frame
# where the first column is the name of the file and the second column is the
# number of complete cases.

complete <- function(directory, id = 1:332) {
    nobs <- NULL
    for(i in id) {
        monitors <- read.csv(file.path(directory,sprintf('%03d.csv', i)))
        good_obs <- complete.cases(monitors)
        nobs <- c(nobs,length(monitors[good_obs,'ID']))
    }
    data.frame(id,nobs)
}
