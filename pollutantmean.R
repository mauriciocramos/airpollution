pollutantmean <- function(directory, pollutant, id=1:332) {
    pollutant_data<-NULL
    for(i in id) {
        monitors<-read.csv(file.path(directory,sprintf('%03d.csv',i)))
        pollutant_data<-c(pollutant_data,monitors[!is.na(monitors[,pollutant]),pollutant])
    }
    mean(pollutant_data)
}
