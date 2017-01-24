airpollution
================
by Maurício Collaça
on 2017-01-24

Abstract
--------

Analysis of pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States.

Data
----

The zip file containing the data can be downloaded here: <https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip>

The zip file contains 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. Each file contains data from a single monitor and the ID number for each monitor is contained in the file name. For example, data for monitor 200 is contained in the file "200.csv".

Each file contains three variables:

Date: the date of the observation in YYYY-MM-DD format (year-month-day)
sulfate: the level of sulfate PM in the air on that date (measured in micrograms per cubic meter)
nitrate: the level of nitrate PM in the air on that date (measured in micrograms per cubic meter)

In each file there are many days where either sulfate or nitrate (or both) are missing (coded as NA). This is common with air pollution monitoring data in the United States.

Research
--------

Download the zip file

``` r
url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
destfile = 'specdata.zip'
if(!file.exists(destfile)) download.file(url, destfile, mode = "wb")
```

Unzip this file and create the directory 'specdata'.

``` r
if(!dir.exists("specdata")) unzip(destfile, setTimes = TRUE)
```

### Function [`pollutantmean(directory, pollutant, id = 1:332)`](https://github.com/mauriciocramos/airpollution/blob/master/pollutantmean.R)

Calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA.

Examples:

``` r
source("pollutantmean.R")
pollutantmean("specdata", "sulfate", 1:10)
```

    ## [1] 4.064128

``` r
pollutantmean("specdata", "nitrate", 70:72)
```

    ## [1] 1.706047

``` r
pollutantmean("specdata", "nitrate", 23)
```

    ## [1] 1.280833

``` r
pollutantmean("specdata", "sulfate", 34)
```

    ## [1] 1.477143

``` r
pollutantmean("specdata", "nitrate")
```

    ## [1] 1.702932

### Function [`complete(directory, id = 1:332)`](https://github.com/mauriciocramos/airpollution/blob/master/complete.R)

Reads a directory full of files and reports the number of completely observed cases in each data file. The function returns a data frame where the first column is the name of the file and the second column is the number of complete cases.

Examples:

``` r
source("complete.R")
complete("specdata", 1)
```

    ##   id nobs
    ## 1  1  117

``` r
complete("specdata", c(2, 4, 8, 10, 12))
```

    ##   id nobs
    ## 1  2 1041
    ## 2  4  474
    ## 3  8  192
    ## 4 10  148
    ## 5 12   96

``` r
complete("specdata", 30:25)
```

    ##   id nobs
    ## 1 30  932
    ## 2 29  711
    ## 3 28  475
    ## 4 27  338
    ## 5 26  586
    ## 6 25  463

``` r
complete("specdata", 3)
```

    ##   id nobs
    ## 1  3  243

``` r
complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
```

    ##    id nobs
    ## 1   6  228
    ## 2  10  148
    ## 3  20  124
    ## 4  34  165
    ## 5 100  104
    ## 6 200  460
    ## 7 310  232

``` r
complete("specdata", 54)
```

    ##   id nobs
    ## 1 54  219

### Function [`corr(directory, threshold = 0)`](https://github.com/mauriciocramos/airpollution/blob/master/corr.R)

Takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function returns a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function returns a numeric vector of length 0. This function use the 'cor' function in R which calculates the correlation between two vectors.

Examples:

``` r
source("corr.R")
source("complete.R")
cr <- corr("specdata", 150)
head(cr)
```

    ## [1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814

``` r
summary(cr)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -0.21060 -0.04999  0.09463  0.12530  0.26840  0.76310

``` r
cr <- corr("specdata", 400)
head(cr)
```

    ## [1] -0.01895754 -0.04389737 -0.06815956 -0.07588814  0.76312884 -0.15782860

``` r
summary(cr)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -0.17620 -0.03109  0.10020  0.13970  0.26850  0.76310

``` r
cr <- corr("specdata", 5000)
summary(cr)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## 

``` r
length(cr)
```

    ## [1] 0

``` r
cr <- corr("specdata")
summary(cr)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## -1.00000 -0.05282  0.10720  0.13680  0.27830  1.00000

``` r
length(cr)
```

    ## [1] 323
