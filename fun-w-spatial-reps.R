#Mucking about with use of spatial replicates from single-sample Hochstetter's frog data in R to estimate frog abudnance in a given transect
#Original code from Royle & Dorzaio (2008), Panel 6.1, page 201. 
#R code for parametric abundance estimation using an N-mixture model formulation. 
#For single-survey Hochstetter's frog count data from 100m transects, 
#where 10m sections of transects are treated as spatial replicates and abundance assumed to be homogenous across sections. 

#---- load required packages --------#

library(rje) #required for expit function, which is the inverse of the logit function

#------------- data -------------#
nx<-c(2,3,3,0,3,2,2,3,5,6) #This is the number of frogs found in each 10 m segment of a transect found in the first survey. 
#Values currently in vector 'nx' are for transect A1, 2021 data, survey 1.
nind<-sum(nx)
J<-10 #number of segments in a transect

#-------------------- definition of likelihood -------------#

Mhlik<-function(parms){
		mu<-parms[1]
		sigma<-exp(parms[2])
		n0<-exp(parms[3])
	
	il<-rep(NA,J+1)
	for(k in 0:J){
		il[k+1]<-integrate(
			function(x){
				dbinom(k,J,expit(x))*dnorm(x,mu,sigma)
				},
				lower=-Inf,upper=Inf)$value
			}
	-1*(lgamma(n0+nind+1) - lgamma(n0+1) + sum(c(n0,nx)*log(il)))
}

#--------------- minimisation of -likelihood ---------#
# This function carries out a minimisation of the function 'Mhlik' using a Newton-type algorithm
# The vector in the nlm funtion below provides the starting parameter values of mu, sigma, and n0 for the minimisation.

minime<-nlm(Mhlik,c(-1,0,log(10) ),hessian=TRUE)

#Notes on output of nlm function

#minimum: the value of the estimated minimum of the profile likelihood of 'Mhlik"
#estimate: the point(s) at which the minimum value of 'Mhlik' is obtained.
#code: an integer of (1,5) indicating why the optimisation process terminated. 1 and 2 generally mean ok. 
#But see rdocumentation.org for the nlm fucntion for more info. 

#extract estimate of n0 and use to calculate N-hat from nind
nind+minime$estimate[3]


