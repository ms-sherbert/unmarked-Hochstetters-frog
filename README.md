# Description

Code and data repository for the manuscript entitled: "Johnson CE, Herbert SM, Gilbert J, and Armstrong DP.
A comparison of analytical methods for estimating abundance of unmarked Hochstetter's frogs."
Submitted to New Zealand Journal of Ecology in 2023. 

R code for data manipulation and OpenBUGS code for Bayesian formulations of hierarchical models for single- and multi-season data collected by multiple observers on the same day. 
Originally formulated by Doug P. Armstrong, Claire E. Johnson, and Sarah M. Herbert for analysis of Hochstetter's frog repeated count data collected from fifteen 100 m transects in 2012, 2015, and 2021. 
Collected using a double- or triple-observer protocol (i.e. N counts = 2-3); see Herbert et al. (2014), Herbert & Gilbert (2015), and Johnson (2022). 

## Repository contents:

`Appendix_1A_raw_data.csv` contains the raw frog capture data from the 2012, 2015, and 2021 surveys. 

`rep-count-trans.r` contains R script for transforming `Appendix_1A_raw_data.csv` into a repeated count format for N-mixture modeling in OpenBUGS.

`occBYseg-trans.r` contains R script for transforming `Appendix_1A_raw_data.csv` into a repeated detection/non-detection format (split by 10-metre transect segments) for occupancy modeling in OpenBUGS. 

Files entitled `Appendix_1...` contain raw and transformed count and occupancy data for Hochstetter’s frogs for fifteen 100-m transects at Te Paparahi, Aotea, New Zealand.

Files entitled `Appendix_2...` contain OpenBUGS code for closed-population mark-recapture (CMR), N-mixture, and occupancy models fitted to data for Hochstetter’s frogs at Te Paparahi, Aotea, New Zealand.

`correlation-script.R` contains code used for the pairwise correlation tests of model outputs throughout the manuscript. 

`fun-w-spatial-reps.R` Additional R code for calculating the abundance of a single-occasion count of frogs in a single 100-metre transect (not used in paper, but included here just for fun). 
For each frog encountered, its position in the transect was recorded as the distance from the startpoint (i.e. a number between 0m and 100 m). The unit of replication is spatial, rather than temporal, where each count is the number of frogs in each 10-metre section of the transect. Based on R code provided in Royle & Dorazio (2008). 

## References: 

Herbert S. and Gilbert J. (2015) Hochstetter’s frog population health surveying, Te Paparahi, Aotea / Great Barrier Island, April-May 2015. Technical report prepared in November 2015 by EcoGecko Consultants Ltd, Wellington, and the Windy Hill Rosalie Bay Catchment Trust, Great Barrier Island. Reference can be requested here: https://www.researchgate.net/profile/Sarah-Herbert-5

Herbert S., Melzer S., Gilbert J., and Jamieson H. (2014) Relative abundance and habitat use of Hochstetter’s frog (*Leiopelma hochstetteri*) in northern Great Barrier Island: a snapshot from 2012. *BioGecko 2*: 12-21. Reference available here: https://www.researchgate.net/profile/Sarah-Herbert-5

Johnson, C. E. (2022) A comparison of approaches for estimating Hochstetter's frog (*Leiopelma hochstetteri*) abundance. MSc thesis, Massey University, Palmerston North, New Zealand. Reference available here: https://mro.massey.ac.nz/handle/10179/17863

Royle, J. A. and Dorazio, R. M. (2008) *Hierarchical Modeling and Inference in Ecology: The Analysis of Data from Populations, Metapopulations and Communities*. Academic Press, London, UK. 
