#
#Part 2
#
#Write a function that reads a directory full of files and reports the number of
#completely observed cases in each data file. The function should return a data
#frame where the first column is the name of the file and the second column is
#the number of complete cases.

#' Title
#'
#' @param directory 
#' @param id 
#'
#' @return
#' @export
#'
#' @examples
complete <- function(directory, id = 1:332) {
    nobs <- NULL
    for(i in id) {
        monitors <- read.csv(file.path(directory,sprintf('%03d.csv', i)))
        # data.frame
        
        good_obs <- complete.cases(monitors)
        # logical vector
        
        nobs <- c(nobs,length(monitors[good_obs,'ID']))
        # integer vector
    }
    data.frame(id,nobs)
    # data.frame
}
