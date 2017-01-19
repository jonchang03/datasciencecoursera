best <- function(state, outcome) {
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
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
    
    ## Return hospital name in that state with lowest 30-day death rate
    data <- subset(df, select=c(2,7,i)) # keep only the relevant columns
    data <- subset(data, state==data$State) # keep only relevant rows
    data[,3] <- suppressWarnings(as.numeric(as.character(data[,3]))) # convert "Not Available" to NAs
    data <- data[complete.cases(data),] # get rid of NAs
    
    # get list of hospitals with lowest 30-day death
    hospitals <- data[(data[,3] == min(data[,3])), 1]
    
    # break ties
    sort(hospitals)[1]
}