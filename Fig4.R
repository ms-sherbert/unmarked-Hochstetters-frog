library(ggplot2)

UncN <- read.csv(file="Appendix_4C_Unconst_N-mix_2012-21.csv",header=TRUE)
Firstcount <- read.csv(file="Appendix_4E_Single_count_2012-21.csv",header=TRUE)

ggplot(data=UncN[1:45,],aes(x=Transect,y=median,fill=as.factor(Year))) +
  geom_bar(stat="identity", color= "black", show.legend = FALSE) +
  scale_fill_viridis_d(option = "viridis", begin = 0.3) +
  facet_wrap(~factor(Year, levels=c('2012','2015','2021'))) +
  scale_y_continuous(name = "N estimates from N-mixture") +
  geom_errorbar(aes(x=Transect, ymin=val2.5pc, ymax=val97.5pc), width = 0.4) + 
  ggtitle(label = "A") +
  theme_bw()

ggplot(data=Firstcount[1:45,],aes(x=Transect,y=median,fill=as.factor(Year))) +
  geom_bar(stat="identity", color= "black", show.legend = FALSE) +
  scale_fill_viridis_d(option = "viridis", begin = 0.3) +
  facet_wrap(~factor(Year, levels=c('2012','2015','2021'))) +
  scale_y_continuous(name = "Mean first count") +
  geom_errorbar(aes(x=Transect, ymin=val2.5pc, ymax=val97.5pc), width = 0.4) + 
  ggtitle(label = "B") +
  theme_bw()