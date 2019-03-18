library(tidyverse)
library(lme4)
library(lmerTest)
puk_last <- read_csv("Chick_measurements_2018_last_obs.csv")
puk2 <- na.omit(puk_last)
puk.subset <- puk2
puk.subset$ttar <- log10(puk.subset$Tarsus)
puk_gro <- lmer(Tarsus ~ Hatch_spread + age_day + Hatch_order + (1|Nest), 
                data = puk.subset)
summary(puk_gro)

##I chose Tarsus for my response variable as a measure of offspring growth.
##Hatch_spread is one of my predictor variables and is my variable of interest (i.e. treatment)
##Age is another variable included as a fixed effect, since chicks were caught and measured at
##different ages. The final fixed effect is hatch order as the literature states that
##there is a signifcant hatch order effect on offspring growth, where last hatched chick grows
##slower than first hatched. I think used nest (representing social group) as a random intercept

##For this model, I chose to use only the last measurement for each chick. I have multiple
##measurements for many of the chicks, but each chick was caught a different number of times
##and at different ages (i.e. one chick may have been measured at 1 day old and 14 days old
## while another was measured at 1,6,23,46 days, etc.). Not sure how to include multiple 
##measurements for each chick. I thought it would be a nested design: 
##(1|Nest/ChickID) but it experienced issues with convergence.

##I'm not sure on the maximal model, whether there are interactions that could be included.
##So I did not leave out anything. As expected, all three Fixed effects were significant. 
##Though age and hatch order appear to have a stronger effect on offspring size/growth 
##than hatching spread. Which makes sense - a 45 day old chick will be larger than a 20 day
##old, obviously. 