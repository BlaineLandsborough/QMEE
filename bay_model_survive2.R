## Attempt at logistic regression using Bayesian modelling, with survival as a 
## binary response variable,to investigate difference in nestling survival at 60 days 
##between treatment types. Survival variable (first_sur) coded as 1 for survived and 0 
##for did not survive. Models did not converge when tested.
library(R2jags)
library(readr) ## BMB: readr is included in tidyverse
library(ggplot2)
library(lme4)
library(tidyverse)
survival <- read_csv("2018_chick_survival_v2.csv")
##GLM and GLMM
pukglm <- glm(first_sur ~ hatch_spread, data = survival, family = binomial)
summary(pukglm)
puksur <- glmer(first_sur ~ hatch_spread + (1|Nest),
                data = survival, family = binomial)
summary(puksur)
## BMB: why are you bounding logit(p[i]) between 1 and 15??
## BMB: shouldn't there be an intercept here?? otherwise you're assuming
##  prob=0.5 when hatch_spread is zero ... (I guess this is b_first_sur,
## but you didn't use it in predictions

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

## BMB: this isn't working at all because the max/min bounding is
## removing all of the information, so you're just reproducing the priors.

## BMB: did you write this from scratch?  (I'm wondering about the bounding
## stuff) It's fine to build on others' code, but if you use sources,
## please cite them ...

## I'm a little alarmed that you didn't notice that your results don't
## make any sense?

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
library("emdbook")
pukmcmc <- as.mcmc.bugs(bayoutput)
print(bmod)
traceplot(bayoutput)


library("lattice")
bayoutput <- bmod$BUGSoutput  
pukmcmc <- as.mcmc.bugs(bayoutput) 
xyplot(pukmcmc,layout=c(2,3))



densityplot(pukmcmc,layout=c(2,2))
#second chain

## BMB: you don't need to run multiple chains by hand -- that's what
## n.chains does; if you wanted 8 chains you could just say n.chains=8

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

## BMB: score 2.
