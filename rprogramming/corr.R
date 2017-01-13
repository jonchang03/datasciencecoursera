## Part 3
corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!
    
    obs_df <- complete("specdata") # use dataframe from previous answer
    id <- obs_df$id[obs_df$nobs > threshold] # get ids where nobs > threshold
    corrs <- numeric()
    
    for (i in id) {
        readFiles <- read.csv(paste(directory, "/", formatC(i, width=3, flag="0"), ".csv", sep=""))
        df <- readFiles[complete.cases(readFiles), ]
        corrs <- c(corrs, cor(df$nitrate, df$sulfate))
    }
    corrs
}