##Attempt at logistic regression using Bayesian modelling, with survival as a 
##binary response variable,to investigate difference in nestling survival at 60 days 
##between treatment types. Survival variable (first_sur) coded as 1 for survived and 0 
##for did not survive. Models did not converge when tested.
library(R2jags)
library(readr)
library(ggplot2)
library(lme4)
library(tidyverse)
survival <- read_csv("2018_chick_survival_v2.csv")
##GLM and GLMM
pukglm <- glm(first_sur ~ hatch_spread, data = survival, family = binomial)
summary(pukglm)
puksur <- glmer(first_sur ~ hatch_spread + (1|Nest), data = survival, family = binomial)
summary(puksur)
model.code="
model{
for (i in 1:N) {
first_sur[i] ~ dbern(p[i])
logit(p[i]) <- max(15,min(1,b_hatch_spread*hatch_spread[i]))
}
b_first_sur ~ dnorm(0,0.0001)
b_hatch_spread ~ dnorm(0,0.0001)
}
"
writeLines(model.code,con="pukmodel.bug")
N <- nrow(survival)
bmod <- with(survival, jags(model.file = 'pukmodel.bug'
                                , parameters=c("b_first_sur","b_hatch_spread")
                                , data = list('first_sur' = first_sur, 'hatch_spread' = 
                                                hatch_spread, 'N'=N)
                                , n.chains = 4
                                , inits=NULL
))
bayoutput <- bmod$BUGSoutput  
pukmcmc <- as.mcmc.bugs(bayoutput)
print(bmod)
traceplot(bayoutput)





library("emdbook")
library("lattice")
bayoutput <- bmod$BUGSoutput  
pukmcmc <- as.mcmc.bugs(bayoutput) 
xyplot(pukmcmc,layout=c(2,3))



densityplot(pukmcmc,layout=c(2,2))
#second chain

sec.code="
model{
for (i in 1:N) {
first_sur[i] ~ dbern(p[i])
logit(p[i]) <- max(15,min(1,b_hatch_spread*hatch_spread[i]))
}
b_first_sur ~ dnorm(0,1)
b_hatch_spread ~ dnorm(0,1)
}
"
writeLines(sec.code,con="pukmodel2.bug")
N <- nrow(survival)
bmod2 <- with(survival, jags(model.file = 'pukmodel2.bug'
                            , parameters=c("b_first_sur","b_hatch_spread")
                            , data = list('first_sur' = first_sur, 'hatch_spread' = 
                                            hatch_spread, 'N'=N)
                            , n.chains = 4
                            , inits=NULL
))
bayoutput2 <- bmod2$BUGSoutput  
combinedchains <- as.mcmc.list(bayoutput, bayoutput2)
plot(combinedchains)


