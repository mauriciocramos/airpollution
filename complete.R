complete <- function(directory, id=1:332) {
    nobs <- NULL
    for(i in id) {
        monitors <- read.csv(file.path(directory,sprintf('%03d.csv',i)))
        nobs <- c(nobs,length(monitors[complete.cases(monitors),'ID']))
    }
    data.frame(id,nobs)
}
