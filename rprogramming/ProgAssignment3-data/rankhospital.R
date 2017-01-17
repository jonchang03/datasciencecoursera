rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv")
    
    ## Check that state and outcome are valid
    if(!(state %in% df$State)) {
        stop("invalid state")
    }
    if(outcome == "heart attack") {
        i <- 11
    } else if (outcome == "heart failure") {
        i <- 17
    } else if (outcome == "pneumonia") {
        i <-23
    } else {
        stop("invalid outcome")
    }
    
    ## Return hospital name in that state with the given rank 30-day death rate
    data <- subset(df, select=c(2,7,i)) # keep only the relevant columns
    data <- subset(data, state==data$State) # keep only relevant rows
    data[,3] <- suppressWarnings(as.numeric(as.character(data[,3]))) # convert "Not Available" to NAs
    data <- data[complete.cases(data),] # get rid of NAs
    
    # get list of hospitals with lowest 30-day death
    if (num == "best") {
        n <- 1
    } else if(num == "worst") {
        n <- nrow(unique(data))
    } else if (is.numeric(num)) {
        if( num < 1 || num > nrow(data)) {
            return(NA)
        }
    } else {
        stop("invalid num")
    }
    
    #print(sort(data[, 1]))
    #hospitals <- data[(data[,3] == min(data[,3])), 1]
    
    # break ties
    #paste(sort(hospitals)[1])
}