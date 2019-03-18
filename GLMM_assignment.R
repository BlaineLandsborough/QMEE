library(ggplot2)
library(lme4)
library(tidyverse)
survival <- read_csv("2018_chick_survival_v2.csv")

puksur <- glmer(first_sur ~ hatch_spread + (1|Nest), data = survival, 
                family = binomial(link = "logit"))
summary(puksur)

###The model produced a singular fit since Nest (representing group) had a variance of 0, 
##however I'm not sure if that is an issue. I'm not sure how to assess goodness of fit
##for a binomial model, some searching on the web only told me that it's a difficult problem.
##It is a GLMM with first_sur representing whether the bird was alive at the first survey
##this is coded as 0 and 1. The model revealed hatch_spread to have a (significant)
##negative effect on survival. 