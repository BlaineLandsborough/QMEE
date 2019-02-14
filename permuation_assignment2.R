
library(lmPerm)
library(tidyverse)
puk <- read_csv("Chick_measurements_2018.csv")
puk2 <- na.omit(puk)
puk.var <- puk2[c("ChickID", "Nest", "Date", "age_day", "Final_age_seen", "Mass_net", "S_T", "Tar", "Treatment_Type")]
puk.subset <- puk.var %>% filter(puk.var$Final_age_seen >= 10)

summary(lmp(Tar~Treatment_Type + ChickID*age_day + Nest,data=puk.subset)) 


#puk.hatch <- puk.var %>% filter(puk.var$age_day == 0)
#puk.hatch <- na.omit(puk.hatch)
#puk.hatch1 <- puk.hatch[c("ChickID", "Nest", "age_day", "Tar", "Treatment_Type")]
#set.seed(17)
#nsim <- 1000
#res <- numeric(nsim) 
#for (i in 1:nsim) {
#  permed <- sample(nrow(puk.hatch1$Tar))
#  pdat <- transform(puk.hatch1,Tar=Tar[perm])
#  res[i] <- mean(pdat[pdat$Treatment_Type=="Control","Tar"])-
#    mean(pdat[pdat$Treatment_Type=="Experimental","Tar"])
#}                    ##receives error message 
#                    ##"replacement element 1 has 152 rows to replace 69 rows" 
#obs <- mean(puk.hatch1[puk.hatch1$Treatment_Type=="Experimental","Tar"])-
#  mean(puk.hatch1[puk.hatch1$Treatment_Type=="Control","Tar"])
#res <- c(res,obs)
#hist(res,col="gray",las=1,main="")
#abline(v=obs,col="red")
