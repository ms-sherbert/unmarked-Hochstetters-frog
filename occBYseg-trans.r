#--- Transform data into observed presence by transect segment ----#

# remeber to set working directory to where your data are, e.g.
# setwd("D:/R_outputs")
# If you need to check location of working directory, use: 
# getwd()

data <- read.csv("All_captures_2012-2022.csv",header=T)
attach(data)

n.segments <- 10	# no. of segments each transect divided into

count.segment <- 1+trunc((x-0.001)/n.segments) # segment assigned to each observation

# count number found in each segment for each survey for each transect for each year
segment.counts <- table(Survey,count.segment,Transect,Year)
# convert to presence-absence
segment.presence <- 1*(segment.counts > 0)

write(segment.counts,file="segment.counts.txt",3)
write(segment.presence,file="segment.presence.txt",3)

detach(data)
rm(list=ls()) #Just to keep your R environment tidy ;)
