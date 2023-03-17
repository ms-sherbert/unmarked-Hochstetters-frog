##--- Transform data into repeated counts by transect  ---#

# remember to set working directory to where your data are, e.g.
# setwd("D:/R_outputs")
# If you need to check location of working directory, use: 
# getwd()

data <- read.csv("Appendix_1A_raw_data.csv",header=T)
attach(data)

names(data)
# [1] "Row_ID"   "Year"     "Transect" "Survey"   "x"        "y"        "SVL"        

# get counts for each survey for each transect for each year
write(table(Survey,Transect,Year),file="count.table.txt",3)
detach(data)

#Insert missing rows for transect D2
data2<-read.table("count.table.txt",header=F)
attach(data2)

existingDF <- data2
newrow <- rep(0,times=3)
insertRow <- function(existingDF, newrow, r) {
  existingDF[seq(r+1,nrow(existingDF)+1),] <- existingDF[seq(r,nrow(existingDF)),]
  existingDF[r,] <- newrow
  existingDF
}

r<-c(13,26,39)
for(i in 1:3){
	existingDF<-insertRow(existingDF, newrow, r[i])
}

#Update existingDF with NAs for surveys that didn't happen in a particular year
existingDF[1:30,3] <- "NA"
existingDF[1,] <- "NA"

#Add column names

colnames(existingDF) <-c("survey_1","survey_2","survey_3")

#write table output to a .csv file (these handle "NAs" better than .txt)
write.csv(existingDF,file="count.table-corrected.csv")
