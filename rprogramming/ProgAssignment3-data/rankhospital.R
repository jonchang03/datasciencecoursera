rankhospital <- function(state, outcome, num = "best") {
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
    
    ## Return hospital name in that state with the given rank 30-day death rate
    data <- subset(df, select=c(2,7,i)) # keep only the relevant columns
    data <- subset(data, state==data$State) # keep only relevant states
    data[,3] <- suppressWarnings(as.numeric(as.character(data[,3]))) # convert "Not Available" to NAs
    data <- data[complete.cases(data),] # get rid of NAs
    
    # get list of hospitals with lowest 30-day death
    if (num == "best") {
        n <- 1
    } else if(num == "worst") {
        n <- nrow(data)
    } else if (is.numeric(num)) {
        n <- num # if you use an invalid index, you'll get NA anyways
    } else {
        stop("invalid num")
    }
    
    # sort first by outcome, then by hospital name using order()
    hospitals <- data[order(data[,3], data[,1]),]
    hospitals[n,1]
}