library(lmPerm)
library(tidyverse)
puk <- read_csv("Chick_measurements_2018.csv")
## puk2 <- na.omit(puk)
## BMB: slightly cleaner to use select, and to pipe:
## puk.var <- puk2[c("ChickID", "Nest", "Date", "age_day", "Final_age_seen", "Mass_net", "S_T", "Tar", "Treatment_Type")]
## puk.subset <- puk.var %>% filter(puk.var$Final_age_seen >= 10)

puk.var <- (puk
    %>% select(ChickID, Nest, Date, age_day, Final_age_seen, Mass_net,
               S_T, Tar, Treatment_Type))

puk.subset <- puk.var %>% filter(Final_age_seen >= 10)


## BMB: why filter >= 10?
## BMB: this is a pretty difficult model to fit
summary(lmp(Tar~Treatment_Type + ChickID*age_day + Nest,data=puk.subset)) 

dim(model.matrix(~Treatment_Type + ChickID*age_day + Nest, data=puk.subset))
## 81 parameters, only 152 observations ... almost can't work.

## BMB: fixed up the stuff below

puk.hatch <- (puk.var
    %>% filter(puk.var$age_day == 0)
    %>% na.omit()
    %>% select(ChickID, Nest, age_day, Tar, Treatment_Type)
)

set.seed(17)
nsim <- 1000
res <- numeric(nsim) 
for (i in 1:nsim) {
    permed <- sample(nrow(puk.hatch))
    pdat <- transform(puk.hatch,Tar=Tar[permed])
    res[i] <- mean(pdat[pdat$Treatment_Type=="Control","Tar"])-
        mean(pdat[pdat$Treatment_Type=="Experimental","Tar"])
}
##receives error message 
##"replacement element 1 has 152 rows to replace 69 rows"
## BMB: see 'assignments' page, search for "tibble"
obs <- mean(puk.hatch$Tar[puk.hatch$Treatment_Type=="Experimental"]-
            mean(puk.hatch$Tar[puk.hatch$Treatment_Type=="Control"]))
res <- c(res,obs)
hist(res,col="gray",las=1,main="")
abline(v=obs,col="red")

## score: 2 (1=bad, 2=OK, 3=excellent)
