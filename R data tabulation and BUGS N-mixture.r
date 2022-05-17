#Currently is nonsense; working version of trying to stitch a few different bits of code together into one piece of code that can be run in R

#----- Step 1: sorting data into CMR form ------#

data <- read.csv(file=file.choose(),header=T) #allows you to choose a .csv file of your data using the windows browser
attach(data) 

# define dimensions of matrix variables
n <- m <- nrow(data)
diff <- dist <- close <- same <- recapmat <- matrix(,n,m)

# define critical differences in size and position to be considered the same frog
CritDist = 0.2
CritDiff = 5

for (i in 1:n) {			
	for (j in 1:m) {	# for each pair of observations...
		diff[i,j] <- abs(SVL[i]-SVL[j])	# calculate difference in SVL
		dist[i,j] <- ifelse(Transect[i]!=Transect[j],100,sqrt((x[i]-x[j])^2+(y[i]-y[j])^2))
		# calculate Euclidean distance -- set to 100 if different transect
		close[i,j] <- 1*(dist[i,j]<=CritDist)
		same[i,j] <- (diff[i,j]<=CritDiff)*(dist[i,j]<=CritDist)	# whether same frog based on size, position
		recapmat[i,j] <- same[i,j]*(Survey[i]>Survey[j])		# whether frog i a recapture of frog j
}}

recap <- ifelse(rowSums(recapmat)>0,1,0)	# whether a recapture of at least one previous capture

# output matrix showing whether each frog observation within critical distance of another observation
write.table(close,file="close.txt",sep="\t",col.names=FALSE,row.names=FALSE)

# output matrix showing which frogs thought to be recaptures of other frogs
write.table(recapmat,file="recapmat.txt",sep="\t",col.names=FALSE,row.names=FALSE)

# output array showing whether each observation considered to be a recapture
write(recap,"recap.txt",1)

# counts of new captures and recaptures for each transect for each survey
write(table(Survey,Transect,recap),file="count.table.txt",3)


### Creating a human-friendly recap history

require(dplyr)
require(reshape2)

#### Version 1 - Stupid long way

recap.df<-data.frame(Survey=Survey,Transect=Transect,recap=recap)

recap.summary<-recap.df%>%
	group_by(Survey,Transect,recap)%>%
	summarise(n=n())

recap.summary_capture<-recap.summary%>%
filter(recap==0)

recap.summary_recapture<-recap.summary%>%
filter(recap==1)

eh.df<-plyr::rbind.fill(
dcast(data=recap.summary_capture,formula=Transect~Survey,fun.aggregate=sum)%>%
	mutate(recap=0),
dcast(data=recap.summary_recapture,formula=Transect~Survey,fun.aggregate=sum)%>%
	mutate(recap=1))

#### Version 2 simple short way

eh.df<-melt(table(Survey,Transect,recap))

#------- Step 2: modeling Bayesian model formaultions written in BUGS in R environment ---------#

### Call library that will let you run code written in BUGS

library(R2JAGS) 
#Or library(R2OpenBUGS)

#-------- Single season N-mixture model in BUGS --------#

# Notations: p = individual detection probability

Model {

	#Set priors
	a.p ~ dnorm(0,1)			# intercept of logit of individual detection probability (p)	
	s.j.p ~ dunif(0,1)			# uniform prior set for
	tau.j.p <- pow(s.j.p,-2)

	for (j in 1:n.surveys) {
		re.j.p[j] ~ dnorm(0, tau.j.p)	# assign a survey effect for p
		logit(p[j]) <- a.p+re.j.p[j]	 # calculate p for
		
	}

	for (i in 1:n.transects) {

		f0[i] ~ dnegbin(0.1,1)			# prior for no. undetected frogs on plot. Difference between the estimate and the number of known frogs.
		N[i] <- f0[i]+N.min[i]			# no. frogs on plot

	
		for (j in 1:3) {		# for each sampling occasion
			n[i,j] ~ dbin(p[j],N[i])		# sample no.of frogs found from no. of frogs present in transect (N)

		}
	}	
	logit(p.ave) <- a.p				# average detection prob. for unmarked frog
	

}
