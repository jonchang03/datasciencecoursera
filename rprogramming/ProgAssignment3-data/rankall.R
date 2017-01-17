rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv")
    
    ## Check that outcome is valid
    if(outcome == "heart attack") {
        i <- 11
    } else if (outcome == "heart failure") {
        i <- 17
    } else if (outcome == "pneumonia") {
        i <-23
    } else {
        stop("invalid outcome")
    }
    
    
    
    ## For each state, find the hospital of the given rank
    data <- subset(data, select=c(2,7,i)) # keep only the relevant columns
    names(data) <- c("hospital", "state", "outcome") # rename the columns
    data$outcome <- suppressWarnings(as.numeric(as.character(data$outcome))) # convert "Not Available" to NAs
    data <- data[complete.cases(data),] # get rid of NAs
    
    # order by state, then outcome, then hospital
    data <- data[order(data$state, data$outcome, data$hospital), ]
    
    # split by state
    splitByState <- split(data, data$state)
    
    
    ## The following function receives a state data frame from the split data
    ## and returns a hospital to pass to lapply
    getHospital <- function(statedf) {
        hospital <-statedf[1,1]
        if (num == "best") {
            hospital <-statedf[1,1]
        } else if(num == "worst") {
            hospital <- statedf[nrow(statedf),1]
        } else if (is.numeric(num)) {
            hospital <- statedf[num,1] # if you use an invalid index, you'll get NA anyways
        } else {
            stop("invalid num")
        }
        return(hospital)
    }
    
    # get list of hospitals
    hospitalNames <- sapply(splitByState, getHospital) # get list of hospital names
    stateNames <- unique(data$state)
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    data.frame(hospital=hospitalNames, state=stateNames, row.names=stateNames)
}